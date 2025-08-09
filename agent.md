# [agent.md](https://agent.md) — MIDI 2.0 Swift Library from Workbench Fork (Single-Agent Plan)

> **Objective**  
> From **this Workbench fork**, derive an authoritative, machine-readable **MIDI 2.0 contract**, generate a **Swift library** from it, validate via **golden vectors** and **Workbench interop**, and ship with a **compliance checklist**. This file is the single source of truth the agent follows end-to-end.

---

## 0) Project Contract (What “Done” Means)

- **Spec Coverage (v1)**: UMP (Stream/Utility/System/ChannelVoice 2.0), MIDI-CI Discovery + Protocol Negotiation, at least **one** Profile, Property Exchange Foundational Resources.
- **Artifacts**:
  - `contract/midi2.json` — canonical spec contract (schemas + state machines + enums) with provenance.
  - `vectors/golden/*.json` — encode/decode + CI dialogue vectors.
  - `swift/Midi2Swift/` — SwiftPM package (UMP, CI, Profiles, PE).
  - `reports/compliance/` — exported checklist files from Workbench runs.
- **Determinism**: Re-running extraction on the same Workbench commit produces byte-identical outputs.
- **Tests**: All golden vectors pass; CI green; Workbench interop passes manual/optional headless run.

---

## 1) Preconditions (Agent Checklist)

- This repository is a **fork** of MIDI 2.0 Workbench.  
- Node 18 LTS + Yarn installed.  
- macOS or Linux host with virtual MIDI 2.0 endpoints available (Core MIDI on macOS).  
- Swift toolchain (SwiftPM).  
- Python 3.11+ (optional if you choose Python for codegen; Swift-only workflows are fine).

> **Style/Conventions**
> - Only add new modules/files; do not modify core Workbench protocol logic unless necessary.
> - Preserve MIT attribution in headers where required.
> - Commit codegen **inputs** and **goldens**; generated Swift sources may be committed if stable.

---

## 2) Repository Layout (Target)

```
(workbench fork root)
├── agent.md
├── packages/                       # Workbench packages (leave intact)
├── scripts/
│   ├── extract.ts                  # extractor → contract & vectors
│   ├── export-checklist.ts         # export Workbench checklist
│   └── headless-runner.ts          # optional JSON-RPC runner
├── contract/
│   └── midi2.json                  # generated contract
├── vectors/
│   └── golden/
│       ├── ump_channel_voice.json
│       ├── ump_system.json
│       ├── ump_utility_stream.json
│       ├── ci_dialogues.json
│       └── profiles_pe.json
├── swift/
│   └── Midi2Swift/
│       ├── Package.swift
│       └── Sources/
```

---

## 3) Agent Actions (Sequential)

1. **Install & Validate Workbench**  
   - Run `yarn install` at repo root.  
   - Verify `yarn dev` launches Workbench UI.  

2. **Automate Extraction**  
   - Implement `scripts/extract.ts` to run Workbench headless and produce:
     - `contract/midi2.json`
     - `vectors/golden/*.json`

3. **Swift Codegen**  
   - Read `contract/midi2.json`; generate Swift types/enums/constants for:
     - UMP packets and fields
     - CI messages
     - Profile descriptors
     - Property Exchange descriptors
   - Place generated files under `swift/Midi2Swift/Sources/`.

4. **Golden Tests in Swift**  
   - Create Swift tests that load each `vectors/golden/*.json` and:
     - Encode → compare to reference bytes
     - Decode → compare to reference JSON
   - CI must pass on macOS and Linux.

5. **Interop/Compliance**  
   - Optionally run `scripts/headless-runner.ts` to connect Workbench to Swift binary over virtual MIDI 2.0.
   - Export compliance checklist with `scripts/export-checklist.ts` into `reports/compliance/`.

6. **Commit & Tag**  
   - Commit both inputs and goldens.
   - Tag a release once tests + checklist pass.

---

## 4) Non-Goals (v1)

- No SysEx 7/8 Stream Format beyond what Workbench supports in spec coverage.
- No MIDI 1.0 translation layers unless generated automatically.
- No manual spec transcription — all must originate from Workbench authoritative sources.

---

## 5) Future Extensions (v2+)

- Support all Profile specs and PE resources.
- Add SysEx 8 Stream Format parsing.
- Generate documentation site from `contract/midi2.json`.
- Provide SwiftUI sample app using generated library.

---

**EOF**
