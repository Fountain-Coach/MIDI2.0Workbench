/**
 * Static extractor for MIDI 2.0 Workbench (no execution).
 *
 * Reads JS source files and extracts a machine contract and golden vectors
 * by text-parsing, without requiring or running Workbench code.
 *
 * Coverage (static-only):
 * - Utility (UMP32), System Common/RealTime (UMP32), MIDI 1.0 CV (UMP32)
 * - SysEx7 (UMP64), MIDI 2.0 CV (UMP64)
 * - Flex Data / Endpoint families captured structurally
 *
 * Vectors emitted for: MIDI 2.0 CV (selected), System (selected), MIDI 1.0 CV (selected)
 */

const fs = require('fs');
const path = require('path');

function readFile(p) {
  return fs.readFileSync(p, 'utf8');
}

function ensureDir(p) {
  fs.mkdirSync(p, { recursive: true });
}

function isoNow() {
  return new Date().toISOString();
}

function toHex(n, width) {
  const s = (BigInt(n) & ((1n << BigInt(width)) - 1n)).toString(16).toUpperCase();
  return '0x' + s;
}

function walkBalanced(src, startIdx, openChar, closeChar) {
  let i = startIdx, depth = 0;
  for (; i < src.length; i++) {
    const ch = src[i];
    if (ch === openChar) depth++;
    else if (ch === closeChar) {
      depth--;
      if (depth === 0) return i + 1; // position after close
    }
  }
  return -1;
}

function extractPartsArrayText(sectionText, anchorIdx) {
  const partsStart = sectionText.indexOf('parts:', anchorIdx);
  if (partsStart === -1) return null;
  const arrStart = sectionText.indexOf('[', partsStart);
  const arrEnd = walkBalanced(sectionText, arrStart, '[', ']');
  if (arrStart === -1 || arrEnd === -1) return null;
  return sectionText.slice(arrStart, arrEnd);
}

function parseParts(partsText) {
  const partRegex = /\{[^}]*range:\s*\[(\d+)\s*,\s*(\d+)\][^}]*title:\s*'([^']+)'[^}]*\}/g;
  const fields = [];
  let m;
  while ((m = partRegex.exec(partsText)) !== null) {
    const from = parseInt(m[1], 10);
    const to = parseInt(m[2], 10);
    const title = m[3];
    fields.push({ title, from, to });
  }
  return fields;
}

function normalizeFieldName(title) {
  const nameMap = {
    'Channel': 'channel',
    'Group': 'group',
    'Note Number': 'noteNumber',
    'Velocity': 'velocity',
    'Attribute Type': 'attributeType',
    'Attribute': 'attribute',
    'Bank Valid': 'bankValid',
    'Program': 'program',
    'Index': 'index',
    'Value': 'value',
    'Pitch': 'pitch',
    'Sender Clock Time': 'senderClockTime',
    'Sender Clock Timestamp': 'senderClockTimestamp',
    'Number of Ticks Per Quarter Note': 'tpqn',
    'Number of Ticks Since Last Event': 'deltaTicks',
    '# of bytes': 'byteCount',
    'mds id': 'mdsId',
  };
  return nameMap[title] || title.replace(/[^A-Za-z0-9_]/g, '').replace(/^[^A-Za-z]+/, '');
}

function mapFields(fields) {
  return fields.map(f => ({
    name: normalizeFieldName(f.title),
    bitOffset: f.from,
    bitWidth: f.to - f.from + 1,
  }));
}

