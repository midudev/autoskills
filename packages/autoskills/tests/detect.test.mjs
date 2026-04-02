import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join } from "node:path";
import { tmpdir } from "node:os";
import { getAllPackageNames, readPackageJson, detectTechnologies, detectCombos } from "../lib.mjs";

// ── getAllPackageNames ─────────────────────────────────────────

describe("getAllPackageNames", () => {
  it("returns empty array for null input", () => {
    assert.deepStrictEqual(getAllPackageNames(null), []);
  });

  it("returns empty array for empty package.json", () => {
    assert.deepStrictEqual(getAllPackageNames({}), []);
  });

  it("extracts dependencies", () => {
    const pkg = { dependencies: { react: "^19.0.0", next: "^15.0.0" } };
    assert.deepStrictEqual(getAllPackageNames(pkg), ["react", "next"]);
  });

  it("extracts devDependencies", () => {
    const pkg = { devDependencies: { typescript: "^5.0.0" } };
    assert.deepStrictEqual(getAllPackageNames(pkg), ["typescript"]);
  });

  it("merges both dependencies and devDependencies", () => {
    const pkg = {
      dependencies: { react: "^19.0.0" },
      devDependencies: { typescript: "^5.0.0" },
    };
    const result = getAllPackageNames(pkg);
    assert.ok(result.includes("react"));
    assert.ok(result.includes("typescript"));
    assert.strictEqual(result.length, 2);
  });
});

// ── readPackageJson ───────────────────────────────────────────

describe("readPackageJson", () => {
  let tmpDir;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-test-"));
  });

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("returns null when no package.json exists", () => {
    assert.strictEqual(readPackageJson(tmpDir), null);
  });

  it("parses valid package.json", () => {
    const pkg = { name: "test", dependencies: { react: "^19.0.0" } };
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify(pkg));
    assert.deepStrictEqual(readPackageJson(tmpDir), pkg);
  });

  it("returns null for invalid JSON", () => {
    writeFileSync(join(tmpDir, "package.json"), "{ not valid json }}}");
    assert.strictEqual(readPackageJson(tmpDir), null);
  });
});

// ── detectTechnologies ────────────────────────────────────────

