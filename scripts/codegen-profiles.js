/**
 * Generate Swift Profiles and PropertyExchange helpers from contract.
 */
const fs = require('fs');
const path = require('path');

function readJSON(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }

function main() {
  const root = process.env.WORKBENCH_ROOT || process.cwd();
  const contract = readJSON(path.join(root, 'contract', 'midi2.json'));
  const outDir = path.join(root, 'swift', 'Midi2Swift', 'Sources', 'Profiles');
  fs.mkdirSync(outDir, { recursive: true });

  const profiles = contract.resources.Profiles || [];
  const listLines = profiles.map(p => `        ProfileID(bank: 0x${p.bank.toString(16).toUpperCase()}, index: 0x${p.index.toString(16).toUpperCase()}, name: "${p.name}")`).join(',\n');
  const file = `import Foundation\n\npublic struct ProfileID: Equatable, Hashable {\n    public let bank: UInt8\n    public let index: UInt8\n    public let name: String\n}\n\npublic enum ProfilesCatalog {\n    public static let all: [ProfileID] = [\n${listLines}\n    ]\n    public static func lookup(bank: UInt8, index: UInt8) -> ProfileID? {\n        return all.first { $0.bank == bank && $0.index == index }\n    }\n}\n`;
  fs.writeFileSync(path.join(outDir, 'ProfilesCatalog.swift'), file);

  const pe = contract.resources.PropertyExchange?.schemas || [];
  const peLines = pe.map(r => `        "${r.id}"`).join(',\n');
  const peFile = `import Foundation\n\npublic enum PropertyExchangeResource: String, CaseIterable {\n${pe.map(r => `    case ${r.id}`).join('\n')}\n}\n\npublic enum PropertyExchangeCatalog {\n    public static let all: [String] = [\n${peLines}\n    ]\n}\n`;
  fs.writeFileSync(path.join(outDir, 'PropertyExchangeCatalog.swift'), peFile);

  console.log('Generated Profiles and PE catalogs.');
}

if (require.main === module) { try { main(); } catch (e) { console.error(e); process.exit(1);} }

