#!/usr/bin/env bash
# extract-endpoint-detail.sh
#
# Extracts full details for a specific endpoint from an OpenAPI YAML spec (stdin),
# including parameters, request body, responses, and all referenced component schemas.
#
# Usage:
#   curl -s <spec-url> | bash extract-endpoint-detail.sh "/users/{user_id}/billing/subscription" "get"

set -euo pipefail

ENDPOINT="${1:?Usage: extract-endpoint-detail.sh <path> <method>}"
METHOD="${2:?Usage: extract-endpoint-detail.sh <path> <method>}"
TMPDIR_WORK=$(mktemp -d)
trap 'rm -rf "$TMPDIR_WORK"' EXIT

SPEC="$TMPDIR_WORK/spec.yml"
cat > "$SPEC"

node - "$ENDPOINT" "$METHOD" "$SPEC" <<'SCRIPT'
const fs = require("fs");
const endpoint = process.argv[2];
const method = process.argv[3].toLowerCase();
const specFile = process.argv[4];
const lines = fs.readFileSync(specFile, "utf8").split("\n");

const httpMethods = ["get", "post", "put", "patch", "delete", "options", "head"];

// Locate paths: and components: sections
let pathsStart = -1, pathsEnd = -1, componentsStart = -1;
for (let i = 0; i < lines.length; i++) {
  if (/^paths:\s*$/.test(lines[i])) pathsStart = i;
  else if (pathsStart >= 0 && pathsEnd < 0 && /^\S/.test(lines[i]) && i > pathsStart) pathsEnd = i;
  if (/^components:\s*$/.test(lines[i])) componentsStart = i;
}
if (pathsEnd < 0) pathsEnd = lines.length;

// Find the target path + method block
let targetStart = -1, targetEnd = -1;
let currentPath = null;

for (let i = pathsStart + 1; i < pathsEnd; i++) {
  const line = lines[i];

  // Path line: exactly 2 spaces + /
  if (/^ {2}\/\S/.test(line)) {
    currentPath = line.trim().replace(/:$/, "");
    continue;
  }

  // Method line: exactly 4 spaces + method name
  const methodMatch = line.match(/^ {4}(\w+):\s*$/);
  if (methodMatch && httpMethods.includes(methodMatch[1])) {
    if (currentPath === endpoint && methodMatch[1] === method) {
      targetStart = i;
      // Find end of this method block
      for (let j = i + 1; j < pathsEnd; j++) {
        const nextLine = lines[j];
        // New method or new path
        if (/^ {2}\/\S/.test(nextLine) || (/^ {4}\w+:\s*$/.test(nextLine) && httpMethods.some(m => nextLine.trim().startsWith(m + ":")))) {
          targetEnd = j;
          break;
        }
      }
      if (targetEnd < 0) targetEnd = pathsEnd;
      break;
    }
  }
}

if (targetStart < 0) {
  console.error(`Endpoint not found: ${method.toUpperCase()} ${endpoint}`);
  process.exit(1);
}

const blockLines = lines.slice(targetStart, targetEnd);

// Collect all $refs from the block
const allRefs = new Set();
for (const bl of blockLines) {
  const refMatch = bl.match(/\$ref:\s*['"]?(#\/[^'"}\s]+)['"]?/);
  if (refMatch) allRefs.add(refMatch[1]);
}

// Resolve a $ref path to the raw YAML lines for that component
function resolveRef(ref) {
  const parts = ref.replace("#/", "").split("/");
  // Find the component in the file by walking indentation
  let searchStart = 0;
  for (let p = 0; p < parts.length; p++) {
    const indent = p * 2;
    const target = " ".repeat(indent) + parts[p] + ":";
    let found = false;
    for (let i = searchStart; i < lines.length; i++) {
      if (lines[i].startsWith(target) && (lines[i] === target || lines[i][target.length] === " ")) {
        searchStart = i + 1;
        found = true;
        break;
      }
    }
    if (!found) return null;
  }

  // Collect lines for this component (until same or lower indent)
  const componentStart = searchStart - 1;
  const baseIndent = parts.length * 2;
  const result = [];
  for (let i = searchStart; i < lines.length; i++) {
    const line = lines[i];
    if (line.trim() === "") { result.push(line); continue; }
    const lineIndent = line.length - line.trimStart().length;
    if (lineIndent < baseIndent) break;
    result.push(line);
  }
  return result;
}

// Recursively resolve refs from component bodies
function collectDeepRefs(refSet, visited) {
  const toProcess = [...refSet].filter(r => !visited.has(r));
  for (const ref of toProcess) {
    visited.add(ref);
    const body = resolveRef(ref);
    if (!body) continue;
    for (const bl of body) {
      const refMatch = bl.match(/\$ref:\s*['"]?(#\/[^'"}\s]+)['"]?/);
      if (refMatch && !visited.has(refMatch[1])) {
        refSet.add(refMatch[1]);
      }
    }
  }
  // Recurse if new refs were found
  const newRefs = [...refSet].filter(r => !visited.has(r));
  if (newRefs.length > 0) collectDeepRefs(refSet, visited);
}

collectDeepRefs(allRefs, new Set());

// Output
console.log(`## \`${method.toUpperCase()}\` \`${endpoint}\`\n`);
console.log("### Endpoint Definition\n");
console.log("```yaml");
for (const bl of blockLines) {
  console.log(bl);
}
console.log("```\n");

if (allRefs.size > 0) {
  console.log(`### Referenced Components (${allRefs.size})\n`);
  const sorted = [...allRefs].sort();
  for (const ref of sorted) {
    const name = ref.split("/").pop();
    const category = ref.replace("#/", "").split("/").slice(0, -1).join("/");
    console.log(`#### \`${name}\` (${category})\n`);
    const body = resolveRef(ref);
    if (body) {
      console.log("```yaml");
      for (const bl of body) console.log(bl);
      console.log("```\n");
    } else {
      console.log("_(could not resolve)_\n");
    }
  }
}
SCRIPT
