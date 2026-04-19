const noColor = "NO_COLOR" in process.env;
const forceColor = "FORCE_COLOR" in process.env;
const useColor = forceColor || (!noColor && process.stdout.isTTY);

export const bold = useColor ? (s: string) => `\x1b[1m${s}\x1b[22m` : (s: string) => s;
export const dim = useColor ? (s: string) => `\x1b[2m${s}\x1b[22m` : (s: string) => s;
export const green = useColor ? (s: string) => `\x1b[32m${s}\x1b[39m` : (s: string) => s;
export const yellow = useColor ? (s: string) => `\x1b[33m${s}\x1b[39m` : (s: string) => s;
export const cyan = useColor ? (s: string) => `\x1b[36m${s}\x1b[39m` : (s: string) => s;
export const red = useColor ? (s: string) => `\x1b[31m${s}\x1b[39m` : (s: string) => s;
export const magenta = useColor ? (s: string) => `\x1b[35m${s}\x1b[39m` : (s: string) => s;
export const gray = useColor ? (s: string) => `\x1b[38;5;240m${s}\x1b[39m` : (s: string) => s;
export const white = useColor ? (s: string) => `\x1b[97m${s}\x1b[39m` : (s: string) => s;
export const pink = useColor ? (s: string) => `\x1b[38;5;218m${s}\x1b[39m` : (s: string) => s;

export const log = console.log.bind(console);
export const write = process.stdout.write.bind(process.stdout);

export const HIDE_CURSOR = process.stdout.isTTY ? "\x1b[?25l" : "";
export const SHOW_CURSOR = process.stdout.isTTY ? "\x1b[?25h" : "";
export const SPINNER = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