function addHeaderForFamily(familyTitle, statusKey, opts = {}) {
  // Inferred mapping from UMP spec
  const header = [];
  const family = familyTitle;
  const keyVal = statusKey != null ? statusKey : null;
  if (family.includes('Utility')) {
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x0 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'statusCode', bitOffset: 8, bitWidth: 4, value: keyVal });
  } else if (family.includes('System Real Time') || family.includes('System Common')) {
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x1 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'statusByte', bitOffset: 8, bitWidth: 8, value: keyVal });
  } else if (family.includes('MIDI 1.0 Channel Voice')) {
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x2 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'statusNibble', bitOffset: 8, bitWidth: 4, value: keyVal });
  } else if (family.includes('MIDI 2.0 Channel Voice')) {
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x4 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'statusNibble', bitOffset: 8, bitWidth: 4, value: keyVal });
  } else if (family.includes('SysEx8') || family.includes('MDS')) {
    // UMP 128-bit SysEx8 and Mixed Data Set (Message Type = 0x5)
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x5 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'sysex8Form', bitOffset: 8, bitWidth: 4, value: keyVal });
  } else if (family === 'SysEx' || family.includes('SysEx')) {
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0x3 });
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    if (keyVal != null) header.push({ name: 'sysexForm', bitOffset: 8, bitWidth: 4, value: keyVal });
  } else if (family.includes('Flex Data')) {
    // Flex Data Messages (Message Type = 0xD), address nibbles: Channel then Group, then 2-bit form
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0xD });
    header.push({ name: 'channel', bitOffset: 4, bitWidth: 4, range: [0, 15] });
    header.push({ name: 'group', bitOffset: 8, bitWidth: 4, range: [0, 15] });
    header.push({ name: 'form', bitOffset: 12, bitWidth: 2, range: [0, 3] });
    // Status MSB/LSB injected later when known
  } else if (family.includes('MIDI Endpoint')) {
    // Stream Messages (Message Type = 0xF). No group nibble; 2-bit form + 10-bit status code.
    header.push({ name: 'messageType', bitOffset: 0, bitWidth: 4, value: 0xF });
    header.push({ name: 'form', bitOffset: 4, bitWidth: 2, range: [0, 3] });
    if (keyVal != null) header.push({ name: 'status10', bitOffset: 6, bitWidth: 10, value: keyVal });
  } else {
    // Unknown families: include group by default for UMP, omit fixed messageType to avoid guessing
    header.push({ name: 'group', bitOffset: 4, bitWidth: 4, range: [0, 15] });
  }
  return header;
}

