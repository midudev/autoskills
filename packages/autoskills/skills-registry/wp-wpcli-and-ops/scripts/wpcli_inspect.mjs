import { spawnSync } from "node:child_process";

const TOOL_VERSION = "0.1.0";

function parseArgs(argv) {
  const args = { path: null, url: null, allowRoot: false };
  for (const a of argv) {
    if (a === "--allow-root") args.allowRoot = true;
    if (a.startsWith("--path=")) args.path = a.slice("--path=".length);
    if (a.startsWith("--url=")) args.url = a.slice("--url=".length);
  }
  return args;
}

function runWp(cmdArgs, { pathArg, urlArg, allowRoot }) {
  const args = [];
  if (allowRoot) args.push("--allow-root");
  if (pathArg) args.push(`--path=${pathArg}`);
  if (urlArg) args.push(`--url=${urlArg}`);
  args.push(...cmdArgs);

  const out = spawnSync("wp", args, { encoding: "utf8" });
  return {
    ok: out.status === 0,
    status: out.status,
    error: out.error ? { message: out.error.message, code: out.error.code } : null,
    stdout: (out.stdout || "").trim(),
    stderr: (out.stderr || "").trim(),
    args,
  };
}

function main() {
  const opts = parseArgs(process.argv.slice(2));

  const info = runWp(["--info"], { pathArg: null, urlArg: null, allowRoot: opts.allowRoot });
  const report = {
    tool: { name: "wpcli_inspect", version: TOOL_VERSION },
    wpCli: {
      available: info.ok,
      info,
    },
    wordpress: {
      path: opts.path,
      url: opts.url,
      isInstalled: null,
      coreVersion: null,
      isMultisite: null,
      siteurl: null,
      home: null,
    },
    notes: [],
  };

  if (!info.ok) {
    report.notes.push("WP-CLI not available on PATH. Install WP-CLI or run inside the intended container/environment.");
    process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
    return;
  }

  const isInstalled = runWp(["core", "is-installed"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wordpress.isInstalled = isInstalled.ok;

  if (!isInstalled.ok) {
    report.notes.push("WordPress not detected at the given path/url. Check --path/--url (multisite) and that wp-config.php is present.");
    process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
    return;
  }

  const coreVersion = runWp(["core", "version"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wordpress.coreVersion = coreVersion.ok ? coreVersion.stdout : null;

  const isMultisite = runWp(["core", "is-installed", "--network"], {
    pathArg: opts.path,
    urlArg: opts.url,
    allowRoot: opts.allowRoot,
  });
  // If network check passes, we can assume multisite. If it fails, it might still be multisite depending on context.
  report.wordpress.isMultisite = isMultisite.ok;

  const siteurl = runWp(["option", "get", "siteurl"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wordpress.siteurl = siteurl.ok ? siteurl.stdout : null;

  const home = runWp(["option", "get", "home"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wordpress.home = home.ok ? home.stdout : null;

  process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
}

main();
