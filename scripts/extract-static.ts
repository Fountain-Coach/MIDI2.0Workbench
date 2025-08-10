/**
 * Static extractor using ts-morph.
 *
 * Parses the Workbench TypeScript sources without executing them and emits
 * a machine contract JSON plus golden vector cases.  Output ordering is
 * deterministic and every extracted symbol carries provenance information
 * (source file and line number).
 */

import { Project, Node, SyntaxKind } from "ts-morph";
import fs from "fs";
import path from "path";
import { execSync } from "child_process";

interface Field {
  name: string;
  bitOffset: number;
  bitWidth: number;
  value?: number;
  range?: [number, number];
  enum?: string;
}

interface Message {
  name: string;
  container: "UMP32" | "UMP64";
  fields: Field[];
  provenance: { file: string; line: number };
}

interface StateMachine {
  name: string;
  states: string[];
  events: string[];
  transitions: Array<{
    from: string;
    on: string;
    to: string;
    guard?: string;
    action?: string;
  }>;
  provenance: { file: string; line: number };
}

interface Contract {
  meta: { workbench_commit: string; generated_at: string };
  enums: Record<
    string,
    { type: string; values: Record<string, number>; provenance: { file: string; line: number } }
  >;
  messages: Message[];
  state_machines: StateMachine[];
  resources: Record<string, unknown>;
}

interface Args {
  root: string;
  out: string;
  vectors: string;
}

function parseArgs(argv: string[]): Args {
  const args: Args = {
    root: process.cwd(),
    out: path.join(process.cwd(), "contract", "midi2.json"),
    vectors: path.join(process.cwd(), "vectors", "golden"),
  };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === "--root" && argv[i + 1]) args.root = path.resolve(argv[++i]);
    else if (a === "--out" && argv[i + 1]) args.out = path.resolve(argv[++i]);
    else if (a === "--vectors" && argv[i + 1]) args.vectors = path.resolve(argv[++i]);
  }
  return args;
}

function isoNow(): string {
  return new Date().toISOString();
}

function gitCommit(root: string): string {
  try {
    return execSync("git rev-parse HEAD", { cwd: root }).toString().trim();
  } catch {
    return "unknown";
  }
}

function ensureDir(p: string): void {
  fs.mkdirSync(p, { recursive: true });
}

function sortObject<T>(obj: T): T {
  if (Array.isArray(obj)) return obj.map((o) => sortObject(o)) as unknown as T;
  if (obj && typeof obj === "object") {
    const out: Record<string, unknown> = {};
    for (const k of Object.keys(obj as Record<string, unknown>).sort()) {
      out[k] = sortObject((obj as Record<string, unknown>)[k]);
    }
    return out as unknown as T;
  }
  return obj;
}

function numberFromNode(node: Node | undefined): number | undefined {
  if (!node) return undefined;
  if (Node.isNumericLiteral(node)) return Number(node.getLiteralValue());
  const text = node.getText();
  if (/^0x/i.test(text)) return parseInt(text, 16);
  const n = Number(text);
  return Number.isFinite(n) ? n : undefined;
}

