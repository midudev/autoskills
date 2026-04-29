import fs from "node:fs";
import path from "node:path";

const DEFAULT_IGNORES = new Set([
  ".git",
  "node_modules",
  "vendor",
  "dist",
  "build",
  "coverage",
  ".next",
  ".turbo",
]);

function statSafe(p) {
  try {
    return fs.statSync(p);
  } catch {
    return null;
  }
}

function readFileSafe(p, maxBytes = 128 * 1024) {
  try {
    const buf = fs.readFileSync(p);
    if (buf.byteLength > maxBytes) return buf.subarray(0, maxBytes).toString("utf8");
    return buf.toString("utf8");
  } catch {
    return null;
  }
}

function findFilesRecursive(repoRoot, predicate, { maxFiles = 6000, maxDepth = 10 } = {}) {
  const results = [];
  const queue = [{ dir: repoRoot, depth: 0 }];
  let visited = 0;

  while (queue.length > 0) {
    const { dir, depth } = queue.shift();
    if (depth > maxDepth) continue;

    let entries;
    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch {
      continue;
    }

    for (const ent of entries) {
      const fullPath = path.join(dir, ent.name);
      if (ent.isDirectory()) {
        if (DEFAULT_IGNORES.has(ent.name)) continue;
        queue.push({ dir: fullPath, depth: depth + 1 });
        continue;
      }
      if (!ent.isFile()) continue;

      visited += 1;
      if (visited > maxFiles) return { results, truncated: true };
      if (predicate(fullPath)) results.push(fullPath);
    }
  }

  return { results, truncated: false };
}

function parsePluginHeader(contents) {
  // WordPress reads plugin headers from the top of the file. We only need key fields.
  const header = {};
  const pairs = [
    ["Plugin Name", "name"],
    ["Plugin URI", "uri"],
    ["Description", "description"],
    ["Version", "version"],
    ["Author", "author"],
    ["Author URI", "authorUri"],
    ["Text Domain", "textDomain"],
    ["Domain Path", "domainPath"],
  ];
  for (const [label, key] of pairs) {
    const m = contents.match(new RegExp(`^\\s*${label}:\\s*(.+)\\s*$`, "im"));
    if (m) header[key] = m[1].trim();
  }
  if (!header.name) return null;
  return header;
}

function main() {
  const repoRoot = process.cwd();

  const { results: phpFiles, truncated } = findFilesRecursive(repoRoot, (p) => p.toLowerCase().endsWith(".php"), {
    maxFiles: 5000,
    maxDepth: 10,
  });

  const plugins = [];

  for (const phpPath of phpFiles) {
    const txt = readFileSafe(phpPath);
    if (!txt) continue;
    if (!/Plugin Name:/i.test(txt)) continue;
    const header = parsePluginHeader(txt);
    if (!header) continue;
    plugins.push({
      pluginFile: path.relative(repoRoot, phpPath),
      ...header,
    });
  }

  const report = {
    tool: { name: "detect_plugins", version: "0.1.0" },
    repoRoot,
    truncated,
    count: plugins.length,
    plugins,
  };

  process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
}

main();

