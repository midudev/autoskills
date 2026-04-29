import fs from "node:fs";
import path from "node:path";
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

function existsFile(p) {
  try {
    return fs.statSync(p).isFile();
  } catch {
    return false;
  }
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

function canRun(report, result, noteIfNotOk) {
  report._runs.push({ cmd: result.args.join(" "), ok: result.ok, status: result.status, error: result.error });
  if (!result.ok && noteIfNotOk) report.notes.push(noteIfNotOk);
  return result.ok;
}

function main() {
  const opts = parseArgs(process.argv.slice(2));
  const report = {
    tool: { name: "perf_inspect", version: TOOL_VERSION },
    target: { path: opts.path, url: opts.url },
    wpCli: { available: false },
    wp: {
      isInstalled: null,
      coreVersion: null,
    },
    commands: {
      doctor: { available: false },
      profile: { available: false },
    },
    perfSignals: {
      autoloadTotalBytes: null,
      hasObjectCacheDropin: null,
      hasAdvancedCacheDropin: null,
      hasQueryMonitorPlugin: null,
      hasPerformanceLabPlugin: null,
    },
    notes: [],
    _runs: [],
  };

  const info = runWp(["--info"], { pathArg: null, urlArg: null, allowRoot: opts.allowRoot });
  report.wpCli.available = info.ok;
  report.wpCli.info = info;
  if (!info.ok) {
    report.notes.push("WP-CLI not available on PATH. Run in the intended environment (container/ssh) or install WP-CLI.");
    process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
    return;
  }

  const isInstalled = runWp(["core", "is-installed"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wp.isInstalled = isInstalled.ok;
  canRun(report, isInstalled, "WordPress not detected at the given --path/--url (check wp-config.php and targeting).");
  if (!isInstalled.ok) {
    process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
    return;
  }

  const coreVersion = runWp(["core", "version"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.wp.coreVersion = coreVersion.ok ? coreVersion.stdout : null;
  canRun(report, coreVersion);

  const doctorHelp = runWp(["doctor", "--help"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.commands.doctor.available = doctorHelp.ok;
  canRun(report, doctorHelp);

  const profileHelp = runWp(["profile", "--help"], { pathArg: opts.path, urlArg: opts.url, allowRoot: opts.allowRoot });
  report.commands.profile.available = profileHelp.ok;
  canRun(report, profileHelp);

  const autoloadBytes = runWp(["option", "list", "--autoload=on", "--format=total_bytes"], {
    pathArg: opts.path,
    urlArg: opts.url,
    allowRoot: opts.allowRoot,
  });
  if (autoloadBytes.ok && /^\d+$/.test(autoloadBytes.stdout)) {
    report.perfSignals.autoloadTotalBytes = Number(autoloadBytes.stdout);
  }
  canRun(report, autoloadBytes);

  if (opts.path) {
    const wpContent = path.join(opts.path, "wp-content");
    report.perfSignals.hasObjectCacheDropin = existsFile(path.join(wpContent, "object-cache.php"));
    report.perfSignals.hasAdvancedCacheDropin = existsFile(path.join(wpContent, "advanced-cache.php"));
    report.perfSignals.hasQueryMonitorPlugin = existsFile(path.join(wpContent, "plugins", "query-monitor", "query-monitor.php"));
    report.perfSignals.hasPerformanceLabPlugin = existsFile(path.join(wpContent, "plugins", "performance-lab", "load.php"));
  }

  if (!report.commands.doctor.available) report.notes.push("Tip: install WP-CLI doctor: `wp package install wp-cli/doctor-command`.");
  if (!report.commands.profile.available) report.notes.push("Tip: install WP-CLI profile: `wp package install wp-cli/profile-command`.");

  process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
}

main();

