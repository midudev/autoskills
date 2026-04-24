let input = "";
process.stdin.on("data", d => input += d);
process.stdin.on("end", () => {
  const lines = input.replace(/\r/g, "").split("\n");
  let inTags = false;
  for (const line of lines) {
    if (line === "tags:") { inTags = true; continue; }
    if (inTags && line.length > 0 && line[0] !== " ") break;
    if (inTags) {
      const m = line.match(/^\s{2}- name:\s*(.+)/);
      if (m) console.log(m[1]);
    }
  }
});
