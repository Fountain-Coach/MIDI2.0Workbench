/**
 * Minimal stub for a JSON-RPC headless Workbench runner.
 *
 * The production version will spawn the Workbench, expose its JSON-RPC
 * interface, and mediate traffic between external clients (e.g. the
 * generated Swift library).  For now we simply prove out the CLI surface
 * and exit immediately so callers can depend on the script's presence.
 */

interface RunnerOptions {
  port: number;
}

function parseArgs(): RunnerOptions {
  const portIndex = process.argv.indexOf('--port');
  const port = portIndex >= 0 ? Number(process.argv[portIndex + 1]) : 5000;
  return { port };
}

async function main() {
  const opts = parseArgs();
  console.log(
    `Headless runner placeholder listening on port ${opts.port}. ` +
      `Integrate with Workbench runtime to enable JSON-RPC commands.`
  );
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
