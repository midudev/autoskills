import {
  log,
  write,
  bold,
  dim,
  green,
  yellow,
  cyan,
  white,
  HIDE_CURSOR,
  SHOW_CURSOR,
} from "./colors.ts";

const LOGO_LINES = [
  "┌─┐┬ ┬┌┬┐┌─┐┌─┐┬┌─┬┬  ┬  ┌─┐",
  "├─┤│ │ │ │ │└─┐├┴┐││  │  └─┐",
  "┴ ┴└─┘ ┴ └─┘└─┘┴ ┴┴┴─┘┴─┘└─┘",
];

export function formatTime(ms: number): string {
  if (ms < 1000) return `${ms}ms`;

  const s = ms / 1000;
  if (s < 60) return `${s.toFixed(1)}s`;

  const m = Math.floor(s / 60);
  return `${m}m ${Math.round(s % 60)}s`;
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function rgb(grayValue: number, text: string): string {
  return `\x1b[38;2;${grayValue};${grayValue};${grayValue}m${text}\x1b[39m`;
}

function renderAnimatedLogo(frame: number, speed: number): string[] {
  const waveFront = frame * speed;

  return LOGO_LINES.map((line, row) =>
    [...line]
      .map((ch, col) => {
        if (ch === " ") return ch;
        const distance = col + row * 2;
        const progress = Math.max(0, Math.min(1, (waveFront - distance) / 10));
        const grayValue = Math.round(63 + progress * (244 - 63));
        return rgb(grayValue, ch);
      })
      .join(""),
  );
}

export async function printBanner(version: string): Promise<void> {
  const ver = `v${version}`;
  const subtitle = `Auto-install the best AI skills for your project · ${ver}`;

  if (!process.stdout.isTTY || "NO_COLOR" in process.env) {
    log();
    for (const line of LOGO_LINES) log(bold(cyan(line)));
    log(dim(subtitle));
    log();
    return;
  }

  const cols = Math.max(...LOGO_LINES.map((line) => line.length));
  const rows = LOGO_LINES.length;
  const speed = 2.5;
  const frameDelay = 28;
  const totalFrames = Math.ceil((cols + rows * 2 + 10) / speed);

  write(HIDE_CURSOR + "\n");
  for (let frame = 0; frame <= totalFrames; frame++) {
    const lines = renderAnimatedLogo(frame, speed);
    write(lines.map((line) => `   ${line}`).join("\n"));
    write("\n");

    if (frame < totalFrames) {
      write(`\x1b[${rows}A\r`);
      await sleep(frameDelay);
    }
  }

  write(dim(`   ${subtitle}`) + "\n");
  write(SHOW_CURSOR);
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

    function renderedLineCount(): number {
      return items.length + groupCount + separatorCount + 1;
    }

    function clearRendered(): void {
      if (rendered) {
        write(`\x1b[${renderedLineCount()}A\r\x1b[J`);
      }
    }

    function render(): void {
      clearRendered();
      rendered = true;
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
        write(`     ${pointer} ${check} ${label}${hint ? "  " + dim(hint) : ""}\n`);
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
        clearRendered();
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
