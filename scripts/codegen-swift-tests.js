/**
 * Generate Swift tests that validate encode/decode for every message using auto_vectors.json when available.
 * Supports UMP32, UMP64, and UMP128 (lo/hi) comparisons.
 */
const fs = require('fs');
const path = require('path');

function readJSON(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }
function swiftTypeName(name){ return name.split(/[^A-Za-z0-9]+/).filter(Boolean).map(p=>p[0].toUpperCase()+p.slice(1)).join(''); }
function swiftPropName(name){ const clean=name.replace(/[^A-Za-z0-9]+/g,' '); const parts=clean.trim().split(/\s+/); const cc=parts.map((p,i)=>i===0?p.toLowerCase():p[0].toUpperCase()+p.slice(1)).join(''); const kw=new Set(['class','struct','protocol','enum','extension','import','let','var','if','else','switch','case','default','return','in','for','while','do','catch']); return kw.has(cc)?`_${cc}`:cc; }
function typeForWidth(w){ if(w<=8)return'UInt8'; if(w<=16)return'UInt16'; if(w<=32)return'UInt32'; return'UInt64'; }

function genFactory(msg){ const t=swiftTypeName(msg.name); const vars=msg.fields.filter(f=>f.value===undefined); const params=vars.map(f=>`${swiftPropName(f.name)}: ${typeForWidth(f.bitWidth)}`).join(', '); const args=vars.map(f=>`${swiftPropName(f.name)}: ${swiftPropName(f.name)}`).join(', '); return `private func make_${t}(${params}) -> ${t} { ${t}(${args}) }`; }

function genCase(msg){ const t=swiftTypeName(msg.name); const c=msg.container; const vars=msg.fields.filter(f=>f.value===undefined); const extracts=vars.map(f=>{ const p=swiftPropName(f.name); return `let ${p} = ${typeForWidth(f.bitWidth)}(d["${f.name}"] as! Int)`; }).join('\n                '); const args=vars.map(f=>swiftPropName(f.name)).join(', ');
  if(c==='UMP32'){
    return `case "${msg.name}":
                ${extracts}
                let msg = make_${t}(${args})
                let raw = msg.encode()
                let expected = parseHex32(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(${t}.decode(raw))
                return`;
  } else if (c==='UMP64'){
    return `case "${msg.name}":
                ${extracts}
                let msg = make_${t}(${args})
                let raw = msg.encode()
                let expected = parseHex64(rawHex)
                XCTAssertEqual(raw.raw, expected)
                XCTAssertNotNil(${t}.decode(raw))
                return`;
  } else {
    return `case "${msg.name}":
                ${extracts}
                let msg = make_${t}(${args})
                let raw = msg.encode()
                let (elo, ehi) = parseHex128(rawHex)
                XCTAssertEqual(raw.lo, elo)
                XCTAssertEqual(raw.hi, ehi)
                XCTAssertNotNil(${t}.decode(raw))
                return`;
  }
}

function main(){
  const root=process.env.WORKBENCH_ROOT||process.cwd();
  const contract=readJSON(path.join(root,'contract','midi2.json'));
  const outFile=path.join(root,'swift','Midi2Swift','Tests','UMPTests','AllMessagesAutoVectorTests.swift');
  const factories=contract.messages.map(genFactory).join('\n');
  const cases=contract.messages.map(genCase).join('\n            ');
  const file=`import XCTest
@testable import UMP

final class AllMessagesAutoVectorTests: XCTestCase {
    func testAllMessagesEncodeDecodeFromAutoVectors() throws {
        let base = try locateVectors()
        var arr: [[String: Any]] = []
        for name in ["auto_vectors.json", "ump_endpoint.json", "ump_flex.json"] {
            let url = base.appendingPathComponent(name)
            if FileManager.default.fileExists(atPath: url.path) {
                let data = try Data(contentsOf: url)
                let part = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                arr.append(contentsOf: part)
            }
        }
        let groups = Dictionary(grouping: arr, by: { $0["name"] as! String })
        for (name, vectors) in groups {
            for v in vectors.prefix(2) {
                guard let rawHex = v["raw"] as? String else { continue }
                let d = v["decoded"] as! [String: Any]
                switch name {
            ${cases}
                default: continue
                }
            }
        }
    }

${factories}

    private func locateVectors() throws -> URL {
        let thisFile = URL(fileURLWithPath: #file)
        var pkgDir = thisFile
        for _ in 0..<3 { pkgDir.deleteLastPathComponent() }
        let repoRoot = pkgDir.deletingLastPathComponent().deletingLastPathComponent()
        let vectors = repoRoot.appendingPathComponent("vectors/golden")
        return vectors
    }
    private func parseHex32(_ s: String) -> UInt32 { let clean = s.replacingOccurrences(of: "0x", with: ""); return UInt32(strtoul(clean, nil, 16)) }
    private func parseHex64(_ s: String) -> UInt64 { let clean = s.replacingOccurrences(of: "0x", with: ""); return strtoull(clean, nil, 16) }
    private func parseHex128(_ s: String) -> (UInt64, UInt64) { let clean = s.replacingOccurrences(of: "0x", with: "").uppercased(); let padded = String(repeating: "0", count: max(0, 32 - clean.count)) + clean; let hiStr = String(padded.prefix(padded.count - 16)); let loStr = String(padded.suffix(16)); let lo = strtoull(loStr, nil, 16); let hi = strtoull(hiStr, nil, 16); return (lo, hi) }
}
`;
  fs.writeFileSync(outFile,file);
  console.log('Generated tests:', outFile);
}

if(require.main===module){ try{ main(); } catch(e){ console.error(e); process.exit(1);} }
