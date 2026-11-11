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

// eslint-disable-next-line no-control-regex
const ANSI_PATTERN = /\x1b\[[0-9;?]*[A-Za-z]/g;

function visibleWidth(text: string): number {
  return [...text.replace(ANSI_PATTERN, "")].length;
}

// Cuts a styled line to `width` visible chars so the terminal never wraps it,
// keeping escape sequences intact.
function truncateLine(line: string, width: number): string {
  if (visibleWidth(line) <= width) return line;

  const sequence = new RegExp(ANSI_PATTERN.source, "y");
  let out = "";
  let visible = 0;
  let i = 0;
  while (i < line.length && visible < width) {
    sequence.lastIndex = i;
    const match = sequence.exec(line);
    if (match) {
      out += match[0];
      i += match[0].length;
      continue;
    }
    const ch = String.fromCodePoint(line.codePointAt(i)!);
    out += ch;
    visible++;
    i += ch.length;
  }
  return out + "\x1b[0m";
}

interface MultiSelectOptions<T> {
  labelFn: (item: T, i: number) => string;
  hintFn?: (item: T, i: number) => string;
  groupFn?: (item: T) => string;
  // Extra lines shown under the list for the item under the cursor. Each line
  // must already fit in `width` visible chars.
  detailFn?: (item: T, i: number, width: number) => string[];
  initialSelected?: boolean[];
  shortcuts?: { key: string; label: string; fn: (items: T[]) => boolean[] }[];
}

export function multiSelect<T>(
  items: T[],
  { labelFn, hintFn, groupFn, detailFn, initialSelected, shortcuts = [] }: MultiSelectOptions<T>,
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
    let scrollTop = 0;
    let renderedLines = 0;

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

    const showGroups = groupCount > 1;

    // Moving the cursor up only works if every drawn line is exactly one
    // terminal row and the whole frame fits on screen; otherwise each redraw
    // leaves stale lines behind. So lines are truncated to the terminal width
    // and the list scrolls when it is taller than the terminal.
    function clearRendered(): void {
      if (renderedLines > 1) write(`\x1b[${renderedLines - 1}A`);
      if (renderedLines > 0) write("\r\x1b[J");
    }

    function render(): void {
      clearRendered();
      const lines = buildLines();
      write(lines.join("\n"));
      renderedLines = lines.length;
    }

    function buildFooter(width: number): string[] {
      const count = selected.filter(Boolean).length;
      const key = (k: string) => white(bold(`[${k}]`));
      const parts = [
        key("↑↓") + dim(" move"),
        key("space") + dim(" toggle"),
        key("a") + dim(" all"),
        ...shortcuts.map((s) => key(s.key) + dim(` ${s.label}`)),
        key("enter") + dim(` confirm (${count}/${items.length})`),
      ];

      const lines: string[] = [];
      let line = "";
      for (const part of parts) {
        const candidate = line ? line + dim(" · ") + part : "   " + part;
        if (line && visibleWidth(candidate) > width) {
          lines.push(line);
          line = "   " + part;
        } else {
          line = candidate;
        }
      }
      lines.push(line);
      return lines;
    }

    function buildLines(): string[] {
      const width = (process.stdout.columns || Infinity) - 1;
      const height = process.stdout.rows || Infinity;

      const body: string[] = [];
      const itemLines: number[] = [];
      let cursorTop = 0;
      let lastGroup: string | null = null;
      let isFirstGroup = true;

      for (let i = 0; i < items.length; i++) {
        let top = body.length;
        if (showGroups && groupFn) {
          const group = groupFn(items[i]);
          if (group !== lastGroup) {
            if (!isFirstGroup) body.push("");
            isFirstGroup = false;
            lastGroup = group;
            top = body.length;
            body.push(`   ${bold(yellow(group))}`);
          }
        }
        if (i === cursor) cursorTop = top;
        itemLines.push(body.length);

        const pointer = i === cursor ? cyan("❯") : " ";
        const check = selected[i] ? green("◼") : dim("◻");
        const label = labelFn(items[i], i);
        const hint = hintFn ? hintFn(items[i], i) : "";
        body.push(`     ${pointer} ${check} ${label}${hint ? "  " + dim(hint) : ""}`);
      }

      const footer = buildFooter(width);
      // Leave room for at least one list line and the spacer.
      const detail = (detailFn ? detailFn(items[cursor], cursor, width) : []).slice(
        0,
        Math.max(0, height - footer.length - 2),
      );
      const maxBody = Math.max(1, height - footer.length - detail.length - 1);
      let visible = body;
      let spacer = "";

      if (body.length > maxBody) {
        const cursorLine = itemLines[cursor];
        scrollTop = Math.min(scrollTop, cursorTop);
        scrollTop = Math.max(scrollTop, cursorLine - maxBody + 1);
        scrollTop = Math.max(0, Math.min(scrollTop, body.length - maxBody));
        visible = body.slice(scrollTop, scrollTop + maxBody);

        const above = itemLines.filter((line) => line < scrollTop).length;
        const below = itemLines.filter((line) => line >= scrollTop + maxBody).length;
        const more = [above > 0 && `↑ ${above} more`, below > 0 && `↓ ${below} more`];
        spacer = dim(`     ${more.filter(Boolean).join(" · ")}`);
      } else {
        scrollTop = 0;
      }

      return [...visible, spacer, ...detail, ...footer].map((line) => truncateLine(line, width));
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
