/**
 * Generate UMPAnyMessage enum and UMPDecoder decode helpers.
 * Groups messages by container and messageType (when constant),
 * then attempts per-group decode using generated static decode methods.
 */
const fs = require('fs');
const path = require('path');

function readJSON(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }
function ensureDir(p) { fs.mkdirSync(p, { recursive: true }); }
function swiftTypeName(name){ return name.split(/[^A-Za-z0-9]+/).filter(Boolean).map(p=>p[0].toUpperCase()+p.slice(1)).join(''); }

function main(){
  const root = process.env.WORKBENCH_ROOT || process.cwd();
  const contract = readJSON(path.join(root, 'contract', 'midi2.json'));
  const outDir = path.join(root, 'swift', 'Midi2Swift', 'Sources', 'UMP', 'Generated');
  ensureDir(outDir);

  // Build groups by container -> messageTypeValue (string) -> [messages]
  const groups = { UMP32: new Map(), UMP64: new Map(), UMP128: new Map() };
  for (const msg of contract.messages) {
    const container = msg.container;
    if (!groups[container]) continue;
    const mtField = (msg.fields || []).find(f => f.name === 'messageType');
    const mt = (mtField && mtField.value !== undefined) ? String(mtField.value) : 'any';
    const m = groups[container];
    if (!m.has(mt)) m.set(mt, []);
    m.get(mt).push(msg);
  }

  // Enum cases
  const seenTypes = new Set();
  const allTypes = [];
  for (const m of contract.messages) {
    const t = swiftTypeName(m.name);
    if (!seenTypes.has(t)) { seenTypes.add(t); allTypes.push(t); }
  }
  const enumCases = allTypes.map(t => `    case ${t}(${t})`).join('\n');

  // Create per-container decode body
  function constScore(msg){
    let score = 0;
    for (const f of (msg.fields||[])) { if (f.value !== undefined) score++; }
    return score;
  }

  function genTryList(msgs, container){
    const list = [];
    // Best-effort: try more-specific messages (more constant fields) first
    const ordered = [...msgs].sort((a,b)=> constScore(b)-constScore(a) || swiftTypeName(a.name).localeCompare(swiftTypeName(b.name)));
    for (const msg of ordered) {
      const t = swiftTypeName(msg.name);
      const consts = (msg.fields||[]).filter(f=>f.value!==undefined);
      if (consts.length>0) {
        const conds = consts.map(f=>{
          if (container==='UMP32') return `getBits32(ump.raw, offset: ${f.bitOffset}, width: ${f.bitWidth}) == ${f.value}`;
          if (container==='UMP64') return `getBits(ump.raw, offset: ${f.bitOffset}, width: ${f.bitWidth}) == ${f.value}`;
          return `getBits128(ump.lo, ump.hi, offset: ${f.bitOffset}, width: ${f.bitWidth}) == ${f.value}`;
        }).join(' && ');
        list.push(`        if (${conds}) { if let v = ${t}.decode(ump) { return .${t}(v) } }`);
      } else {
        list.push(`        if let v = ${t}.decode(ump) { return .${t}(v) }`);
      }
    }
    list.push('        return nil');
    return list.join('\n');
  }

  function partitionByConst(msgs, fieldName){
    const by = new Map();
    const rest = [];
    for (const m of msgs) {
      const f = (m.fields||[]).find(ff=>ff.name===fieldName && ff.value!==undefined);
      if (f) {
        const k = String(f.value);
        if (!by.has(k)) by.set(k, []);
        by.get(k).push(m);
      } else rest.push(m);
    }
    return { by, rest };
  }

  function genSwitch(container){
    const m = groups[container];
    const entries = [];
    // Sort keys with numeric mt first; place 'any' last
    const keys = Array.from(m.keys()).sort((a,b)=>{
      if (a==='any') return 1; if (b==='any') return -1; return Number(a)-Number(b);
    });
    for (const key of keys) {
      const msgs = m.get(key);
      if (key === 'any') {
        entries.push(`        default:\n${genTryList(msgs, container)}`);
        continue;
      }
      // Specialized outer prefilters for known families
      if (container === 'UMP64' && key === '3') { // SysEx7: form at [8..11]
        const { by, rest } = partitionByConst(msgs, 'form');
        const cases = Array.from(by.keys()).sort((a,b)=>Number(a)-Number(b)).map(v=>{
          return `        case ${v}:\n${genTryList(by.get(v), container)}`;
        }).join('\n');
        entries.push(`        case ${key}:\n            let form = getBits(ump.raw, offset: 8, width: 4)\n            switch form {\n${cases}\n            default: break\n            }\n${genTryList(rest, container)}`);
        continue;
      }
      if (container === 'UMP128' && key === '5') { // SysEx8/MDS: form at [8..11]
        const { by, rest } = partitionByConst(msgs, 'form');
        const cases = Array.from(by.keys()).sort((a,b)=>Number(a)-Number(b)).map(v=>{
          return `        case ${v}:\n${genTryList(by.get(v), container)}`;
        }).join('\n');
        entries.push(`        case ${key}:\n            let form = getBits128(ump.lo, ump.hi, offset: 8, width: 4)\n            switch form {\n${cases}\n            default: break\n            }\n${genTryList(rest, container)}`);
        continue;
      }
      if (container === 'UMP128' && key === '15') { // Endpoint: form 2-bit at [4..5], status10 at [6..15]
        // First group by form
        const { by: byForm, rest: restForm } = partitionByConst(msgs, 'form');
        const formCases = [];
        for (const [formVal, msgsForForm] of Array.from(byForm.entries()).sort((a,b)=>Number(a[0])-Number(b[0]))) {
          // For each form, further group by status10 constant
          const byStatus = new Map();
          const others = [];
          for (const mm of msgsForForm) {
            const st = (mm.fields||[]).find(ff=>ff.name==='status10' && ff.value!==undefined);
            if (st) { const k = String(st.value); if(!byStatus.has(k)) byStatus.set(k, []); byStatus.get(k).push(mm); } else { others.push(mm); }
          }
          const statusCases = Array.from(byStatus.keys()).sort((a,b)=>Number(a)-Number(b)).map(v=>{
            return `            case ${v}:\n${genTryList(byStatus.get(v), container)}`;
          }).join('\n');
          const statusSwitch = statusCases.length ? `            switch status10 {\n${statusCases}\n            default: break\n            }\n` : '';
          formCases.push(`        case ${formVal}:\n            let status10 = getBits128(ump.lo, ump.hi, offset: 6, width: 10)\n${statusSwitch}${genTryList(others, container)}`);
        }
        entries.push(`        case ${key}:\n            let form2 = getBits128(ump.lo, ump.hi, offset: 4, width: 2)\n            switch form2 {\n${formCases.join('\n')}\n            default: break\n            }\n${genTryList(restForm, container)}`);
        continue;
      }
      if (container === 'UMP128' && key === '13') { // Flex Data: form 2-bit at [12..13]
        const { by, rest } = partitionByConst(msgs, 'form');
        const cases = Array.from(by.keys()).sort((a,b)=>Number(a)-Number(b)).map(v=>{
          return `        case ${v}:\n${genTryList(by.get(v), container)}`;
        }).join('\n');
        entries.push(`        case ${key}:\n            let form2 = getBits128(ump.lo, ump.hi, offset: 12, width: 2)\n            switch form2 {\n${cases}\n            default: break\n            }\n${genTryList(rest, container)}`);
        continue;
      }
      // Default: fall back to best-effort ordered attempts
      entries.push(`        case ${key}:\n${genTryList(msgs, container)}`);
    }
    const getMt = container==='UMP32' ? `let mt = getBits32(ump.raw, offset: 0, width: 4)`
               : container==='UMP64' ? `let mt = getBits(ump.raw, offset: 0, width: 4)`
               : `let mt = getBits128(ump.lo, ump.hi, offset: 0, width: 4)`;
    return `${getMt}
        switch mt {
${entries.join('\n')}
        }`;
  }

  const body32 = genSwitch('UMP32');
  const body64 = genSwitch('UMP64');
  const body128 = genSwitch('UMP128');

  const file = `import Foundation\nimport Core\n\npublic enum UMPAnyMessage: Equatable {\n${enumCases}\n}\n\npublic enum UMPDecoder {\n    public static func decode(_ ump: UMP32) -> UMPAnyMessage? {\n${body32}\n    }\n    public static func decode(_ ump: UMP64) -> UMPAnyMessage? {\n${body64}\n    }\n    public static func decode(_ ump: UMP128) -> UMPAnyMessage? {\n${body128}\n    }\n}\n`;

  fs.writeFileSync(path.join(outDir, 'UMPAnyMessage.swift'), file);
  console.log('Generated dispatch:', path.join(outDir, 'UMPAnyMessage.swift'));
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}