describe("detectTechnologies", () => {
  let tmpDir;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-test-"));
  });

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("returns empty when no package.json or config files", () => {
    const { detected } = detectTechnologies(tmpDir);
    assert.strictEqual(detected.length, 0);
  });

  it("detects React from dependencies", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { react: "^19.0.0", "react-dom": "^19.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("react"));
  });

  it("detects Next.js from dependencies", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { next: "^15.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("nextjs"));
  });

  it("detects Next.js from config file even without package", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "next.config.mjs"), "export default {}");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("nextjs"));
  });

  it("detects Vue from dependencies", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { vue: "^3.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("vue"));
  });

  it("detects TypeScript from tsconfig.json", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "tsconfig.json"), "{}");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("typescript"));
  });

  it("detects Azure from scoped package pattern", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@azure/storage-blob": "^12.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("azure"));
  });

  it("detects AWS from scoped package pattern", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@aws-sdk/client-s3": "^3.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("aws"));
  });

  it("detects Tailwind from devDependencies", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ devDependencies: { tailwindcss: "^4.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("tailwind"));
  });

  it("detects Tailwind from @tailwindcss/vite", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@tailwindcss/vite": "^4.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("tailwind"));
  });

  it("detects shadcn/ui from components.json", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "components.json"), "{}");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("shadcn"));
  });

  it("detects Cloudflare from wrangler.toml", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "wrangler.toml"), "");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("cloudflare"));
  });

  it("detects multiple technologies at once", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({
        dependencies: { next: "^15", react: "^19", "react-dom": "^19" },
        devDependencies: { typescript: "^5", "@playwright/test": "^1.40" },
      }),
    );
    writeFileSync(join(tmpDir, "tsconfig.json"), "{}");

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);

    assert.ok(ids.includes("react"));
    assert.ok(ids.includes("nextjs"));
    assert.ok(ids.includes("typescript"));
    assert.ok(ids.includes("playwright"));
  });

  it("marks frontend projects correctly", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { react: "^19.0.0" } }),
    );
    const { isFrontend } = detectTechnologies(tmpDir);
    assert.strictEqual(isFrontend, true);
  });

  it("marks non-frontend projects correctly", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { express: "^4.0.0" } }),
    );
    const { isFrontend } = detectTechnologies(tmpDir);
    assert.strictEqual(isFrontend, false);
  });

  it("detects combos when multiple technologies match", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { expo: "^52.0.0", tailwindcss: "^4.0.0" } }),
    );
    const { combos } = detectTechnologies(tmpDir);
    const comboIds = combos.map((c) => c.id);
    assert.ok(comboIds.includes("expo-tailwind"));
  });

  it("returns no combos when only one technology of a pair is present", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { expo: "^52.0.0" } }),
    );
    const { combos } = detectTechnologies(tmpDir);
    const comboIds = combos.map((c) => c.id);
    assert.ok(!comboIds.includes("expo-tailwind"));
  });

  it("detects Kotlin Multiplatform from root build.gradle.kts", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(
      join(tmpDir, "build.gradle.kts"),
      'plugins { kotlin("multiplatform") version "2.0.0" }',
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("detects Kotlin Multiplatform from nested module build.gradle.kts", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    const mod = join(tmpDir, "composeApp");
    mkdirSync(mod, { recursive: true });
    writeFileSync(
      join(mod, "build.gradle.kts"),
      'plugins { id("org.jetbrains.kotlin.multiplatform") }',
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("detects Android from nested app build.gradle.kts", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    const app = join(tmpDir, "app");
    mkdirSync(app, { recursive: true });
    writeFileSync(join(app, "build.gradle.kts"), 'plugins { id("com.android.application") }');
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "android"));
  });

  it("detects KMP and Android together for typical mobile KMP layout", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    const mod = join(tmpDir, "composeApp");
    mkdirSync(mod, { recursive: true });
    writeFileSync(
      join(mod, "build.gradle.kts"),
      `
plugins {
  kotlin("multiplatform")
  id("com.android.application")
}
`,
    );
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("kotlin-multiplatform"));
    assert.ok(ids.includes("android"));
  });

  it("detects Java from pom.xml (Maven project)", () => {
    writeFileSync(join(tmpDir, "pom.xml"), "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "java"));
  });

  it("detects Java from root build.gradle.kts with sourceCompatibility", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "build.gradle.kts"), "sourceCompatibility = JavaVersion.VERSION_17");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "java"));
  });

  it("detects Java from nested module build.gradle with java plugin", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    const mod = join(tmpDir, "app");
    mkdirSync(mod, { recursive: true });
    writeFileSync(join(mod, "build.gradle"), "apply plugin: 'java'\nsourceCompatibility = '17'");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "java"));
  });

  it('detects Java from build.gradle.kts with id("java-library")', () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "build.gradle.kts"), 'plugins { id("java-library") }');
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "java"));
  });

  it("detects Spring Boot from application.properties", () => {
    const resources = join(tmpDir, "src", "main", "resources");
    mkdirSync(resources, { recursive: true });
    writeFileSync(join(resources, "application.properties"), "server.port=8080");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects Spring Boot from application.yml", () => {
    const resources = join(tmpDir, "src", "main", "resources");
    mkdirSync(resources, { recursive: true });
    writeFileSync(join(resources, "application.yml"), "server:\n  port: 8080");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects Spring Boot from pom.xml with spring-boot-starter", () => {
    writeFileSync(
      join(tmpDir, "pom.xml"),
      `<project>
        <dependencies>
          <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
          </dependency>
        </dependencies>
      </project>`,
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects both Java and Spring Boot from a Maven Spring Boot project", () => {
    writeFileSync(
      join(tmpDir, "pom.xml"),
      `<project>
        <dependencies>
          <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
          </dependency>
        </dependencies>
      </project>`,
    );
    const resources = join(tmpDir, "src", "main", "resources");
    mkdirSync(resources, { recursive: true });
    writeFileSync(join(resources, "application.properties"), "server.port=8080");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("java"));
    assert.ok(ids.includes("springboot"));
  });

  it("detects Java but not Spring Boot for a plain Maven project", () => {
    writeFileSync(join(tmpDir, "pom.xml"), "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("java"));
    assert.ok(!ids.includes("springboot"));
  });

  it("returns correct skills for Java detection", () => {
    writeFileSync(join(tmpDir, "pom.xml"), "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmpDir);
    const java = detected.find((t) => t.id === "java");
    assert.ok(java);
    assert.ok(java.skills.includes("github/awesome-copilot/java-docs"));
    assert.ok(java.skills.includes("affaan-m/everything-claude-code/java-coding-standards"));
  });

  it("returns correct skills for Spring Boot detection", () => {
    const resources = join(tmpDir, "src", "main", "resources");
    mkdirSync(resources, { recursive: true });
    writeFileSync(join(resources, "application.properties"), "server.port=8080");
    const { detected } = detectTechnologies(tmpDir);
    const springboot = detected.find((t) => t.id === "springboot");
    assert.ok(springboot);
    assert.ok(springboot.skills.includes("github/awesome-copilot/java-springboot"));
  });

  it("detects Prisma from @prisma/client package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@prisma/client": "^6.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "prisma"));
  });

  it("detects Prisma from prisma devDependency", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ devDependencies: { prisma: "^6.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "prisma"));
  });

  it("detects Stripe from stripe package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { stripe: "^17.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "stripe"));
  });

  it("detects Stripe from @stripe/stripe-js package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@stripe/stripe-js": "^5.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "stripe"));
  });

  it("detects Hono from package.json", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { hono: "^4.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "hono"));
  });

  it("detects Vitest from package.json", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ devDependencies: { vitest: "^3.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "vitest"));
  });

  it("detects Vitest from config file", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "vitest.config.ts"), "export default {}");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "vitest"));
  });

  it("detects Drizzle ORM from drizzle-orm package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "drizzle-orm": "^0.40.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "drizzle"));
  });

  it("detects NestJS from @nestjs/core package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@nestjs/core": "^11.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "nestjs"));
  });

  it("detects Tauri from @tauri-apps/api package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@tauri-apps/api": "^2.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "tauri"));
  });

  it("detects Tauri from src-tauri config file", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    const tauriDir = join(tmpDir, "src-tauri");
    mkdirSync(tauriDir, { recursive: true });
    writeFileSync(join(tauriDir, "tauri.conf.json"), "{}");
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "tauri"));
  });

  it("detects Clerk from @clerk/nextjs package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@clerk/nextjs": "^6.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from @clerk/react package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@clerk/react": "^5.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from any @clerk/* scoped package", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@clerk/expo": "^2.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    assert.ok(detected.some((t) => t.id === "clerk"));
  });

  it("returns correct skills for Clerk detection", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({ dependencies: { "@clerk/nextjs": "^6.0.0" } }),
    );
    const { detected } = detectTechnologies(tmpDir);
    const clerk = detected.find((t) => t.id === "clerk");
    assert.ok(clerk);
    assert.ok(clerk.skills.includes("clerk/skills/clerk"));
    assert.ok(clerk.skills.includes("clerk/skills/clerk-setup"));
    assert.ok(clerk.skills.includes("clerk/skills/clerk-nextjs-patterns"));
    assert.ok(clerk.skills.includes("clerk/skills/clerk-orgs"));
    assert.ok(clerk.skills.includes("clerk/skills/clerk-webhooks"));
    assert.ok(clerk.skills.includes("clerk/skills/clerk-testing"));
  });
});

