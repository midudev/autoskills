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

function existsDir(p) {
  const st = statSafe(p);
  return Boolean(st && st.isDirectory());
}

function readJsonSafe(p) {
  try {
    return JSON.parse(fs.readFileSync(p, "utf8"));
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

function summarizeBlockJson(repoRoot, blockJsonPath) {
  const json = readJsonSafe(blockJsonPath);
  if (!json) {
    return {
      path: path.relative(repoRoot, blockJsonPath),
      error: "invalid-json",
    };
  }

  const rel = path.relative(repoRoot, blockJsonPath);
  const blockRoot = path.dirname(rel);

  return {
    path: rel,
    blockRoot,
    name: typeof json?.name === "string" ? json.name : null,
    title: typeof json?.title === "string" ? json.title : null,
    apiVersion: typeof json?.apiVersion === "number" ? json.apiVersion : null,
    render: typeof json?.render === "string" ? json.render : null,
    viewScript: json?.viewScript ?? null,
    viewScriptModule: json?.viewScriptModule ?? null,
    editorScript: json?.editorScript ?? null,
    script: json?.script ?? null,
    style: json?.style ?? null,
    editorStyle: json?.editorStyle ?? null,
    attributes: json?.attributes ? Object.keys(json.attributes).slice(0, 50) : [],
  };
}

function main() {
  const repoRoot = process.cwd();

  const { results: blockJsonFiles, truncated } = findFilesRecursive(repoRoot, (p) => path.basename(p) === "block.json", {
    maxFiles: 8000,
    maxDepth: 12,
  });

  const blocks = blockJsonFiles.map((p) => summarizeBlockJson(repoRoot, p));

  const report = {
    tool: { name: "list_blocks", version: "0.1.0" },
    repoRoot,
    truncated,
    count: blocks.length,
    blocks,
  };

  process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
}

main();