function parseAllFromMessageTypes(src, filePath) {
  const outMessages = [];
  const topIdx = src.indexOf('exports.messageType');
  if (topIdx === -1) return outMessages;
  const arrStart = src.indexOf('[', topIdx);
  const arrEnd = walkBalanced(src, arrStart, '[', ']');
  const arrText = src.slice(arrStart, arrEnd);

  // Iterate family objects roughly by scanning for title: and matching braces
  let pos = 0;
  while (pos < arrText.length) {
    const titleIdx = arrText.indexOf('title:', pos);
    if (titleIdx === -1) break;
    const familyTitleMatch = /title:\s*'([^']+)'/.exec(arrText.slice(titleIdx));
    if (!familyTitleMatch) break;
    const familyTitle = familyTitleMatch[1];
    const objStart = arrText.lastIndexOf('{', titleIdx);
    const objEnd = walkBalanced(arrText, objStart, '{', '}');
    if (objStart === -1 || objEnd === -1) break;
    const familyObj = arrText.slice(objStart, objEnd);
    pos = objEnd;

    // bits
    const bitsMatch = /bits:\s*(\d+)/.exec(familyObj);
    const bits = bitsMatch ? parseInt(bitsMatch[1], 10) : 64;
    const container = bits === 32 ? 'UMP32' : bits === 64 ? 'UMP64' : 'UMP128';

    // status map within family
    const statusIdx = familyObj.indexOf('status:');
    if (statusIdx === -1) continue;
    const statusObjStart = familyObj.indexOf('{', statusIdx);
    const statusObjEnd = walkBalanced(familyObj, statusObjStart, '{', '}');
    const statusObjText = familyObj.slice(statusObjStart, statusObjEnd);

    if (familyTitle.includes('Flex Data')) {
      // Recursive handling for Flex Data nested status
      function forEachStatus(objText, titleStack = [], acc = {}) {
        const re = /(0x[0-9A-Fa-f]+|0b[01_]+|\d+)\s*:\s*\{/g;
        let em;
        while ((em = re.exec(objText)) !== null) {
          const keyRaw = em[1];
          const keyVal = keyRaw.startsWith('0x') ? parseInt(keyRaw, 16)
            : keyRaw.startsWith('0b') ? parseInt(keyRaw.replace(/_/g, '').slice(2), 2)
            : parseInt(keyRaw, 10);
          const entryStartInStatus = em.index + em[0].length - 1; // at '{'
          const entryEndInStatus = walkBalanced(objText, entryStartInStatus, '{', '}');
          const entryObj = objText.slice(entryStartInStatus, entryEndInStatus);
          const titleMatch = /title:\s*'([^']+)'/.exec(entryObj);
          const msgTitle = titleMatch ? titleMatch[1] : `${familyTitle} ${toHex(keyVal, 8)}`;
          const partsText = extractPartsArrayText(entryObj, 0);
          const nestedStatusIdx = entryObj.indexOf('status:');

          const nextTitleStack = titleStack.concat([msgTitle]);
          const nextAcc = { ...acc };
          if (nextAcc.flexMSB === undefined) nextAcc.flexMSB = keyVal & 0xFF; else nextAcc.flexLSB = keyVal & 0xFF;

          if (nestedStatusIdx !== -1) {
            const nestedStart = entryObj.indexOf('{', nestedStatusIdx);
            const nestedEnd = walkBalanced(entryObj, nestedStart, '{', '}');
            const nestedText = entryObj.slice(nestedStart, nestedEnd);
            forEachStatus(nestedText, nextTitleStack, nextAcc);
            continue;
          }

          let parts = partsText ? parseParts(partsText) : [];
          const mapped = mapFields(parts);
          let header = addHeaderForFamily(familyTitle, null);
          if (nextAcc.flexMSB !== undefined) header.push({ name: 'statusMSB', bitOffset: 16, bitWidth: 8, value: nextAcc.flexMSB });
          if (nextAcc.flexLSB !== undefined) header.push({ name: 'statusLSB', bitOffset: 24, bitWidth: 8, value: nextAcc.flexLSB });
          const line = src.slice(0, topIdx).split(/\r?\n/).length;
          const name = `${familyTitle.replace(/[^A-Za-z0-9]/g, '')}.${nextTitleStack.map(t => t.replace(/[^A-Za-z0-9]/g, '')).join('')}`;
          outMessages.push({ name, container, fields: [...header, ...mapped], invariants: [`bits_sum <= ${bits}`], provenance: { file: path.relative(process.cwd(), filePath), line } });
        }
      }
      forEachStatus(statusObjText);
    } else {
      // Flat iteration for other families
      const entryRegexFlat = /(0x[0-9A-Fa-f]+|0b[01_]+|\d+)\s*:\s*\{/g;
      let em;
      while ((em = entryRegexFlat.exec(statusObjText)) !== null) {
        const keyRaw = em[1];
        const keyVal = keyRaw.startsWith('0x') ? parseInt(keyRaw, 16)
          : keyRaw.startsWith('0b') ? parseInt(keyRaw.replace(/_/g, '').slice(2), 2)
          : parseInt(keyRaw, 10);
        const entryStartInStatus = em.index + em[0].length - 1;
        const entryEndInStatus = walkBalanced(statusObjText, entryStartInStatus, '{', '}');
        const entryObj = statusObjText.slice(entryStartInStatus, entryEndInStatus);
        const titleMatch = /title:\s*'([^']+)'/.exec(entryObj);
        const msgTitle = titleMatch ? titleMatch[1] : `${familyTitle} ${toHex(keyVal, 8)}`;
        const partsText = extractPartsArrayText(entryObj, 0);
        let parts = partsText ? parseParts(partsText) : [];
        if (parts.length === 0 && familyTitle === 'SysEx') {
          parts = [
            { title: '# of bytes', from: 12, to: 15 },
            { title: 'Byte 1', from: 17, to: 23 },
            { title: 'Byte 2', from: 25, to: 31 },
            { title: 'Byte 3', from: 33, to: 39 },
            { title: 'Byte 4', from: 41, to: 47 },
            { title: 'Byte 5', from: 49, to: 55 },
            { title: 'Byte 6', from: 57, to: 63 },
          ];
        }
        const mapped = mapFields(parts);
        const header = addHeaderForFamily(familyTitle, keyVal);
        const line = src.slice(0, topIdx).split(/\r?\n/).length;
        const name = `${familyTitle.replace(/[^A-Za-z0-9]/g, '')}.${msgTitle.replace(/[^A-Za-z0-9]/g, '')}`;
        outMessages.push({ name, container, fields: [...header, ...mapped], invariants: [`bits_sum <= ${bits}`], provenance: { file: path.relative(process.cwd(), filePath), line } });
      }
    }
  }

  return outMessages;
}

