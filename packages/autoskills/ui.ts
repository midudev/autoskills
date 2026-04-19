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
} from "./colors.ts";

export function formatTime(ms: number): string {
  if (ms < 1000) return `${ms}ms`;

  const s = ms / 1000;
  if (s < 60) return `${s.toFixed(1)}s`;

  const m = Math.floor(s / 60);
  return `${m}m ${Math.round(s % 60)}s`;
}

export function printBanner(version: string): void {
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

interface MultiSelectOptions<T> {
  labelFn: (item: T, i: number) => string;
  hintFn?: (item: T, i: number) => string;
  groupFn?: (item: T) => string;
  initialSelected?: boolean[];
  shortcuts?: { key: string; label: string; fn: (items: T[]) => boolean[] }[];
}

export function multiSelect<T>(
  items: T[],
  { labelFn, hintFn, groupFn, initialSelected, shortcuts = [] }: MultiSelectOptions<T>,
): Promise<T[]> {
  if (initialSelected && initialSelected.length !== items.length) {
    throw new Error(
      `initialSelected length (${initialSelected.length}) must match items length (${items.length})`,
    );
  }

  if (!process.stdin.isTTY) return Promise.resolve(items);

  return new Promise((resolve) => {
    const selected = initialSelected
      ? initialSelected.slice()
      : Array.from({ length: items.length }, () => true);
    let cursor = 0;
    let rendered = false;

    let groupCount = 0;
    if (groupFn) {
      let last: string | null = null;
      for (const item of items) {
        const g = groupFn(item);
        if (g !== last) {
          groupCount++;
          last = g;
        }
      }
    }

    const separatorCount = groupCount > 1 ? groupCount - 1 : 0;

    function render(): void {
      if (rendered) {
        write(`\x1b[${items.length + groupCount + separatorCount + 1}A\r`);
      }
      rendered = true;
      write("\x1b[J");
      draw();
    }

    function draw(): void {
      const count = selected.filter(Boolean).length;
      let lastGroup: string | null = null;
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
      const shortcutHints = shortcuts
        .map((s) => white(bold(`[${s.key}]`)) + dim(` ${s.label}`))
        .join(dim(" · "));
      const shortcutPart = shortcuts.length > 0 ? shortcutHints + dim(" · ") : "";
      write(
        dim("   ") +
          white(bold("[↑↓]")) +
          dim(" move · ") +
          white(bold("[space]")) +
          dim(" toggle · ") +
          white(bold("[a]")) +
          dim(" all · ") +
          shortcutPart +
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

    let settled = false;

    function onData(data: string): void {
      if (settled) return;

      if (data.startsWith("\x1b")) {
        processKey(data);
        return;
      }

      for (const ch of data.replace(/\r\n/g, "\r")) {
        if (settled) return;
        processKey(ch);
      }
    }

    function processKey(key: string): void {
      if (key === "\x03") {
        cleanup();
        write(SHOW_CURSOR + "\n");
        process.exit(0);
      }

      if (key === "\r" || key === "\n") {
        settled = true;
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

      for (const shortcut of shortcuts) {
        if (key === shortcut.key) {
          const result = shortcut.fn(items);
          for (let i = 0; i < selected.length; i++) selected[i] = result[i];
          render();
          return;
        }
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

    function cleanup(): void {
      stdin.setRawMode(false);
      stdin.pause();
      stdin.removeListener("data", onData);
    }

    stdin.on("data", onData);
  });
}
