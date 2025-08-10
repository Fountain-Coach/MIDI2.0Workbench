/**
 * Swift code generator from contract/midi2.json.
 * Emits fully implemented encode/decode structs for each message.
 */
const fs = require('fs');
const path = require('path');

function readJSON(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }
function ensureDir(p) { fs.mkdirSync(p, { recursive: true }); }

function typeForWidth(width) {
  if (width <= 8) return 'UInt8';
  if (width <= 16) return 'UInt16';
  if (width <= 32) return 'UInt32';
  return 'UInt64';
}

function swiftTypeName(name) {
  const parts = name.split(/[^A-Za-z0-9]+/).filter(Boolean);
  return parts.map(p => p[0].toUpperCase() + p.slice(1)).join('');
}

function swiftPropName(name) {
  const clean = name.replace(/[^A-Za-z0-9]+/g, ' ');
  const parts = clean.trim().split(/\s+/);
  const cc = parts.map((p, i) => i === 0 ? p.toLowerCase() : (p[0].toUpperCase() + p.slice(1))).join('');
  const keywords = new Set(['class','struct','protocol','enum','extension','import','let','var','if','else','switch','case','default','return','in','for','while','do','catch']);
  return keywords.has(cc) ? `_${cc}` : cc;
}

function genMessageSwift(msg) {
  const typeName = swiftTypeName(msg.name);
  const container = msg.container; // UMP32|UMP64|UMP128
  const helper = container === 'UMP32' ? { set: 'setBits32', get: 'getBits32', cType: 'UMP32', raw: 'UInt32' }
                : container === 'UMP64' ? { set: 'setBits', get: 'getBits', cType: 'UMP64', raw: 'UInt64' }
                : { set: 'setBits128', get: 'getBits128', cType: 'UMP128', raw: null };

  const varFields = msg.fields.filter(f => f.value === undefined);
  const constFields = msg.fields.filter(f => f.value !== undefined);

  // properties
  const props = varFields.map(f => `    public var ${swiftPropName(f.name)}: ${typeForWidth(f.bitWidth)}`).join('\n');

  // init with preconditions
  const initParams = varFields.map(f => `${swiftPropName(f.name)}: ${typeForWidth(f.bitWidth)}`).join(', ');
  const preconds = varFields.map(f => {
    const upper = f.range ? f.range[1] : (Math.pow(2, f.bitWidth) - 1);
    return `        precondition(${swiftPropName(f.name)} <= ${upper})`;
  }).join('\n');
  const assigns = varFields.map(f => `        self.${swiftPropName(f.name)} = ${swiftPropName(f.name)}`).join('\n');

  // encode body
  let encodeLines = [];
  if (container === 'UMP32') encodeLines.push(`        var raw: UInt32 = 0`);
  else if (container === 'UMP64') encodeLines.push(`        var raw: UInt64 = 0`);
  else encodeLines.push(`        var lo: UInt64 = 0`, `        var hi: UInt64 = 0`);
  for (const f of msg.fields) {
    const valExpr = f.value !== undefined ? String(f.value) : `UInt64(${swiftPropName(f.name)})`;
    if (container === 'UMP128') {
      encodeLines.push(`        { let tmp = setBits128(lo, hi, ${valExpr}, offset: ${f.bitOffset}, width: ${f.bitWidth}); lo = tmp.0; hi = tmp.1 }`);
    } else {
      const cast = container === 'UMP32' ? `UInt32(${valExpr})` : `UInt64(${valExpr})`;
      encodeLines.push(`        raw = ${helper.set}(raw, value: ${cast}, offset: ${f.bitOffset}, width: ${f.bitWidth})`);
    }
  }
  if (container === 'UMP128') encodeLines.push(`        return UMP128(lo: lo, hi: hi)`);
  else encodeLines.push(`        return ${helper.cType}(raw: raw)`);

  // decode
  const guards = constFields.map(f => {
    if (container === 'UMP128') return `        if ${helper.get}(ump.lo, ump.hi, offset: ${f.bitOffset}, width: ${f.bitWidth}) != ${f.value} { return nil }`;
    return `        if ${helper.get}(ump.raw, offset: ${f.bitOffset}, width: ${f.bitWidth}) != ${f.value} { return nil }`;
  }).join('\n');
  const extracts = varFields.map(f => {
    const cast = typeForWidth(f.bitWidth);
    if (container === 'UMP128') return `        let ${swiftPropName(f.name)} = ${cast}(${helper.get}(ump.lo, ump.hi, offset: ${f.bitOffset}, width: ${f.bitWidth}))`;
    return `        let ${swiftPropName(f.name)} = ${cast}(${helper.get}(ump.raw, offset: ${f.bitOffset}, width: ${f.bitWidth}))`;
  }).join('\n');
  const ctorArgs = varFields.map(f => `${swiftPropName(f.name)}: ${swiftPropName(f.name)}`).join(', ');

  // Doc comment and provenance
  const prov = msg.provenance || {}; const provLine = prov.file ? `${prov.file}${prov.line ? `:${prov.line}` : ''}` : 'unknown';

  // Optional enums/helpers
  let helpers = '';
  const formField = msg.fields.find(f => f.name === 'form' && f.bitWidth === 2);
  if (formField) {
    helpers += `\n    public enum Form: UInt8 { case complete = 0, start = 1, cont = 2, end = 3 }\n`;
    // Convenience init using enum
    const idx = varFields.findIndex(f => f.name === 'form');
    if (idx !== -1) {
      const varParams = varFields.map(f => `${swiftPropName(f.name)}: ${typeForWidth(f.bitWidth)}`);
      const enumParams = varParams.map(p => p).join(', ');
      const enumAssigns = varFields.map(f => `        self.${swiftPropName(f.name)} = ${swiftPropName(f.name)}`).join('\n');
      // Additional initializer taking formEnum
      helpers += `\n    public init(${varFields.map(f => f.name === 'form' ? `formEnum: Form` : `${swiftPropName(f.name)}: ${typeForWidth(f.bitWidth)}`).join(', ')}) {\n`;
      // Preconditions
      helpers += varFields.map(f => {
        if (f.name === 'form') return '';
        const upper = f.range ? f.range[1] : (Math.pow(2, f.bitWidth) - 1);
        return `        precondition(${swiftPropName(f.name)} <= ${upper})`;
      }).filter(Boolean).join('\n');
      helpers += `\n        self.${swiftPropName('form')} = formEnum.rawValue\n`;
      helpers += varFields.filter(f => f.name !== 'form').map(f => `        self.${swiftPropName(f.name)} = ${swiftPropName(f.name)}`).join('\n');
      helpers += `\n    }\n`;
    }
  }

  const header = `import Foundation\nimport Core\n\n/// ${msg.name} (${container})\n/// Source: ${provLine}\npublic struct ${typeName}: Equatable {`;

  return `${header}\n${props ? props + '\n' : ''}    public init(${initParams}) {\n${preconds}\n${assigns}\n    }\n${helpers}\n    public func encode() -> ${helper.cType} {\n${encodeLines.join('\n')}\n    }\n\n    public static func decode(_ ump: ${helper.cType}) -> ${typeName}? {\n${guards}\n${extracts}\n        return ${typeName}(${ctorArgs})\n    }\n}\n`;
}

function main() {
  const root = process.env.WORKBENCH_ROOT || process.cwd();
  const contract = readJSON(path.join(root, 'contract', 'midi2.json'));
  const outDir = path.join(root, 'swift', 'Midi2Swift', 'Sources', 'UMP', 'Generated');
  ensureDir(outDir);
  // Clean existing generated files
  for (const f of fs.readdirSync(outDir)) {
    if (f.endsWith('.swift')) fs.unlinkSync(path.join(outDir, f));
  }
  const files = [];
  for (const msg of contract.messages) {
    const swift = genMessageSwift(msg);
    const fname = swiftTypeName(msg.name) + '.swift';
    fs.writeFileSync(path.join(outDir, fname), swift);
    files.push(fname);
  }
  console.log(`Generated ${files.length} Swift files in ${outDir}`);
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}