function buildGoldenVectorsForNoteOn(messageDef) {
  function fieldRange(f) {
    if (f.range) return f.range;
    // defaults based on width
    const max = (1n << BigInt(f.bitWidth)) - 1n;
    return [0, Number(max)];
  }

  function encode(fields) {
    let raw = 0n;
    for (const f of messageDef.fields) {
      const v = fields.hasOwnProperty(f.name) ? BigInt(fields[f.name]) : (f.value !== undefined ? BigInt(f.value) : 0n);
      if (f.value !== undefined && v !== BigInt(f.value)) {
        throw new Error(`Field ${f.name} must equal ${f.value}`);
      }
      const mask = (1n << BigInt(f.bitWidth)) - 1n;
      raw |= (v & mask) << BigInt(f.bitOffset);
    }
    return raw;
  }

  const base = {
    messageType: 0x4,
    group: 0,
    statusNibble: 0x9,
    channel: 0,
    noteNumber: 60,
    attributeType: 0,
    velocity: 0,
    attribute: 0,
  };

  const cases = [];
  // min-max for key ranged fields
  const varyFields = ['group','channel','noteNumber','velocity'];
  for (const fname of varyFields) {
    const f = messageDef.fields.find(x => x.name === fname);
    if (!f) continue;
    const [min, max] = fieldRange(f);
    const minFields = { ...base, [fname]: min };
    const maxFields = { ...base, [fname]: max };
    cases.push({ case: `${fname}_min`, raw: '0x' + encode(minFields).toString(16).toUpperCase(), decoded: minFields });
    cases.push({ case: `${fname}_max`, raw: '0x' + encode(maxFields).toString(16).toUpperCase(), decoded: maxFields });
  }

  // A typical middle case
  const mid = { ...base, group: 2, channel: 1, noteNumber: 64, velocity: 0x1234 };
  cases.push({ case: 'typical', raw: '0x' + encode(mid).toString(16).toUpperCase(), decoded: mid });

  return cases;
}

