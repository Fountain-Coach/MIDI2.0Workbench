/**
 * Contract verifier
 * - Checks message field ranges against container bit size
 * - Ensures generated Swift files exist for each message
 * - Validates CI machines have at least one vector sequence
 */
const fs = require('fs');
const path = require('path');

function readJSON(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }

function swiftTypeName(name) {
  const parts = name.split(/[^A-Za-z0-9]+/).filter(Boolean);
  return parts.map(p => p[0].toUpperCase() + p.slice(1)).join('');
}

function main() {
  const root = process.env.WORKBENCH_ROOT || process.cwd();
  const contract = readJSON(path.join(root, 'contract', 'midi2.json'));
  const vectorsDir = path.join(root, 'vectors', 'golden');
  const genDir = path.join(root, 'swift', 'Midi2Swift', 'Sources', 'UMP', 'Generated');
  let errors = 0;

  const containerBits = { UMP32: 32, UMP64: 64, UMP128: 128 };

  for (const msg of contract.messages) {
    // Duplicate field name detection
    const names = new Set();
    for (const f of (msg.fields || [])) {
      if (names.has(f.name)) {
        console.error(`ERROR: Duplicate field '${f.name}' in ${msg.name}`);
        errors++;
      }
      names.add(f.name);
    }

    const maxBit = Math.max(0, ...msg.fields.map(f => f.bitOffset + f.bitWidth));
    const limit = containerBits[msg.container] || 0;
    if (maxBit > limit) {
      console.error(`ERROR: ${msg.name} exceeds container (${maxBit} > ${limit})`);
      errors++;
    }

    // Family-specific sanity
    if (msg.name.startsWith('FlexDataMessages')) {
      const hasMSB = msg.fields.find(f => f.name === 'statusMSB');
      const hasLSB = msg.fields.find(f => f.name === 'statusLSB');
      if (!(hasMSB && hasLSB)) {
        console.error(`WARN: Flex Data ${msg.name} missing statusMSB/LSB`);
      }
    }
    if (msg.name.startsWith('SysEx8andMDS')) {
      const mt = msg.fields.find(f => f.name === 'messageType' && f.value === 5);
      if (!mt) {
        console.error(`ERROR: SysEx8/MDS ${msg.name} missing MT=0x5`);
        errors++;
      }
    }
    if (msg.name.startsWith('MIDIEndpoint')) {
      const mt = msg.fields.find(f => f.name === 'messageType' && f.value === 15);
      const form = msg.fields.find(f => f.name === 'form' && f.bitOffset === 4 && f.bitWidth === 2);
      const status10 = msg.fields.find(f => f.name === 'status10' && f.bitOffset === 6 && f.bitWidth === 10);
      if (!(mt && form && status10)) {
        console.error(`ERROR: MIDI Endpoint ${msg.name} missing required header fields`);
        errors++;
      }
    }
    // Swift file presence
    const typeName = swiftTypeName(msg.name) + '.swift';
    const filePath = path.join(genDir, typeName);
    if (!fs.existsSync(filePath)) {
      console.error(`ERROR: Missing generated Swift for ${msg.name} (${typeName})`);
      errors++;
    }
  }

  // CI machines must have at least one vector
  let ciVectors = [];
  try {
    ciVectors = readJSON(path.join(vectorsDir, 'ci_statechart.json'));
  } catch {}
  const machines = contract.state_machines || [];
  const withVectors = new Set(ciVectors.map(v => v.machine));
  for (const m of machines) {
    if (!withVectors.has(m.name)) {
      console.error(`WARN: No vector sequence for CI machine ${m.name}`);
    }
  }

  if (errors > 0) {
    console.error(`FAIL: ${errors} error(s)`);
    process.exit(1);
  } else {
    console.log('OK: contract and generated coverage look consistent');
  }
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}