function stringFromNode(node: Node | undefined): string | undefined {
  if (!node) return undefined;
  if (Node.isStringLiteral(node)) return node.getLiteralText();
  return node.getText().replace(/^['"]|['"]$/g, "");
}

function parseEnumDeclarations(project: Project, root: string): Contract["enums"] {
  const enums: Contract["enums"] = {};
  for (const sf of project.getSourceFiles()) {
    const rel = path.relative(root, sf.getFilePath());
    for (const e of sf.getEnums()) {
      const values = new Map<number, string>();
      for (const m of e.getMembers()) {
        const v = m.getValue();
        if (typeof v === "number") values.set(v, m.getName());
      }
      let width = 0;
      for (const v of values.keys()) {
        const bits = Math.floor(Math.log2(v)) + 1;
        width = Math.max(width, bits);
      }
      const vals: Record<string, number> = {};
      for (const [v, name] of Array.from(values.entries()).sort((a, b) => a[0] - b[0])) {
        vals[name] = v;
      }
      enums[e.getName()] = {
        type: width ? `uint${width}` : "string",
        values: vals,
        provenance: { file: rel, line: e.getStartLineNumber() },
      };
    }
  }
  return enums;
}

function parseMessages(project: Project, root: string): Message[] {
  const messages: Message[] = [];
  for (const sf of project.getSourceFiles()) {
    const rel = path.relative(root, sf.getFilePath());
    for (const vd of sf.getVariableDeclarations()) {
      const init = vd.getInitializer();
      if (!init || !Node.isObjectLiteralExpression(init)) continue;
      const fieldsProp = init.getProperty("fields");
      const containerProp = init.getProperty("container");
      if (!fieldsProp || !containerProp) continue;
      const fieldsInit = (fieldsProp as any).getInitializer();
      const containerInit = (containerProp as any).getInitializer();
      if (
        !fieldsInit ||
        !containerInit ||
        !Node.isArrayLiteralExpression(fieldsInit) ||
        !Node.isStringLiteral(containerInit)
      ) {
        continue;
      }
      const fields: Field[] = [];
      for (const el of fieldsInit.getElements()) {
        if (!Node.isObjectLiteralExpression(el)) continue;
        const f: Field = { name: "", bitOffset: 0, bitWidth: 0 };
        for (const prop of el.getProperties()) {
          if (!Node.isPropertyAssignment(prop)) continue;
          const key = prop.getName();
          const val = prop.getInitializer();
          if (key === "name") f.name = stringFromNode(val) ?? "";
          else if (key === "bitOffset") f.bitOffset = numberFromNode(val) ?? 0;
          else if (key === "bitWidth") f.bitWidth = numberFromNode(val) ?? 0;
          else if (key === "value") {
            const n = numberFromNode(val);
            if (n !== undefined) f.value = n;
          } else if (key === "range" && Node.isArrayLiteralExpression(val)) {
            const a = val.getElements().map((e) => numberFromNode(e));
            if (a[0] !== undefined && a[1] !== undefined) f.range = [a[0]!, a[1]!];
          } else if (key === "enum") {
            const s = stringFromNode(val);
            if (s) f.enum = s;
          }
        }
        fields.push(f);
      }
      const msg: Message = {
        name: vd.getName(),
        container: containerInit.getLiteralText() as "UMP32" | "UMP64",
        fields: fields.sort((a, b) => a.bitOffset - b.bitOffset),
        provenance: { file: rel, line: vd.getStartLineNumber() },
      };
      messages.push(msg);
    }
  }
  return messages.sort((a, b) => a.name.localeCompare(b.name));
}

function parseStateMachines(project: Project, root: string): StateMachine[] {
  const machines: StateMachine[] = [];
  for (const sf of project.getSourceFiles()) {
    const rel = path.relative(root, sf.getFilePath());
    for (const vd of sf.getVariableDeclarations()) {
      const init = vd.getInitializer();
      if (!init || !Node.isObjectLiteralExpression(init)) continue;
      const statesProp = init.getProperty("states");
      const eventsProp = init.getProperty("events");
      const transProp = init.getProperty("transitions");
      if (!statesProp || !eventsProp || !transProp) continue;
      const states = (statesProp as any).getInitializerIfKind(SyntaxKind.ArrayLiteralExpression);
      const events = (eventsProp as any).getInitializerIfKind(SyntaxKind.ArrayLiteralExpression);
      const transitions = (transProp as any).getInitializerIfKind(SyntaxKind.ArrayLiteralExpression);
      if (!states || !events || !transitions) continue;
      const m: StateMachine = {
        name: vd.getName(),
        states: states
          .getElements()
          .map((e: Node) => stringFromNode(e) || "")
          .filter((s: string) => s.length > 0),
        events: events
          .getElements()
          .map((e: Node) => stringFromNode(e) || "")
          .filter((s: string) => s.length > 0),
        transitions: [],
        provenance: { file: rel, line: vd.getStartLineNumber() },
      };
      for (const tr of transitions.getElements()) {
        if (!Node.isObjectLiteralExpression(tr)) continue;
        let from = "";
        let on = "";
        let to = "";
        let guard: string | undefined;
        let action: string | undefined;
        for (const prop of tr.getProperties()) {
          if (!Node.isPropertyAssignment(prop)) continue;
          const key = prop.getName();
          const val = prop.getInitializer();
          if (key === "from") from = stringFromNode(val) || "";
          else if (key === "on") on = stringFromNode(val) || "";
          else if (key === "to") to = stringFromNode(val) || "";
          else if (key === "guard") guard = stringFromNode(val);
          else if (key === "action") action = stringFromNode(val);
        }
        m.transitions.push({ from, on, to, ...(guard ? { guard } : {}), ...(action ? { action } : {}) });
      }
      m.transitions.sort((a, b) =>
        a.from === b.from ? a.on.localeCompare(b.on) : a.from.localeCompare(b.from)
      );
      machines.push(m);
    }
  }
  return machines.sort((a, b) => a.name.localeCompare(b.name));
}

function encodeMessage(msg: Message, values: Record<string, number>): string {
  let raw = 0n;
  for (const f of msg.fields) {
    const v = BigInt(values[f.name] ?? 0);
    const mask = (1n << BigInt(f.bitWidth)) - 1n;
    raw |= (v & mask) << BigInt(f.bitOffset);
  }
  const width = msg.container === "UMP64" ? 64 : 32;
  return "0x" + raw.toString(16).toUpperCase().padStart(width / 4, "0");
}

function buildVectors(messages: Message[]): Record<string, unknown[]> {
  const out: Record<string, unknown[]> = {};
  for (const m of messages) {
    const vars = m.fields.filter((f) => f.value === undefined);
    if (!vars.length) continue;
    const base: Record<string, number> = {};
    for (const f of m.fields) base[f.name] = f.value ?? 0;
    const f = vars[0];
    const max = Number((1n << BigInt(f.bitWidth)) - 1n);
    const cases = [
      { case: `${f.name}_min`, raw: encodeMessage(m, { ...base, [f.name]: 0 }), decoded: { ...base, [f.name]: 0 } },
      {
        case: `${f.name}_max`,
        raw: encodeMessage(m, { ...base, [f.name]: max }),
        decoded: { ...base, [f.name]: max },
      },
    ];
    out[m.name] = cases;
  }
  return out;
}

function writeJson(p: string, data: unknown): void {
  ensureDir(path.dirname(p));
  fs.writeFileSync(p, JSON.stringify(sortObject(data), null, 2));
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const project = new Project({ useInMemoryFileSystem: false });
  project.addSourceFilesAtPaths(path.join(args.root, "**/*.ts"));

  const enums = parseEnumDeclarations(project, args.root);
  const messages = parseMessages(project, args.root);
  const machines = parseStateMachines(project, args.root);

  const contract: Contract = {
    meta: { workbench_commit: gitCommit(args.root), generated_at: isoNow() },
    enums,
    messages,
    state_machines: machines,
    resources: {},
  };

  writeJson(args.out, contract);

  const vectors = buildVectors(messages);
  for (const name of Object.keys(vectors).sort()) {
    const file = path.join(args.vectors, name.replace(/\./g, "_") + ".json");
    writeJson(file, vectors[name]);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});