function main() {
  const workbenchRoot = process.env.WORKBENCH_ROOT || process.cwd();

  const contractDir = path.join(workbenchRoot, 'contract');
  const vectorsDir = path.join(workbenchRoot, 'vectors', 'golden');
  ensureDir(contractDir);
  ensureDir(vectorsDir);

  const messageTypesPath = path.join(workbenchRoot, 'libs', 'messageTypes.js');
  const src = readFile(messageTypesPath);

  const messages = parseAllFromMessageTypes(src, messageTypesPath);
  const enums = parseSpecEnums(workbenchRoot);

  const contract = {
    $schema: 'https://fountain.example/schemas/midi2-contract.schema.json',
    meta: { workbench_commit: 'unknown', generated_at: isoNow() },
    enums,
    messages,
    state_machines: parseCIStateMachines(workbenchRoot),
    resources: {
      Profiles: parseProfiles(workbenchRoot),
      PropertyExchange: { schemas: parsePESchemas(workbenchRoot) }
    },
  };

  fs.writeFileSync(path.join(contractDir, 'midi2.json'), JSON.stringify(contract, null, 2));

  // Emit vectors for a few well-understood families
  const cv2NoteOn = messages.find(m => m.name.startsWith('MIDI20ChannelVoiceMessages.NoteOn'))
    || messages.find(m => m.name.endsWith('.NoteOn') && m.container === 'UMP64');
  if (cv2NoteOn) {
    const vectors = buildGoldenVectorsForNoteOn(cv2NoteOn);
    fs.writeFileSync(path.join(vectorsDir, 'ump_channel_voice.json'), JSON.stringify(vectors, null, 2));
  }

  // Basic System Common example vector: MTC Quarter Frame (0xF1) with data nibble 0
  const sysMtc = messages.find(m => m.name.includes('SystemRealTimeandSystemCommonMessages') && m.name.includes('MIDITimeCode'));
  if (sysMtc) {
    const fields = Object.fromEntries(sysMtc.fields.map(f => [f.name, f.value ?? 0]));
    const raw = sysEncode(sysMtc, fields);
    fs.writeFileSync(path.join(vectorsDir, 'ump_system.json'), JSON.stringify([
      { case: 'mtc_qf_zero', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields }
    ], null, 2));
  }

  // CI statechart vectors (simple sequences)
  const ciVectors = buildCIVectors(contract.state_machines);
  if (ciVectors && ciVectors.length) {
    fs.writeFileSync(path.join(vectorsDir, 'ci_statechart.json'), JSON.stringify(ciVectors, null, 2));
  }

  // Auto-generate lightweight vectors for broad message coverage (min/max on first 2 variable fields)
  const autoVectors = buildAutoVectors(messages);
  if (autoVectors.length) {
    fs.writeFileSync(path.join(vectorsDir, 'auto_vectors.json'), JSON.stringify(autoVectors, null, 2));
  }

  // MIDI 1.0 CV Program Change typical
  const m1pc = messages.find(m => m.name.includes('MIDI10ChannelVoiceMessages.ProgramChangeMessage') && m.container === 'UMP32');
  if (m1pc) {
    const fields = Object.fromEntries(m1pc.fields.map(f => [f.name, f.value ?? 0]));
    fields.group = 0; fields.channel = 0; fields.program = 5;
    const raw = sysEncode(m1pc, fields);
    fs.writeFileSync(path.join(vectorsDir, 'ump_utility.json'), JSON.stringify([
      { case: 'midi1_program_change_5', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields }
    ], null, 2));
  }

  // SysEx7 Complete example (6 bytes)
  const syxComplete = messages.find(m => m.name.includes('SysEx') && m.name.includes('CompleteSystemExclusiveMessageinOnePacket'));
  if (syxComplete) {
    const fields = Object.fromEntries(syxComplete.fields.map(f => [f.name, f.value ?? 0]));
    fields.group = 0; fields.sysexForm = 0; fields.byteCount = 6;
    fields.Byte1 = 0x7E; fields.Byte2 = 0x7F; fields.Byte3 = 0x09; fields.Byte4 = 0x01; fields.Byte5 = 0x02; fields.Byte6 = 0x03;
    const raw = sysEncode(syxComplete, fields);
    fs.writeFileSync(path.join(vectorsDir, 'ump_sysex.json'), JSON.stringify([
      { case: 'sysex_complete_6bytes', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields }
    ], null, 2));
  }

  // Endpoint 128-bit targeted vectors
  const endpointInfo = messages.find(m => m.name.includes('MIDI Endpoint') && m.name.includes('Info Notify'));
  const endpointDevInfo = messages.find(m => m.name.includes('MIDI Endpoint') && m.name.includes('Device Info Notify'));
  const endpointName = messages.find(m => m.name.includes('MIDI Endpoint') && m.name.includes('Name Notify'));
  const endpointVectors = [];
  if (endpointInfo) {
    const fields = Object.fromEntries(endpointInfo.fields.map(f => [f.name, f.value ?? 0]));
    fields.group = 0; fields.UMPVersionMajor = 1; fields.UMPVersionMinor = 0; fields.StaticFunctionBlocks = 1; fields.NumberofFunctionBlocks = 2;
    const raw = sysEncode(endpointInfo, fields);
    endpointVectors.push({ name: endpointInfo.name, case: 'info_notify_basic', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields });
  }
  if (endpointDevInfo) {
    const fields = Object.fromEntries(endpointDevInfo.fields.map(f => [f.name, f.value ?? 0]));
    fields.group = 0; fields.ManufacturerIdByte1 = 0x00; fields.ManufacturerIdByte2 = 0x20; fields.ManufacturerIdByte3 = 0x33;
    fields.FamilyIdLSB = 0x34; fields.FamilyIdMSB = 0x12; fields.ModelIdLSB = 0x78; fields.ModelIdMSB = 0x56;
    fields.SoftwareRevisionLevel1 = 1; fields.SoftwareRevisionLevel2 = 2; fields.SoftwareRevisionLevel3 = 3; fields.SoftwareRevisionLevel4 = 4;
    const raw = sysEncode(endpointDevInfo, fields);
    endpointVectors.push({ name: endpointDevInfo.name, case: 'device_info_example', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields });
  }
  if (endpointName) {
    const fields = Object.fromEntries(endpointName.fields.map(f => [f.name, f.value ?? 0]));
    fields.group = 0;
    // Encode ASCII "EPNAME" across bytes (upper 7 bits per byte kept)
    const nameBytes = [...'EP NAME  '].slice(0,14).map(ch => ch.charCodeAt(0) & 0x7F);
    for (let i=0;i<nameBytes.length;i++) { fields['Byte'+(i+1)] = nameBytes[i] || 0; }
    const raw = sysEncode(endpointName, fields);
    endpointVectors.push({ name: endpointName.name, case: 'name_notify_sample', raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields });
  }
  if (endpointVectors.length) {
    // add variants for all forms when a message has 'form'
    const formVariants = [];
    for (const v of endpointVectors) {
      const m = messages.find(mm => mm.name === v.name);
      if (m && m.fields.some(f => f.name === 'form')) {
        for (let f=0; f<4; f++) {
          const fields = { ...v.decoded, form: f };
          const raw = sysEncode(m, fields);
          formVariants.push({ ...v, case: `form_${f}`, raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields });
        }
      } else {
        formVariants.push(v);
      }
    }
    fs.writeFileSync(path.join(vectorsDir, 'ump_endpoint.json'), JSON.stringify(formVariants, null, 2));
  }

  // Flex Data vectors: pick a couple of leaf messages and vary form/channel/group
  const flexLeaves = messages.filter(m => m.name.startsWith('FlexDataMessages') && m.fields.some(f => f.name === 'statusMSB') && m.fields.some(f => f.name === 'statusLSB'));
  const flexVectors = [];
  for (const m of flexLeaves.slice(0, 3)) {
    for (let f=0; f<4; f++) {
      const fields = Object.fromEntries(m.fields.map(ff => [ff.name, ff.value ?? 0]));
      if ('channel' in fields) fields.channel = 1;
      if ('group' in fields) fields.group = 2;
      if ('form' in fields) fields.form = f;
      const raw = sysEncode(m, fields);
      flexVectors.push({ name: m.name, case: `form_${f}_ch1_g2`, raw: '0x' + raw.toString(16).toUpperCase(), decoded: fields });
    }
  }
  if (flexVectors.length) {
    fs.writeFileSync(path.join(vectorsDir, 'ump_flex.json'), JSON.stringify(flexVectors, null, 2));
  }

  console.log('Static extraction complete.');
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}

