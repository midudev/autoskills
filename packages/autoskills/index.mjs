#!/usr/bin/env node

import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const [major, minor] = process.versions.node.split(".").map(Number);

if (major < 22 || (major === 22 && minor < 6)) {
  console.error(
    `\n  ⚠ autoskills requires Node.js >= 22.6.0.` +
      `\n  Current version: ${process.version}` +
      `\n  Please upgrade → https://nodejs.org\n`,
  );
  process.exit(1);
}

const __dirname = dirname(fileURLToPath(import.meta.url));

if (existsSync(join(__dirname, "dist", "main.js"))) {
  await import("./dist/main.js");
} else {
  try {
    await import("./main.ts");
  } catch (err) {
    if (err.code !== "ERR_UNKNOWN_FILE_EXTENSION") throw err;

    const { spawn } = await import("node:child_process");
    const mainPath = join(__dirname, "main.ts");
    const child = spawn(
      process.execPath,
      [
        "--experimental-strip-types",
        "--disable-warning=ExperimentalWarning",
        mainPath,
        ...process.argv.slice(2),
      ],
      { stdio: "inherit" },
    );
    child.on("exit", (code, signal) => {
      if (signal) process.kill(process.pid, signal);
      else process.exit(code ?? 1);
    });
  }
}
