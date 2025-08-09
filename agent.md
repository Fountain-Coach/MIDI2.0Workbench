# agent.md — Static-Only MIDI 2.0 Swift Library from Workbench Source

> **Objective**  
> Build a **complete Swift MIDI-2 library** by **learning from** (but **not running**) the MIDI 2.0 Workbench repo.  
> Extract protocol facts **statically** from the TypeScript source (AST), generate **fully implemented** Swift (no stubs), and ship with **compiling tests** that validate bit-accurate packing/unpacking and spec invariants.  
> **No Workbench execution, no GUI/CLI, no headless runner.**

---

## 0) Constraints & Success Criteria

- **No runtime dependency** on Workbench: only read its source files.
- **No stubs**: generated Swift contains full bit operations, enums, and CI state logic; **zero `TODO/TBD/fatalError`**.
- **Compiling tests**: test targets must compile and pass **without** Workbench or external tools.
- **Deterministic outputs** from the same Workbench commit.
- **Traceability**: every generated symbol carries provenance (file + line + commit).

---

## 1) Inputs (read-only)

- Workbench fork checkout at `WORKBENCH_ROOT` (TypeScript/JS).
- Target source sets to parse (examples, adjust to repo):
  - `packages/*/src/ump/**/*.{ts,tsx}`
  - `packages/*/src/ci/**/*.{ts,tsx}`
  - `packages/*/src/profiles/**/*.{ts,tsx}`
  - `packages/*/src/property-exchange/**/*.{ts,tsx}`
  - `packages/*/src/common/**/*.{ts,tsx}`

---

## 2) Outputs

- `contract/midi2.json` — canonical machine contract: messages, fields, enums, constants, state machines, with provenance.
- `vectors/golden/*.json` — **static** golden vectors (no Workbench execution): min/max/edge/invalid cases computed from field definitions & constants.
- `swift/Midi2Swift/` — SwiftPM lib with modules: `Core`, `UMP`, `CI`, `Profiles`, `PropertyExchange`.
- `swift/Midi2Swift/Tests/*` — unit tests that **compile and pass** offline.

---

## 3) Repository Layout

(workbench fork root)

```text
├── agent.md
├── scripts/
│   ├── extract-static.ts        # ts-morph AST → contract + goldens (no exec)
│   └── verify-contract.ts       # structural sanity checks (node)
├── contract/
│   └── midi2.json
├── vectors/
│   └── golden/
│       ├── ump_channel_voice.json
│       ├── ump_system.json
│       ├── ump_utility.json
│       ├── ci_statechart.json
│       └── profiles_pe.json
├── swift/
│   └── Midi2Swift/
│       ├── Package.swift
│       ├── Sources/{Core,UMP,CI,Profiles,PropertyExchange}/
│       └── Tests/{CoreTests,UMPTests,CITests,ProfilesTests,GoldenVectorTests}/
└── .github/workflows/ci.yml
```

---

## 4) Static Extraction Approach (no execution)

### Tooling
- **TypeScript AST** via `ts-morph` (Node 18+).
- No `require()`/evaluation of repo code; **AST only**.

### What to extract
1. **Enums & constants**  
   - Status nibbles, message type IDs, profile IDs, PE keys.  
   - Record as `{name, value, width, file, line}`.

2. **Message layouts (UMP 32/64)**  
   - Locate encode/decode helpers or type aliases describing fields.  
   - Derive for each message class:
     - container size (32/64)
     - ordered fields `{name, bitOffset, bitWidth, range?, enumRef?}`
     - invariants (sum of widths, reserved bits = 0, etc.)

3. **MIDI-CI state machines**  
   - Find reducers/handlers/switches; build a **statechart**: `{states, events, transitions (guard?, action?)}`.

4. **Profiles & PE**  
   - Profile identifiers, enable/disable rules if statically documented.  
   - PE resource IDs and any JSON schemas embedded as constants.

### Determinism
- Sort symbols lexicographically; fixed key order; uppercase hex; include `meta.workbench_commit`.

---

## 5) Contract Schema (authoritative)