// Generic encoder for vectors based on bit layout
function sysEncode(messageDef, fields) {
  let raw = 0n;
  for (const f of messageDef.fields) {
    const v = fields.hasOwnProperty(f.name) ? BigInt(fields[f.name]) : (f.value !== undefined ? BigInt(f.value) : 0n);
    const mask = (1n << BigInt(f.bitWidth)) - 1n;
    raw |= (v & mask) << BigInt(f.bitOffset);
  }
  return raw;
}

// --- CI State Machines ---
function parseCIStateMachines(root) {
  const p = path.join(root, 'libs', 'midiCITables.js');
  const src = readFile(p);
  const idx = src.indexOf('exports.ciTypes');
  if (idx === -1) return [];
  const objStart = src.indexOf('{', idx);
  const objEnd = walkBalanced(src, objStart, '{', '}');
  const objText = src.slice(objStart, objEnd);
  const machines = [];
  // Parse ciTypes into map for cross-referencing
  const types = {};
  const entryKeyRegex = /(0x[0-9A-Fa-f]+)\s*:\s*\{/g;
  let m;
  while ((m = entryKeyRegex.exec(objText)) !== null) {
    const key = m[1];
    const bodyStart = m.index + m[0].length - 1; // at '{'
    const bodyEnd = walkBalanced(objText, bodyStart, '{', '}');
    const body = objText.slice(bodyStart, bodyEnd);
    const titleMatch = /title:\s*'([^']+)'/.exec(body);
    const title = titleMatch ? titleMatch[1] : key;
    const replyMatch = /reply\s*:\s*(0x[0-9A-Fa-f]+|\d+)/.exec(body);
    const recvEventMatch = /recvEvent\s*:\s*\{[^}]*name\s*:\s*'([^']+)'/s.exec(body);
    const chunkAck = /chunkAck\s*:\s*true/.test(body);
    const streamsMatch = /streams\s*:\s*'([^']+)'/.exec(body);
    types[key.toLowerCase()] = { key, title, reply: replyMatch ? replyMatch[1].toLowerCase() : null, recvEvent: recvEventMatch ? recvEventMatch[1] : null, chunkAck, streams: streamsMatch ? streamsMatch[1] : null };
  }

  const beginType = Object.values(types).find(t => /Reply to MIDI Message Report \(Begin\)/i.test(t.title));
  const endType = Object.values(types).find(t => /Reply to MIDI Message Report \(End\)/i.test(t.title));

  for (const t of Object.values(types)) {
    const name = `MIDI-CI.${t.title.replace(/[^A-Za-z0-9]/g, '')}`;
    if (t.reply) {
      // Multi-step MIDI Message Report flow
      if (/Inquiry: MIDI Message Report/i.test(t.title) && beginType && endType) {
        machines.push({
          name,
          states: ['Idle','RequestSent','Streaming','Completed','Failed'],
          events: ['Start','ReplyBegin','ReplyEnd','Timeout','Error'],
          transitions: [
            { from: 'Idle', on: 'Start', to: 'RequestSent' },
            { from: 'RequestSent', on: 'ReplyBegin', to: 'Streaming' },
            { from: 'Streaming', on: 'ReplyEnd', to: 'Completed' },
            { from: 'RequestSent', on: 'Timeout', to: 'Failed' },
            { from: 'RequestSent', on: 'Error', to: 'Failed' },
            { from: 'Streaming', on: 'Timeout', to: 'Failed' },
            { from: 'Streaming', on: 'Error', to: 'Failed' },
          ],
          provenance: { file: path.relative(process.cwd(), p), line: src.slice(0, idx).split(/\r?\n/).length },
        });
        continue;
      }
      // Chunked PE flows (Get/Set) with optional chunks
      if (t.chunkAck || /Inquiry: Get Property Data/i.test(t.title) || /Inquiry: Set Property Data/i.test(t.title)) {
        machines.push({
          name,
          states: ['Idle','RequestSent','Chunking','Completed','Failed'],
          events: ['Start','ReplyChunk','Reply','Timeout','Error'],
          transitions: [
            { from: 'Idle', on: 'Start', to: 'RequestSent' },
            { from: 'RequestSent', on: 'ReplyChunk', to: 'Chunking' },
            { from: 'Chunking', on: 'ReplyChunk', to: 'Chunking' },
            { from: 'Chunking', on: 'Reply', to: 'Completed' },
            { from: 'RequestSent', on: 'Reply', to: 'Completed' },
            { from: 'RequestSent', on: 'Timeout', to: 'Failed' },
            { from: 'RequestSent', on: 'Error', to: 'Failed' },
            { from: 'Chunking', on: 'Timeout', to: 'Failed' },
            { from: 'Chunking', on: 'Error', to: 'Failed' },
          ],
          provenance: { file: path.relative(process.cwd(), p), line: src.slice(0, idx).split(/\r?\n/).length },
        });
        continue;
      }
      // Default request-reply
      machines.push({
        name,
        states: ['Idle','RequestSent','Completed','Failed'],
        events: ['Start','Reply','Timeout','Error'],
        transitions: [
          { from: 'Idle', on: 'Start', to: 'RequestSent' },
          { from: 'RequestSent', on: 'Reply', to: 'Completed' },
          { from: 'RequestSent', on: 'Timeout', to: 'Failed' },
          { from: 'RequestSent', on: 'Error', to: 'Failed' },
        ],
        provenance: { file: path.relative(process.cwd(), p), line: src.slice(0, idx).split(/\r?\n/).length },
      });
      continue;
    }
    if (t.recvEvent) {
      machines.push({
        name,
        states: ['Idle','Completed'],
        events: ['Notify'],
        transitions: [ { from: 'Idle', on: 'Notify', to: 'Completed' } ],
        provenance: { file: path.relative(process.cwd(), p), line: src.slice(0, idx).split(/\r?\n/).length },
      });
    }
  }
  return machines;
}