// ── detectTechnologies (monorepo) ─────────────────────────────

describe("detectTechnologies (monorepo)", () => {
  let tmpDir;

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), "autoskills-mono-"));
  });

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true });
  });

  it("detects technologies from workspace subpackages", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({ workspaces: ["packages/*"] }));
    mkdirSync(join(tmpDir, "packages", "web"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "web", "package.json"),
      JSON.stringify({ dependencies: { next: "^15", react: "^19" } }),
    );

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("nextjs"));
    assert.ok(ids.includes("react"));
  });

  it("merges root and workspace technologies", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({
        devDependencies: { typescript: "^5" },
        workspaces: ["packages/*"],
      }),
    );
    writeFileSync(join(tmpDir, "tsconfig.json"), "{}");
    mkdirSync(join(tmpDir, "packages", "api"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "api", "package.json"),
      JSON.stringify({ dependencies: { express: "^4" } }),
    );

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("typescript"), "root tech should be detected");
    assert.ok(ids.includes("express"), "workspace tech should be detected");
  });

  it("deduplicates technologies across workspaces", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({ workspaces: ["packages/*"] }));
    mkdirSync(join(tmpDir, "packages", "ui"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "ui", "package.json"),
      JSON.stringify({ dependencies: { react: "^19" } }),
    );
    mkdirSync(join(tmpDir, "packages", "app"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "app", "package.json"),
      JSON.stringify({ dependencies: { react: "^19" } }),
    );

    const { detected } = detectTechnologies(tmpDir);
    const reactCount = detected.filter((t) => t.id === "react").length;
    assert.strictEqual(reactCount, 1, "react should appear only once");
  });

  it("detects config files in workspace directories", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({ workspaces: ["apps/*"] }));
    mkdirSync(join(tmpDir, "apps", "web"), { recursive: true });
    writeFileSync(join(tmpDir, "apps", "web", "package.json"), "{}");
    writeFileSync(join(tmpDir, "apps", "web", "next.config.mjs"), "export default {}");

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("nextjs"));
  });

  it("detects frontend from any workspace", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({
        dependencies: { express: "^4" },
        workspaces: ["packages/*"],
      }),
    );
    mkdirSync(join(tmpDir, "packages", "ui"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "ui", "package.json"),
      JSON.stringify({ dependencies: { react: "^19" } }),
    );

    const { isFrontend } = detectTechnologies(tmpDir);
    assert.strictEqual(isFrontend, true);
  });

  it("detects combos across workspaces", () => {
    writeFileSync(
      join(tmpDir, "package.json"),
      JSON.stringify({
        dependencies: { next: "^15" },
        workspaces: ["packages/*"],
      }),
    );
    mkdirSync(join(tmpDir, "packages", "db"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "db", "package.json"),
      JSON.stringify({ dependencies: { "@supabase/supabase-js": "^2" } }),
    );

    const { combos } = detectTechnologies(tmpDir);
    const ids = combos.map((c) => c.id);
    assert.ok(ids.includes("nextjs-supabase"), "cross-workspace combo should be detected");
  });

  it("works with pnpm-workspace.yaml", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
    writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "packages:\n  - packages/*\n");
    mkdirSync(join(tmpDir, "packages", "app"), { recursive: true });
    writeFileSync(
      join(tmpDir, "packages", "app", "package.json"),
      JSON.stringify({ dependencies: { vue: "^3" } }),
    );

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("vue"));
  });

  it("detects config file content in workspaces", () => {
    writeFileSync(join(tmpDir, "package.json"), JSON.stringify({ workspaces: ["workers/*"] }));
    mkdirSync(join(tmpDir, "workers", "do-worker"), { recursive: true });
    writeFileSync(join(tmpDir, "workers", "do-worker", "package.json"), "{}");
    writeFileSync(
      join(tmpDir, "workers", "do-worker", "wrangler.json"),
      JSON.stringify({ durable_objects: { bindings: [] } }),
    );

    const { detected } = detectTechnologies(tmpDir);
    const ids = detected.map((t) => t.id);
    assert.ok(ids.includes("cloudflare-durable-objects"));
  });
});

