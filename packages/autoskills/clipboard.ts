import { spawn as realSpawn } from "node:child_process";

export interface CopyResult {
  ok: boolean;
  tool?: string;
  error?: string;
}

interface Candidate { cmd: string; args: string[] }

interface SpawnedProcess {
  stdin: { write(s: string): void; end(): void };
  on(event: "close" | "error", cb: (...args: unknown[]) => void): unknown;
}

type SpawnFn = (cmd: string, args: string[]) => SpawnedProcess;

export interface CopyOptions {
  platform?: NodeJS.Platform;
  spawnFn?: SpawnFn;
}

function candidatesFor(platform: NodeJS.Platform): Candidate[] {
  if (platform === "darwin") return [{ cmd: "pbcopy", args: [] }];
  if (platform === "win32") return [{ cmd: "clip.exe", args: [] }];
  if (platform === "linux") {
    return [
      { cmd: "wl-copy", args: [] },
      { cmd: "xclip", args: ["-selection", "clipboard"] },
    ];
  }
  return [];
}

function tryOne(spawnFn: SpawnFn, cmd: string, args: string[], text: string): Promise<CopyResult & { _enoent?: boolean }> {
  return new Promise((resolve) => {
    let settled = false;
    const settle = (r: CopyResult & { _enoent?: boolean }) => {
      if (settled) return;
      settled = true;
      resolve(r);
    };
    const child = spawnFn(cmd, args);
    child.on("error", (...evtArgs) => {
      const err = evtArgs[0] as NodeJS.ErrnoException;
      if (err && err.code === "ENOENT") {
        settle({ ok: false, _enoent: true });
        return;
      }
      settle({ ok: false, error: err?.message ?? "spawn error" });
    });
    child.on("close", (...evtArgs) => {
      const code = evtArgs[0] as number | null;
      if (code === 0) settle({ ok: true, tool: cmd });
      else settle({ ok: false, error: `${cmd} exit ${code}` });
    });
    try {
      child.stdin.write(text);
      child.stdin.end();
    } catch (err) {
      settle({ ok: false, error: (err as Error).message });
    }
  });
}

export async function copyToClipboard(text: string, opts: CopyOptions = {}): Promise<CopyResult> {
  const platform = opts.platform ?? process.platform;
  const spawnFn = opts.spawnFn ?? (realSpawn as unknown as SpawnFn);
  const candidates = candidatesFor(platform);
  if (candidates.length === 0) {
    return { ok: false, error: `unsupported platform: ${platform}` };
  }
  let lastError: string | undefined;
  for (const { cmd, args } of candidates) {
    const r = await tryOne(spawnFn, cmd, args, text);
    if (r.ok) return r;
    if (r._enoent) {
      lastError = "no clipboard tool found";
      continue;
    }
    return { ok: false, error: r.error };
  }
  return { ok: false, error: lastError ?? "no clipboard tool found" };
}