function buildCIVectors(machines) {
  const out = [];
  for (const m of machines) {
    if (m.events.includes('Start') && m.events.includes('ReplyBegin') && m.events.includes('ReplyEnd')) {
      out.push({ machine: m.name, sequence: ['Start', 'ReplyBegin', 'ReplyEnd'], expect: 'Completed' });
      out.push({ machine: m.name, sequence: ['Start', 'Timeout'], expect: 'Failed' });
    } else if (m.events.includes('Start') && m.events.includes('ReplyChunk') && m.events.includes('Reply')) {
      out.push({ machine: m.name, sequence: ['Start', 'Reply'], expect: 'Completed' });
      out.push({ machine: m.name, sequence: ['Start', 'ReplyChunk', 'Reply'], expect: 'Completed' });
      out.push({ machine: m.name, sequence: ['Start', 'Timeout'], expect: 'Failed' });
    } else if (m.events.includes('Start') && m.events.includes('Reply')) {
      out.push({ machine: m.name, sequence: ['Start', 'Reply'], expect: 'Completed' });
      out.push({ machine: m.name, sequence: ['Start', 'Timeout'], expect: 'Failed' });
    } else if (m.events.includes('Notify')) {
      out.push({ machine: m.name, sequence: ['Notify'], expect: 'Completed' });
    }
  }
  return out;
}

