#!/usr/bin/env node

import { performance } from "node:perf_hooks";
import { join } from "node:path";
import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import {
  detectTechnologies,
  hasWebFrontendFiles,
  resolveWorkspaces,
  collectSkills,
  detectCombos,
  SKILLS_MAP,
} from "../lib.mjs";

const RUNS = Number(process.argv[2]) || 50;

function bench(label, fn) {
  fn();

  const times = [];
  for (let i = 0; i < RUNS; i++) {
    const t0 = performance.now();
    fn();
    times.push(performance.now() - t0);
  }
  times.sort((a, b) => a - b);
  const median = times[Math.floor(RUNS / 2)];
  const p95 = times[Math.floor(RUNS * 0.95)];
  const avg = times.reduce((a, b) => a + b, 0) / RUNS;
  console.log(
    `  ${label.padEnd(38)} median=${median.toFixed(3)}ms  p95=${p95.toFixed(3)}ms  avg=${avg.toFixed(3)}ms`,
  );
}

function writePkg(dir, data = {}) {
  writeFileSync(join(dir, "package.json"), JSON.stringify(data));
}

function writeAt(dir, relativePath, content = "") {
  const full = join(dir, relativePath);
  mkdirSync(join(full, ".."), { recursive: true });
  writeFileSync(full, content);
}

function makeTmp(prefix) {
  return mkdtempSync(join(tmpdir(), `bench-${prefix}-`));
}

// ── Fixture: monorepo with 10 workspaces ──────────────────────

function createMonorepoFixture() {
  const root = makeTmp("monorepo");
  writePkg(root, {
    dependencies: { astro: "5.0.0", tailwindcss: "4.0.0", typescript: "5.0.0" },
    devDependencies: { vitest: "3.0.0", oxlint: "1.0.0" },
  });
  writeAt(root, "tsconfig.json", "{}");
  writeAt(
    root,
    "pnpm-workspace.yaml",
    "packages:\n" + Array.from({ length: 10 }, (_, i) => `  - packages/ws-${i}`).join("\n"),
  );

  const wsDeps = [
    { react: "19.0.0", "react-dom": "19.0.0", next: "15.0.0" },
    { vue: "3.5.0", nuxt: "4.0.0", pinia: "3.0.0" },
    { svelte: "5.0.0", "@sveltejs/kit": "2.0.0" },
    { "@angular/core": "19.0.0" },
    { expo: "52.0.0", "react-native": "0.76.0", react: "19.0.0" },
    { prisma: "6.0.0", "@prisma/client": "6.0.0", "drizzle-orm": "1.0.0" },
    { stripe: "17.0.0", hono: "4.0.0" },
    { "@clerk/nextjs": "6.0.0", "better-auth": "1.0.0" },
    { wrangler: "3.0.0", "@cloudflare/workers-types": "4.0.0", vite: "6.0.0" },
    { "@supabase/supabase-js": "2.0.0", ai: "4.0.0", remotion: "4.0.0" },
  ];

  for (let i = 0; i < 10; i++) {
    const wsDir = join(root, `packages/ws-${i}`);
    mkdirSync(wsDir, { recursive: true });
    writePkg(wsDir, { dependencies: wsDeps[i] });
  }

  return root;
}

// ── Fixture: JVM project (Gradle + Kotlin + Android + Java + Spring) ──

function createJvmFixture() {
  const root = makeTmp("jvm");
  writeAt(
    root,
    "build.gradle.kts",
    [
      'plugins { kotlin("multiplatform") version "2.1.0" }',
      "sourceCompatibility = JavaVersion.VERSION_21",
    ].join("\n"),
  );
  writeAt(root, "settings.gradle.kts", 'rootProject.name = "my-app"');
  writeAt(root, "gradle/libs.versions.toml", '[versions]\nkotlin = "2.1.0"');
  writeAt(
    root,
    "pom.xml",
    "<project><dependencies><dependency>spring-boot-starter</dependency></dependencies></project>",
  );
  writeAt(root, "src/main/resources/application.yml", "server:\n  port: 8080");

  const modules = ["app", "core", "data", "feature-login", "feature-settings"];
  for (const mod of modules) {
    const content =
      mod === "app"
        ? 'plugins { id("com.android.application") }'
        : 'plugins { id("com.android.library") }';
    writeAt(root, `${mod}/build.gradle.kts`, content);
  }

  return root;
}

// ── Fixture: Cloudflare project with multiple config features ──

function createCloudflareFixture() {
  const root = makeTmp("cloudflare");
  writePkg(root, {
    dependencies: { wrangler: "3.0.0", agents: "1.0.0", "@cloudflare/ai": "1.0.0" },
    devDependencies: { "@cloudflare/workers-types": "4.0.0" },
  });
  writeAt(
    root,
    "wrangler.json",
    JSON.stringify({
      name: "my-worker",
      durable_objects: { bindings: [{ name: "MY_DO", class_name: "MyDO" }] },
      ai: { binding: "AI" },
    }),
  );
  writeAt(root, "wrangler.toml", 'name = "my-worker"\n[durable_objects]\nbindings = []');

  return root;
}

// ── Fixture: frontend-only project (deep file tree, no package.json) ──

function createFrontendOnlyFixture() {
  const root = makeTmp("frontend");
  const exts = [".html", ".css", ".scss", ".vue", ".svelte", ".jsx", ".tsx"];
  let fileIdx = 0;
  for (let d1 = 0; d1 < 5; d1++) {
    for (let d2 = 0; d2 < 5; d2++) {
      for (let d3 = 0; d3 < 4; d3++) {
        const ext = exts[fileIdx++ % exts.length];
        writeAt(root, `src/level-${d1}/sub-${d2}/file-${d3}${ext}`, "");
      }
    }
  }
  return root;
}

// ── Synthetic data for collectSkills / detectCombos ──

function buildLargeDetected() {
  return SKILLS_MAP.filter((t) => t.skills.length > 0);
}

function buildAllDetectedIds() {
  return SKILLS_MAP.map((t) => t.id);
}

// ── Main ──────────────────────────────────────────────────────

const fixtures = [];

function setup() {
  fixtures.push(
    { name: "monorepo", dir: createMonorepoFixture() },
    { name: "jvm", dir: createJvmFixture() },
    { name: "cloudflare", dir: createCloudflareFixture() },
    { name: "frontend-only", dir: createFrontendOnlyFixture() },
  );
}

function cleanup() {
  for (const f of fixtures) {
    rmSync(f.dir, { recursive: true, force: true });
  }
}

function run() {
  console.log(`autoskills benchmark — ${RUNS} runs per test\n`);

  for (const { name, dir } of fixtures) {
    console.log(`[${name}] ${dir}`);
    bench("detectTechnologies()", () => detectTechnologies(dir));
    bench("resolveWorkspaces()", () => resolveWorkspaces(dir));
    bench("hasWebFrontendFiles()", () => hasWebFrontendFiles(dir));
    console.log();
  }

  const largeDetected = buildLargeDetected();
  const allIds = buildAllDetectedIds();
  const combos = detectCombos(allIds);

  console.log(`[synthetic] collectSkills (${largeDetected.length} techs, ${combos.length} combos)`);
  bench("collectSkills()", () => collectSkills(largeDetected, true, combos));
  console.log();

  console.log(`[synthetic] detectCombos (${allIds.length} IDs)`);
  bench("detectCombos()", () => detectCombos(allIds));
  console.log();
}

setup();
try {
  run();
} finally {
  cleanup();
}
