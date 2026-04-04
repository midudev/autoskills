import {
  log,
  write,
  bold,
  dim,
  green,
  yellow,
  cyan,
  gray,
  white,
  HIDE_CURSOR,
  SHOW_CURSOR,
} from "./colors.mjs";

/**
 * Formats a duration in milliseconds into a human-readable string.
 * Returns `"42ms"`, `"3.2s"`, or `"2m 15s"` depending on magnitude.
 * @param {number} ms - Duration in milliseconds.
 * @returns {string}
 */
export function formatTime(ms) {
  if (ms < 1000) return `${ms}ms`;

  const s = ms / 1000;
  if (s < 60) return `${s.toFixed(1)}s`;

  const m = Math.floor(s / 60);
  return `${m}m ${Math.round(s % 60)}s`;
}

/**
 * Prints the autoskills ASCII banner with version number to stdout.
 * @param {string} version - Current package version (without the `v` prefix).
 */
export function printBanner(version) {
  const ver = `v${version}`;
  const title = "   autoskills";
  const gap = " ".repeat(39 - title.length - ver.length - 3);

  log();
  log(bold(cyan("   ╔═══════════════════════════════════════╗")));
  log(bold(cyan("   ║")) + bold(yellow(title)) + gap + gray(ver) + "   " + bold(cyan("║")));
  log(bold(cyan("   ║")) + dim("   Auto-install the best AI skills     ") + bold(cyan("║")));
  log(bold(cyan("   ║")) + dim("   for your project                    ") + bold(cyan("║")));
  log(bold(cyan("   ╚═══════════════════════════════════════╝")));
  log();
}

/**
 * Interactive multi-select with optional group headers.
 * All items are selected by default.
 */
export function multiSelect(items, { labelFn, hintFn, groupFn }) {
  if (!process.stdin.isTTY) return Promise.resolve(items);

  return new Promise((resolve) => {
    const selected = Array.from({ length: items.length }, () => true);
    let cursor = 0;
    let rendered = false;

    let groupCount = 0;
    if (groupFn) {
      let last = null;
      for (const item of items) {
        const g = groupFn(item);
        if (g !== last) {
          groupCount++;
          last = g;
        }
      }
    }

    const separatorCount = groupCount > 1 ? groupCount - 1 : 0;

    function render() {
      if (rendered) {
        write(`\x1b[${items.length + groupCount + separatorCount + 1}A\r`);
      }
      rendered = true;
      write("\x1b[J");
      draw();
    }

    function draw() {
      const count = selected.filter(Boolean).length;
      let lastGroup = null;
      let isFirstGroup = true;

      for (let i = 0; i < items.length; i++) {
        if (groupFn) {
          const group = groupFn(items[i]);
          if (group !== lastGroup) {
            if (!isFirstGroup) write("\n");
            isFirstGroup = false;
            lastGroup = group;
            write(`   ${bold(yellow(group))}\n`);
          }
        }
        const pointer = i === cursor ? cyan("❯") : " ";
        const check = selected[i] ? green("◼") : dim("◻");
        const label = labelFn(items[i], i);
        const hint = hintFn ? hintFn(items[i], i) : "";
        const line = selected[i] ? label : dim(label);
        write(`     ${pointer} ${check} ${line}${hint ? "  " + dim(hint) : ""}\n`);
      }
      write("\n");
      write(
        dim("   ") +
          white(bold("[↑↓]")) +
          dim(" move · ") +
          white(bold("[space]")) +
          dim(" toggle · ") +
          white(bold("[a]")) +
          dim(" all · ") +
          white(bold("[enter]")) +
          dim(` confirm (${count}/${items.length})`),
      );
    }

    write(HIDE_CURSOR);
    render();

    const { stdin } = process;
    stdin.setRawMode(true);
    stdin.resume();
    stdin.setEncoding("utf-8");

    function onData(key) {
      if (key === "\x03") {
        cleanup();
        write(SHOW_CURSOR + "\n");
        process.exit(0);
      }

      if (key === "\r" || key === "\n") {
        cleanup();
        write("\x1b[1A\r\x1b[J");
        write(SHOW_CURSOR);
        resolve(items.filter((_, i) => selected[i]));
        return;
      }

      if (key === " ") {
        selected[cursor] = !selected[cursor];
        render();
        return;
      }

      if (key === "a") {
        const allSelected = selected.every(Boolean);
        selected.fill(!allSelected);
        render();
        return;
      }

      if (key === "\x1b[A" || key === "k") {
        cursor = (cursor - 1 + items.length) % items.length;
        render();
        return;
      }
      if (key === "\x1b[B" || key === "j") {
        cursor = (cursor + 1) % items.length;
        render();
        return;
      }
    }

    function cleanup() {
      stdin.setRawMode(false);
      stdin.pause();
      stdin.removeListener("data", onData);
    }

    stdin.on("data", onData);
  });
}