// ── detectCombos ──────────────────────────────────────────────

describe("detectCombos", () => {
  it("returns empty array when no combos match", () => {
    const combos = detectCombos(["react"]);
    assert.strictEqual(combos.length, 0);
  });

  it("returns empty array for empty input", () => {
    const combos = detectCombos([]);
    assert.strictEqual(combos.length, 0);
  });

  it("detects expo + tailwind combo", () => {
    const combos = detectCombos(["expo", "tailwind"]);
    assert.ok(combos.some((c) => c.id === "expo-tailwind"));
  });

  it("detects combo even with extra technologies", () => {
    const combos = detectCombos(["react", "expo", "tailwind", "typescript"]);
    assert.ok(combos.some((c) => c.id === "expo-tailwind"));
  });

  it("detects multiple combos simultaneously", () => {
    const combos = detectCombos(["nextjs", "supabase", "playwright"]);
    const ids = combos.map((c) => c.id);
    assert.ok(ids.includes("nextjs-supabase"));
    assert.ok(ids.includes("nextjs-playwright"));
  });

  it("does not detect combo when only one requirement is met", () => {
    const combos = detectCombos(["nextjs"]);
    assert.ok(!combos.some((c) => c.id === "nextjs-supabase"));
  });

  it("detects nextjs-clerk combo", () => {
    const combos = detectCombos(["nextjs", "clerk"]);
    assert.ok(combos.some((c) => c.id === "nextjs-clerk"));
  });

  it("does not detect nextjs-clerk combo without clerk", () => {
    const combos = detectCombos(["nextjs"]);
    assert.ok(!combos.some((c) => c.id === "nextjs-clerk"));
  });
});