function buildAutoVectors(messages) {
  const out = [];
  for (const m of messages) {
    const vars = m.fields.filter(f => f.value === undefined);
    if (!vars.length) continue;
    const base = {};
    for (const f of m.fields) {
      base[f.name] = f.value !== undefined ? f.value : 0;
    }
    const candidates = vars.slice(0, 2); // first two variable fields
    for (const f of candidates) {
      const minCase = { ...base, [f.name]: 0 };
      const maxVal = (1n << BigInt(f.bitWidth)) - 1n;
      const maxCase = { ...base, [f.name]: Number(maxVal) };
      const rawMin = sysEncode(m, minCase);
      const rawMax = sysEncode(m, maxCase);
      out.push({ name: m.name, case: `${f.name}_min`, raw: '0x' + rawMin.toString(16).toUpperCase(), decoded: minCase });
      out.push({ name: m.name, case: `${f.name}_max`, raw: '0x' + rawMax.toString(16).toUpperCase(), decoded: maxCase });
    }
  }
  return out;
}

// --- Profiles & Property Exchange ---
function parseProfiles(root) {
  const p = path.join(root, 'libs', 'profiles.js');
  let out = [];
  try {
    const src = readFile(p);
    const idx = src.indexOf('exports.profiles');
    if (idx === -1) return out;
    const arrStart = src.indexOf('[', idx);
    const arrEnd = walkBalanced(src, arrStart, '[', ']');
    const arrText = src.slice(arrStart, arrEnd);
    // naive scan of objects with bank, index, name
    const itemRegex = /\{[^}]*bank\s*:\s*(0x[0-9A-Fa-f]+|\d+)[^}]*index\s*:\s*(0x[0-9A-Fa-f]+|\d+)[^}]*name\s*:\s*'([^']+)'/g;
    let m;
    while ((m = itemRegex.exec(arrText)) !== null) {
      const bank = m[1].startsWith('0x') ? parseInt(m[1], 16) : parseInt(m[1], 10);
      const index = m[2].startsWith('0x') ? parseInt(m[2], 16) : parseInt(m[2], 10);
      const name = m[3];
      out.push({ bank, index, name });
    }
  } catch {}
  return out;
}

function parsePESchemas(root) {
  const p = path.join(root, 'libs', 'midiCITables.js');
  let out = [];
  try {
    const src = readFile(p);
    const idx = src.indexOf('exports.resourceSchema');
    if (idx === -1) return out;
    const objStart = src.indexOf('{', idx);
    const objEnd = walkBalanced(src, objStart, '{', '}');
    const objText = src.slice(objStart, objEnd);
    const keyRegex = /"([A-Za-z0-9_]+)"\s*:\s*\{/g;
    let m;
    while ((m = keyRegex.exec(objText)) !== null) {
      const id = m[1];
      out.push({ id });
    }
  } catch {}
  return out;
}