```json
{
  "$schema": "https://fountain.example/schemas/midi2-contract.schema.json",
  "meta": { "workbench_commit": "string", "generated_at": "ISO-8601" },
  "enums": { "<EnumName>": { "type": "uintN|string", "values": { "<Case>": 0 } } },
  "messages": [
    {
      "name": "ChannelVoiceV2.NoteOn",
      "container": "UMP64",
      "fields": [
        { "name": "group", "bitOffset": 28, "bitWidth": 4, "range": [0,15] },
        { "name": "channel", "bitOffset": 24, "bitWidth": 4, "range": [0,15] },
        { "name": "statusNibble", "bitOffset": 20, "bitWidth": 4, "enum": "Status", "value": 9 },
        { "name": "noteNumber", "bitOffset": 8, "bitWidth": 7, "range": [0,127] },
        { "name": "velocity", "bitOffset": 0, "bitWidth": 16, "range": [0,65535] }
      ],
      "invariants": ["bits_sum == 64"],
      "provenance": { "file": "packages/.../cv2.ts", "line": 123 }
    }
  ],
  "state_machines": [
    {
      "name": "MIDI-CI.ProtocolNegotiation",
      "states": ["Idle","OfferSent","Negotiated","Failed"],
      "events": ["Start","Offer","Accept","Timeout","Error"],
      "transitions": [
        { "from": "Idle", "on": "Start", "to": "OfferSent", "action": "sendOffer" },
        { "from": "OfferSent", "on": "Accept", "to": "Negotiated", "guard": "paramsOk" },
        { "from": "OfferSent", "on": "Timeout", "to": "Failed" }
      ],
      "provenance": { "file": "packages/.../ci.ts", "line": 77 }
    }
  ],
  "resources": { "PropertyExchange": { "schemas": [ { "id": "identity", "json_schema": {} } ] } }
}
```

---

## 6) Golden Vectors (static, compile-time)

- For each message definition, generate cases:
  - min, max, middle, invalid-low, invalid-high per ranged field.
- For CI statecharts, generate event sequences (happy path, timeout, error).
- Encode reference bytes from field math, not Workbench execution.
- Store as JSON: `{ "case": "NoteOn_min", "raw": "0x....", "decoded": {...} }`.

---

## 7) Swift Generation (no stubs)

### Mapping Rules
- `container == UMP32|UMP64` → `struct UMP32/UMP64 { var raw: UInt32/UInt64 }`.
- Each message → Swift struct with typed properties; add `init(fields…)`, `encode() -> UMP32/64`, `static func decode(_:) -> Self?`.
- Enums → `enum Foo: UInt8/UInt16/String` with `init?(rawValue:)`.
- CI state machines → pure reducer:
  ```swift
  struct CIState { /* generated fields */ }
  enum CIEvent { /* generated */ }
  enum CIAffect { case sendUMP([UInt32]), case none }
  func reduce(_ s: CIState, _ e: CIEvent) -> (CIState, [CIAffect])
  ```
- Range enforcement with `precondition` and masked writes.

Project:
- SwiftPM `Package.swift`; modules Core, UMP, CI, Profiles, PropertyExchange.

---

## 8) Tests (compile & pass offline)

- `GoldenVectorTests`: load `vectors/golden/*.json`, run encode/decode, compare raw bytes & decoded fields.
- `CITests`: feed event sequences through reduce, assert end state & generated effects.
- Invariants: bit-sum, reserved-zero, enum coverage.

---

## 9) Commands

```bash
# 1) Generate contract + goldens (static AST only)
node scripts/extract-static.ts --root "$WORKBENCH_ROOT" --out contract/midi2.json --vectors vectors/golden

# 2) Swift build & tests
cd swift/Midi2Swift
swift build
swift test
```

---

## 10) CI Policy (fail fast on stubs)

- Fail if source contains `TODO|TBD|fatalError("unimplemented")`.
- Fail if any message/enumeration in `contract/midi2.json` lacks a generated Swift type.
- Fail if tests don’t compile or any test fails.
- Record `workbench_commit` in build metadata.

---

## 11) Prompts (for your coding agent)

**P1 — Static extractor**  
Create `scripts/extract-static.ts` using `ts-morph`. Walk the given source globs. Emit `contract/midi2.json` and `vectors/golden/*.json` exactly per agent.md §§5–6. No code execution. Add provenance (file, line) and `meta.workbench_commit`. Deterministic ordering and uppercase hex.

**P2 — Swift library generation**  
Scaffold `swift/Midi2Swift` (SwiftPM). Generate full Swift types for UMP, CI, Profiles, PE from `contract/midi2.json` (no stubs). Add range checks and bit masks. Provide encode/decode and CI reducer.

**P3 — Tests**  
Implement `GoldenVectorTests` and `CITests` that read `vectors/golden`. Ensure tests compile and pass without external tools. No references to Workbench at runtime.

**P4 — CI**  
Add GitHub Actions workflow that runs extract-static, verify-contract, and swift test on macOS. Fail on TODO/TBD/unimplemented markers.

---

## 12) Acceptance Checklist

- `contract/midi2.json` present; enums/messages/state_machines populated; provenance set; deterministic.
- `vectors/golden/*.json` generated for all message classes and CI sequences.
- Swift library compiles; no stubs; encode/decode & reducers implemented.
- Tests compile and pass offline.
- CI green; no TODO/TBD/unimplemented.

---
