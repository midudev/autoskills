import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import {
  getAllPackageNames,
  readPackageJson,
  readGemfile,
  readDenoJson,
  getDenoImportNames,
  detectTechnologies,
  detectCombos,
  parseSettingsGradleModules,
} from "../lib.ts";
import { useTmpDir, writePackageJson, writeJson, writeFile, addWorkspace } from "./helpers.ts";

// ── getAllPackageNames ─────────────────────────────────────────

describe("getAllPackageNames", () => {
  it("returns empty array for null input", () => {
    deepStrictEqual(getAllPackageNames(null), []);
  });

  it("returns empty array for empty package.json", () => {
    deepStrictEqual(getAllPackageNames({}), []);
  });

  it("extracts dependencies", () => {
    const pkg = { dependencies: { react: "^19.0.0", next: "^15.0.0" } };
    deepStrictEqual(getAllPackageNames(pkg), ["react", "next"]);
  });

  it("extracts devDependencies", () => {
    const pkg = { devDependencies: { typescript: "^5.0.0" } };
    deepStrictEqual(getAllPackageNames(pkg), ["typescript"]);
  });

  it("merges both dependencies and devDependencies", () => {
    const pkg = {
      dependencies: { react: "^19.0.0" },
      devDependencies: { typescript: "^5.0.0" },
    };
    const result = getAllPackageNames(pkg);
    ok(result.includes("react"));
    ok(result.includes("typescript"));
    strictEqual(result.length, 2);
  });
});

// ── readPackageJson ───────────────────────────────────────────

describe("readPackageJson", () => {
  const tmp = useTmpDir();

  it("returns null when no package.json exists", () => {
    strictEqual(readPackageJson(tmp.path), null);
  });

  it("parses valid package.json", () => {
    const pkg = { name: "test", dependencies: { react: "^19.0.0" } };
    writePackageJson(tmp.path, pkg);
    deepStrictEqual(readPackageJson(tmp.path), pkg);
  });

  it("returns null for invalid JSON", () => {
    writeFile(tmp.path, "package.json", "{ not valid json }}}");
    strictEqual(readPackageJson(tmp.path), null);
  });
});

// ── readGemfile ──────────────────────────────────────────────

describe("readGemfile", () => {
  const tmp = useTmpDir();

  it("returns empty array when no Gemfile exists", () => {
    deepStrictEqual(readGemfile(tmp.path), []);
  });

  it("parses gem names with single quotes", () => {
    writeFile(tmp.path, "Gemfile", "gem 'rails', '~> 7.0'\ngem 'pg'\n");
    deepStrictEqual(readGemfile(tmp.path), ["rails", "pg"]);
  });

  it("parses gem names with double quotes", () => {
    writeFile(tmp.path, "Gemfile", 'gem "rails"\ngem "sidekiq"\n');
    deepStrictEqual(readGemfile(tmp.path), ["rails", "sidekiq"]);
  });

  it("ignores comments", () => {
    writeFile(tmp.path, "Gemfile", "# gem 'unused'\ngem 'rails'\n");
    deepStrictEqual(readGemfile(tmp.path), ["rails"]);
  });

  it("handles indented gems (inside groups)", () => {
    writeFile(tmp.path, "Gemfile", "group :development do\n  gem 'rspec'\nend\n");
    deepStrictEqual(readGemfile(tmp.path), ["rspec"]);
  });
});

// ── parseSettingsGradleModules ─────────────────────────────────

describe("parseSettingsGradleModules", () => {
  it("extracts module from Kotlin DSL include", () => {
    const modules = parseSettingsGradleModules('include("app")');
    deepStrictEqual(modules, ["app"]);
  });

  it("extracts module from Groovy include", () => {
    const modules = parseSettingsGradleModules("include 'app'");
    deepStrictEqual(modules, ["app"]);
  });

  it("strips leading colon from module paths", () => {
    const modules = parseSettingsGradleModules('include(":app")');
    deepStrictEqual(modules, ["app"]);
  });

  it("converts colon-separated paths to filesystem paths", () => {
    const modules = parseSettingsGradleModules('include(":feature:login")');
    deepStrictEqual(modules, ["feature/login"]);
  });

  it("handles multiple modules on one line (Groovy)", () => {
    const modules = parseSettingsGradleModules("include 'app', 'core', 'data'");
    deepStrictEqual(modules, ["app", "core", "data"]);
  });

  it("handles multiple modules on one line (Kotlin DSL)", () => {
    const modules = parseSettingsGradleModules('include(":app", ":core", ":data")');
    deepStrictEqual(modules, ["app", "core", "data"]);
  });

  it("handles multi-line include block", () => {
    const content = `include(
  ":app",
  ":core",
  ":shared:data"
)`;
    deepStrictEqual(parseSettingsGradleModules(content), ["app", "core", "shared/data"]);
  });

  it("handles multiple separate include statements", () => {
    const content = 'include(":app")\ninclude(":core")';
    deepStrictEqual(parseSettingsGradleModules(content), ["app", "core"]);
  });

  it("returns empty array when no includes are present", () => {
    const content = 'rootProject.name = "my-app"\npluginManagement { }';
    deepStrictEqual(parseSettingsGradleModules(content), []);
  });

  it("returns empty array for empty content", () => {
    deepStrictEqual(parseSettingsGradleModules(""), []);
  });

  it("ignores non-include content around includes", () => {
    const content = `rootProject.name = "my-app"
pluginManagement {
    repositories { google() }
}
include(":app")`;
    deepStrictEqual(parseSettingsGradleModules(content), ["app"]);
  });
});

// ── detectTechnologies ────────────────────────────────────────

describe("detectTechnologies", () => {
  const tmp = useTmpDir();

  it("returns empty when no package.json or config files", () => {
    const { detected } = detectTechnologies(tmp.path);
    strictEqual(detected.length, 0);
  });

  it("detects React from dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19.0.0", "react-dom": "^19.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("react"));
  });

  it("detects Next.js from dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { next: "^15.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("nextjs"));
  });

  it("detects Next.js from config file even without package", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "next.config.mjs", "export default {}");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("nextjs"));
  });

  it("detects Vue from dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { vue: "^3.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("vue"));
  });

  it("detects TypeScript from tsconfig.json", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "tsconfig.json", "{}");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("typescript"));
  });

  it("detects Azure from scoped package pattern", () => {
    writePackageJson(tmp.path, { dependencies: { "@azure/storage-blob": "^12.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("azure"));
  });

  it("detects AWS from scoped package pattern", () => {
    writePackageJson(tmp.path, { dependencies: { "@aws-sdk/client-s3": "^3.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("aws"));
  });

  it("detects Tailwind from devDependencies", () => {
    writePackageJson(tmp.path, { devDependencies: { tailwindcss: "^4.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("tailwind"));
  });

  it("detects Tailwind from @tailwindcss/vite", () => {
    writePackageJson(tmp.path, { dependencies: { "@tailwindcss/vite": "^4.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("tailwind"));
  });

  it("detects Go from go.mod", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "go.mod", "module example.com/test\n\ngo 1.24.0\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "go"));
  });

  it("detects Go from go.work", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "go.work", "go 1.24.0\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "go"));
  });

  it("does not detect Go without go.mod or go.work", () => {
    writePackageJson(tmp.path);
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "go"));
  });

  it("detects Three.js from dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { three: "^0.173.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "threejs"));
  });

  it("keeps Three.js detection when React and React Three Fiber are present", () => {
    writePackageJson(tmp.path, {
      dependencies: { three: "^0.173.0", react: "^19.0.0", "react-dom": "^19.0.0" },
    });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "threejs"));
  });

  it("detects React + React Three Fiber combo when Three.js is present", () => {
    writePackageJson(tmp.path, {
      dependencies: { three: "^0.173.0", react: "^19.0.0", "@react-three/fiber": "^9.0.0" },
    });
    const { combos } = detectTechnologies(tmp.path);
    ok(combos.some((c) => c.id === "react-react-three-fiber"));
  });

  it("detects shadcn/ui from components.json", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "components.json", "{}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "shadcn"));
  });

  it("detects Cloudflare from wrangler.toml", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "wrangler.toml");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "cloudflare"));
  });

  it("detects multiple technologies at once", () => {
    writePackageJson(tmp.path, {
      dependencies: { next: "^15", react: "^19", "react-dom": "^19" },
      devDependencies: { typescript: "^5", "@playwright/test": "^1.40" },
    });
    writeFile(tmp.path, "tsconfig.json", "{}");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("react"));
    ok(ids.includes("nextjs"));
    ok(ids.includes("typescript"));
    ok(ids.includes("playwright"));
  });

  it("marks frontend projects correctly", () => {
    writePackageJson(tmp.path, { dependencies: { react: "^19.0.0" } });
    const { isFrontend } = detectTechnologies(tmp.path);
    strictEqual(isFrontend, true);
  });

  it("marks non-frontend projects correctly", () => {
    writePackageJson(tmp.path, { dependencies: { express: "^4.0.0" } });
    const { isFrontend } = detectTechnologies(tmp.path);
    strictEqual(isFrontend, false);
  });

  it("detects combos when multiple technologies match", () => {
    writePackageJson(tmp.path, { dependencies: { expo: "^52.0.0", tailwindcss: "^4.0.0" } });
    const { combos } = detectTechnologies(tmp.path);
    ok(combos.some((c) => c.id === "expo-tailwind"));
  });

  it("returns no combos when only one technology of a pair is present", () => {
    writePackageJson(tmp.path, { dependencies: { expo: "^52.0.0" } });
    const { combos } = detectTechnologies(tmp.path);
    ok(!combos.some((c) => c.id === "expo-tailwind"));
  });

  it("detects Kotlin Multiplatform from root build.gradle.kts", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "build.gradle.kts", 'plugins { kotlin("multiplatform") version "2.0.0" }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("detects Kotlin Multiplatform from nested module build.gradle.kts", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "composeApp/build.gradle.kts",
      'plugins { id("org.jetbrains.kotlin.multiplatform") }',
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("detects Android from nested app build.gradle.kts", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "app/build.gradle.kts", 'plugins { id("com.android.application") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "android"));
  });

  it("detects KMP and Android together for typical mobile KMP layout", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "composeApp/build.gradle.kts",
      `
plugins {
  kotlin("multiplatform")
  id("com.android.application")
}
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("kotlin-multiplatform"));
    ok(ids.includes("android"));
  });

  it("detects Java from nested Gradle module declared in settings.gradle.kts", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "settings.gradle.kts",
      'rootProject.name = "my-app"\ninclude("adapters:web")',
    );
    writeFile(
      tmp.path,
      "adapters/web/build.gradle.kts",
      "sourceCompatibility = JavaVersion.VERSION_17",
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("detects Kotlin Multiplatform from nested module declared in settings.gradle", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "settings.gradle", "include 'shared'");
    writeFile(tmp.path, "shared/build.gradle.kts", 'plugins { kotlin("multiplatform") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("detects Android from deeply nested module in Gradle multi-module project", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "settings.gradle.kts", 'include("feature:login")');
    writeFile(tmp.path, "feature/login/build.gradle.kts", 'plugins { id("com.android.library") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "android"));
  });

  it("handles settings.gradle with multiple includes on one line", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "settings.gradle", "include 'app', 'core', 'data'");
    writeFile(tmp.path, "app/build.gradle.kts", 'plugins { id("java-library") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("handles settings.gradle.kts with multi-line includes", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "settings.gradle.kts", 'include(\n  ":app",\n  ":core"\n)');
    writeFile(tmp.path, "app/build.gradle.kts", 'plugins { id("java-library") }');
    writeFile(tmp.path, "core/build.gradle.kts", 'plugins { kotlin("multiplatform") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
    ok(detected.some((t) => t.id === "kotlin-multiplatform"));
  });

  it("does not break when settings.gradle.kts has no include statements", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "settings.gradle.kts", 'rootProject.name = "my-app"');
    writeFile(tmp.path, "build.gradle.kts", "sourceCompatibility = JavaVersion.VERSION_17");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("detects Java from pom.xml (Maven project)", () => {
    writeFile(tmp.path, "pom.xml", "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("detects Java from root build.gradle.kts with sourceCompatibility", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "build.gradle.kts", "sourceCompatibility = JavaVersion.VERSION_17");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("detects Java from nested module build.gradle with java plugin", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "app/build.gradle", "apply plugin: 'java'\nsourceCompatibility = '17'");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it('detects Java from build.gradle.kts with id("java-library")', () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "build.gradle.kts", 'plugins { id("java-library") }');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "java"));
  });

  it("detects Spring Boot from application.properties", () => {
    writeFile(tmp.path, "src/main/resources/application.properties", "server.port=8080");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects Spring Boot from application.yml", () => {
    writeFile(tmp.path, "src/main/resources/application.yml", "server:\n  port: 8080");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects Spring Boot from pom.xml with spring-boot-starter", () => {
    writeFile(
      tmp.path,
      "pom.xml",
      `<project><dependencies><dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-web</artifactId></dependency></dependencies></project>`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects both Java and Spring Boot from a Maven Spring Boot project", () => {
    writeFile(
      tmp.path,
      "pom.xml",
      `<project><dependencies><dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-web</artifactId></dependency></dependencies></project>`,
    );
    writeFile(tmp.path, "src/main/resources/application.properties", "server.port=8080");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("java"));
    ok(ids.includes("springboot"));
  });

  it("detects Java but not Spring Boot for a plain Maven project", () => {
    writeFile(tmp.path, "pom.xml", "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("java"));
    ok(!ids.includes("springboot"));
  });

  it("returns correct skills for Java detection", () => {
    writeFile(tmp.path, "pom.xml", "<project><groupId>com.example</groupId></project>");
    const { detected } = detectTechnologies(tmp.path);
    const java = detected.find((t) => t.id === "java");
    ok(java);
    ok(java.skills.includes("github/awesome-copilot/java-docs"));
    ok(java.skills.includes("affaan-m/everything-claude-code/java-coding-standards"));
  });

  it("returns correct skills for Spring Boot detection", () => {
    writeFile(tmp.path, "src/main/resources/application.properties", "server.port=8080");
    const { detected } = detectTechnologies(tmp.path);
    const springboot = detected.find((t) => t.id === "springboot");
    ok(springboot);
    ok(springboot.skills.includes("github/awesome-copilot/java-springboot"));
  });

  it("detects Prisma from @prisma/client package", () => {
    writePackageJson(tmp.path, { dependencies: { "@prisma/client": "^6.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "prisma"));
  });

  it("detects Prisma from prisma devDependency", () => {
    writePackageJson(tmp.path, { devDependencies: { prisma: "^6.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "prisma"));
  });

  it("detects Stripe from stripe package", () => {
    writePackageJson(tmp.path, { dependencies: { stripe: "^17.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "stripe"));
  });

  it("detects Stripe from @stripe/stripe-js package", () => {
    writePackageJson(tmp.path, { dependencies: { "@stripe/stripe-js": "^5.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "stripe"));
  });

  it("detects Hono from package.json", () => {
    writePackageJson(tmp.path, { dependencies: { hono: "^4.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "hono"));
  });

  it("detects Vitest from package.json", () => {
    writePackageJson(tmp.path, { devDependencies: { vitest: "^3.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "vitest"));
  });

  it("detects Vitest from config file", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "vitest.config.ts", "export default {}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "vitest"));
  });

  it("detects Drizzle ORM from drizzle-orm package", () => {
    writePackageJson(tmp.path, { dependencies: { "drizzle-orm": "^0.40.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "drizzle"));
  });

  it("detects NestJS from @nestjs/core package", () => {
    writePackageJson(tmp.path, { dependencies: { "@nestjs/core": "^11.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "nestjs"));
  });

  it("detects Tauri from @tauri-apps/api package", () => {
    writePackageJson(tmp.path, { dependencies: { "@tauri-apps/api": "^2.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "tauri"));
  });

  it("detects Tauri from src-tauri config file", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "src-tauri/tauri.conf.json", "{}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "tauri"));
  });

  it("detects Electron from electron package", () => {
    writePackageJson(tmp.path, { devDependencies: { electron: "^30.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "electron"));
  });

  it("detects Electron from electron-builder config file", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "electron-builder.yml", "productName: My App");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "electron"));
  });

  it("detects Electron from forge config file", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "forge.config.js", "module.exports = {}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "electron"));
  });

  it("detects Electron from electron-vite config file", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "electron-vite.config.ts", "export default {}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "electron"));
  });

  it("detects Rust from Cargo.toml", () => {
    writeFile(tmp.path, "Cargo.toml", '[package]\nname = "my-crate"\nversion = "0.1.0"');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "rust"));
  });

  it("returns correct skills for Rust detection", () => {
    writeFile(tmp.path, "Cargo.toml", '[package]\nname = "my-crate"');
    const { detected } = detectTechnologies(tmp.path);
    const rust = detected.find((t) => t.id === "rust");
    ok(rust);
    ok(rust.skills.includes("apollographql/skills/rust-best-practices"));
  });

  it("detects Python from pyproject.toml", () => {
    writeFile(tmp.path, "pyproject.toml", '[tool.poetry]\nname = "test"');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "python"));
  });

  it("detects Python from requirements.txt", () => {
    writeFile(tmp.path, "requirements.txt", "requests==2.31.0");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "python"));
  });

  it("detects FastAPI from requirements.txt", () => {
    writeFile(tmp.path, "requirements.txt", "fastapi==0.100.0\npydantic==2.0.0");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "fastapi"));
    ok(detected.some((t) => t.id === "pydantic"));
  });

  it("detects Django from pyproject.toml", () => {
    writeFile(tmp.path, "pyproject.toml", '[tool.poetry.dependencies]\nDjango = "^5.0"');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "django"));
  });

  it("detects Flask from requirements.txt", () => {
    writeFile(tmp.path, "requirements.txt", "Flask>=2.0.0");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "flask"));
  });

  it("detects SQLAlchemy from requirements.txt", () => {
    writeFile(tmp.path, "requirements.txt", "SQLAlchemy==2.0.19");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "sqlalchemy"));
  });

  it("detects Data Science stack (Pandas, NumPy, Scikit-Learn)", () => {
    writeFile(tmp.path, "requirements.txt", "pandas>=2.0\nnumpy==1.26.0\nscikit-learn==1.3.0");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "pandas"));
    ok(detected.some((t) => t.id === "numpy"));
    ok(detected.some((t) => t.id === "scikit-learn"));
  });

  it("detects Pytest and Celery from pyproject.toml", () => {
    writeFile(
      tmp.path,
      "pyproject.toml",
      '[tool.poetry.dependencies]\npytest = "^7.0"\ncelery = "^5.3"',
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "pytest"));
    ok(detected.some((t) => t.id === "celery"));
  });

  it("detects Clerk from @clerk/nextjs package", () => {
    writePackageJson(tmp.path, { dependencies: { "@clerk/nextjs": "^6.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from @clerk/react package", () => {
    writePackageJson(tmp.path, { dependencies: { "@clerk/react": "^5.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from any @clerk/* scoped package", () => {
    writePackageJson(tmp.path, { dependencies: { "@clerk/expo": "^2.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("returns correct skills for Clerk detection", () => {
    writePackageJson(tmp.path, { dependencies: { "@clerk/nextjs": "^6.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const clerk = detected.find((t) => t.id === "clerk");
    ok(clerk);
    ok(clerk.skills.includes("clerk/skills/clerk"));
    ok(clerk.skills.includes("clerk/skills/clerk-setup"));
    ok(clerk.skills.includes("clerk/skills/clerk-custom-ui"));
    ok(clerk.skills.includes("clerk/skills/clerk-backend-api"));
    ok(clerk.skills.includes("clerk/skills/clerk-orgs"));
    ok(clerk.skills.includes("clerk/skills/clerk-webhooks"));
    ok(clerk.skills.includes("clerk/skills/clerk-testing"));
  });

  it("detects React Router from react-router package", () => {
    writePackageJson(tmp.path, { dependencies: { "react-router": "^7.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "react-router"));
  });

  it("detects React Router from @react-router/node package", () => {
    writePackageJson(tmp.path, { dependencies: { "@react-router/node": "^7.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "react-router"));
  });

  it("detects React Router from @react-router/dev devDependency", () => {
    writePackageJson(tmp.path, { devDependencies: { "@react-router/dev": "^7.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "react-router"));
  });

  it("detects TanStack Start from @tanstack/react-start package", () => {
    writePackageJson(tmp.path, { dependencies: { "@tanstack/react-start": "^1.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "tanstack-start"));
  });

  it("detects TanStack Start from @tanstack/start package", () => {
    writePackageJson(tmp.path, { dependencies: { "@tanstack/start": "^1.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "tanstack-start"));
  });

  it("returns correct skills for TanStack Start detection", () => {
    writePackageJson(tmp.path, { dependencies: { "@tanstack/react-start": "^1.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const tanstack = detected.find((t) => t.id === "tanstack-start");
    ok(tanstack);
    ok(tanstack.skills.includes("tanstack-skills/tanstack-skills/tanstack-start"));
  });

  it("detects PHP from composer.json", () => {
    writeFile(tmp.path, "composer.json", JSON.stringify({ require: { php: ">=8.2" } }));
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "php"));
  });

  it("detects PHP from composer.lock", () => {
    writeFile(tmp.path, "composer.lock", JSON.stringify({ packages: [] }));
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "php"));
  });

  it("returns correct skills for PHP detection", () => {
    writeFile(tmp.path, "composer.json", JSON.stringify({ require: { php: ">=8.2" } }));
    const { detected } = detectTechnologies(tmp.path);
    const php = detected.find((t) => t.id === "php");
    ok(php);
    ok(php.skills.includes("jeffallan/claude-skills/php-pro"));
  });

  it("does not detect PHP without composer files", () => {
    writePackageJson(tmp.path, { dependencies: { express: "^4.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "php"));
  });

  it("detects Laravel from artisan file", () => {
    writeFile(
      tmp.path,
      "artisan",
      "#!/usr/bin/env php\n<?php\ndefine('LARAVEL_START', microtime(true));",
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "laravel"));
  });

  it("detects Laravel from bootstrap/app.php", () => {
    writeFile(tmp.path, "bootstrap/app.php", "return $app;");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "laravel"));
  });

  it("detects Laravel from composer.json with laravel/framework", () => {
    writeFile(
      tmp.path,
      "composer.json",
      JSON.stringify({ require: { "laravel/framework": "^11.0" } }),
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "laravel"));
  });

  it("detects Laravel from composer.json with illuminate packages", () => {
    writeFile(
      tmp.path,
      "composer.json",
      JSON.stringify({ require: { "illuminate/support": "^11.0" } }),
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "laravel"));
  });

  it("returns correct skills for Laravel detection", () => {
    writeFile(
      tmp.path,
      "composer.json",
      JSON.stringify({ require: { "laravel/framework": "^11.0" } }),
    );
    const { detected } = detectTechnologies(tmp.path);
    const laravel = detected.find((t) => t.id === "laravel");
    ok(laravel);
    ok(laravel.skills.includes("jeffallan/claude-skills/laravel-specialist"));
    ok(laravel.skills.includes("affaan-m/everything-claude-code/laravel-patterns"));
  });

  it("detects both PHP and Laravel from composer.json", () => {
    writeFile(
      tmp.path,
      "composer.json",
      JSON.stringify({ require: { "laravel/framework": "^11.0" } }),
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "laravel"));
    ok(detected.some((t) => t.id === "php"));
  });

  it("does not detect Laravel without Laravel files or packages", () => {
    writePackageJson(tmp.path, { dependencies: { express: "^4.0.0" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "laravel"));
  });

  it("detects Chrome Extension from manifest.json with manifest_version", () => {
    writeFile(
      tmp.path,
      "manifest.json",
      JSON.stringify({ manifest_version: 3, name: "My Extension", version: "1.0" }),
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "chrome-extension"));
  });

  it("does not detect Chrome Extension from manifest.json without manifest_version", () => {
    writeFile(
      tmp.path,
      "manifest.json",
      JSON.stringify({ name: "My PWA", short_name: "PWA", start_url: "/" }),
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "chrome-extension"));
  });

  it("detects Clerk from Package.swift with clerk-ios dependency", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `import PackageDescription\nlet package = Package(name: "MyApp", dependencies: [.package(url: "https://github.com/clerk/clerk-ios", from: "1.0.0")])`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from Package.swift with ClerkSDK import", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `import PackageDescription\nlet package = Package(name: "MyApp", dependencies: [.package(url: "https://github.com/example/ClerkSDK", from: "2.0.0")])`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("does not detect Clerk from Package.swift without Clerk references", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `import PackageDescription\nlet package = Package(name: "MyApp", dependencies: [.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0")])`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from Gradle with com.clerk dependency", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `plugins { id("com.android.application") }\ndependencies { implementation("com.clerk:clerk-android:1.0.0") }`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("does not detect Clerk from Gradle without com.clerk", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `plugins { id("com.android.application") }\ndependencies { implementation("com.google.firebase:firebase-auth:22.0.0") }`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "clerk"));
  });

  it("detects both SwiftUI and Clerk from a Swift project with Clerk", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `import PackageDescription\nlet package = Package(name: "MySwiftApp", dependencies: [.package(url: "https://github.com/clerk/clerk-ios", from: "1.0.0")])`,
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("swiftui"));
    ok(ids.includes("clerk"));
  });

  it("detects both Android and Clerk from an Android project with Clerk", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `plugins { id("com.android.application") }\ndependencies { implementation("com.clerk:clerk-android:1.0.0") }`,
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("android"));
    ok(ids.includes("clerk"));
  });

  it("detects Dart from pubspec.yaml without package.json", () => {
    writeFile(
      tmp.path,
      "pubspec.yaml",
      "name: dart_app\ndescription: A Dart CLI tool\nenvironment:\n  sdk: '^3.2.0'",
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "dart"));
  });

  it("returns correct skills for Dart detection", () => {
    writeFile(tmp.path, "pubspec.yaml", "name: dart_app\ndescription: A Dart application");
    const { detected } = detectTechnologies(tmp.path);
    const dart = detected.find((t) => t.id === "dart");
    ok(dart);
    ok(dart.skills.includes("kevmoo/dash_skills/dart-best-practices"));
  });

  it("detects Flutter from pubspec.yaml with flutter: key", () => {
    writeFile(
      tmp.path,
      "pubspec.yaml",
      "name: flutter_app\ndescription: A Flutter application\nflutter:\n  uses-material-design: true",
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "flutter"));
  });

  it("returns correct skills for Flutter detection", () => {
    writeFile(
      tmp.path,
      "pubspec.yaml",
      "name: flutter_app\nflutter:\n  uses-material-design: true",
    );
    const { detected } = detectTechnologies(tmp.path);
    const flutter = detected.find((t) => t.id === "flutter");
    ok(flutter);
    ok(flutter.skills.includes("jeffallan/claude-skills/flutter-expert"));
    ok(flutter.skills.includes("madteacher/mad-agents-skills/flutter-animations"));
    ok(flutter.skills.includes("madteacher/mad-agents-skills/flutter-testing"));
  });

  it("detects both Dart and Flutter for Flutter projects", () => {
    writeFile(
      tmp.path,
      "pubspec.yaml",
      "name: flutter_app\nenvironment:\n  sdk: '^3.2.0'\nflutter:\n  uses-material-design: true",
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("dart"), "Dart should be detected (pubspec.yaml exists)");
    ok(ids.includes("flutter"), "Flutter should be detected (flutter: key present)");
  });

  it("detects only Dart when pubspec.yaml has no flutter: key", () => {
    writeFile(
      tmp.path,
      "pubspec.yaml",
      "name: dart_cli\ndescription: A Dart CLI tool\nenvironment:\n  sdk: '^3.2.0'\ndependencies:\n  args: ^2.4.0",
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("dart"), "Dart should be detected");
    ok(!ids.includes("flutter"), "Flutter should not be detected");
  });

  it("detects React from deno.json npm: import", () => {
    writeJson(tmp.path, "deno.json", {
      imports: { react: "npm:react@^19", "react-dom": "npm:react-dom@^19" },
    });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "react"));
  });

  it("detects Hono from deno.json npm: import", () => {
    writeJson(tmp.path, "deno.json", { imports: { hono: "npm:hono@^4" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "hono"));
  });

  it("detects Supabase from deno.json npm: scoped import", () => {
    writeJson(tmp.path, "deno.json", {
      imports: { "@supabase/supabase-js": "npm:@supabase/supabase-js@^2" },
    });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "supabase"));
  });

  it("detects frontend from deno.json imports", () => {
    writeJson(tmp.path, "deno.json", { imports: { react: "npm:react@^19" } });
    const { isFrontend } = detectTechnologies(tmp.path);
    strictEqual(isFrontend, true);
  });

  it("merges package.json and deno.json dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { next: "^15" } });
    writeJson(tmp.path, "deno.json", { imports: { react: "npm:react@^19" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("nextjs"));
    ok(ids.includes("react"));
  });

  it("detects react-router-clerk combo end-to-end", () => {
    writePackageJson(tmp.path, {
      dependencies: { "react-router": "^7.0.0", "@clerk/react-router": "^1.0.0" },
    });
    const { combos } = detectTechnologies(tmp.path);
    ok(combos.some((c) => c.id === "react-router-clerk"));
  });

  it("detects tanstack-clerk combo end-to-end", () => {
    writePackageJson(tmp.path, {
      dependencies: { "@tanstack/react-start": "^1.0.0", "@clerk/tanstack-react-start": "^1.0.0" },
    });
    const { combos } = detectTechnologies(tmp.path);
    ok(combos.some((c) => c.id === "tanstack-clerk"));
  });

  it("detects chrome-extension-clerk combo end-to-end", () => {
    writePackageJson(tmp.path, { dependencies: { "@clerk/chrome-extension": "^1.0.0" } });
    writeFile(
      tmp.path,
      "manifest.json",
      JSON.stringify({ manifest_version: 3, name: "Ext", version: "1.0" }),
    );
    const { combos } = detectTechnologies(tmp.path);
    ok(combos.some((c) => c.id === "chrome-extension-clerk"));
  });

  it("detects swiftui-clerk combo end-to-end", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      'dependencies: [.package(url: "https://github.com/clerk/clerk-ios", from: "1.0.0")]',
    );
    const { detected, combos } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("swiftui"));
    ok(ids.includes("clerk"));
    ok(combos.some((c) => c.id === "swiftui-clerk"));
  });

  it("detects android-clerk combo end-to-end", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `plugins { id("com.android.application") }\ndependencies { implementation("com.clerk:clerk-android:1.0.0") }`,
    );
    const { detected, combos } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("android"));
    ok(ids.includes("clerk"));
    ok(combos.some((c) => c.id === "android-clerk"));
  });

  it("detects Terraform from .terraform.lock.hcl", () => {
    writeFile(
      tmp.path,
      ".terraform.lock.hcl",
      "# This file is maintained automatically by terraform",
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "terraform"));
  });

  it("detects Terraform from terraform.tfvars", () => {
    writeFile(tmp.path, "terraform.tfvars", 'region = "us-east-1"');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "terraform"));
  });

  it("detects Terraform from main.tf", () => {
    writeFile(tmp.path, "main.tf", 'terraform {\n  required_version = ">= 1.0"\n}');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "terraform"));
  });

  it("detects Terraform from variables.tf", () => {
    writeFile(tmp.path, "variables.tf", 'variable "region" {\n  type = string\n}');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "terraform"));
  });

  it("detects Terraform from outputs.tf", () => {
    writeFile(tmp.path, "outputs.tf", 'output "vpc_id" {\n  value = aws_vpc.main.id\n}');
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "terraform"));
  });

  it("returns correct skills for Terraform detection", () => {
    writeFile(tmp.path, ".terraform.lock.hcl", "# terraform lock file");
    const { detected } = detectTechnologies(tmp.path);
    const terraform = detected.find((t) => t.id === "terraform");
    ok(terraform);
    ok(terraform.skills.includes("hashicorp/agent-skills/terraform-style-guide"));
    ok(terraform.skills.includes("hashicorp/agent-skills/refactor-module"));
    ok(terraform.skills.includes("hashicorp/agent-skills/terraform-stacks"));
    ok(terraform.skills.includes("wshobson/agents/terraform-module-library"));
  });
});

// ── readDenoJson ──────────────────────────────────────────────

describe("readDenoJson", () => {
  const tmp = useTmpDir();

  it("returns null when no deno.json exists", () => {
    strictEqual(readDenoJson(tmp.path), null);
  });

  it("parses valid deno.json", () => {
    const data = { imports: { "@std/path": "jsr:@std/path@^1" } };
    writeJson(tmp.path, "deno.json", data);
    deepStrictEqual(readDenoJson(tmp.path), data);
  });

  it("parses deno.jsonc when deno.json is absent", () => {
    const data = { imports: { hono: "npm:hono@^4" } };
    writeJson(tmp.path, "deno.jsonc", data);
    deepStrictEqual(readDenoJson(tmp.path), data);
  });

  it("prefers deno.json over deno.jsonc", () => {
    writeJson(tmp.path, "deno.json", { from: "json" });
    writeJson(tmp.path, "deno.jsonc", { from: "jsonc" });
    deepStrictEqual(readDenoJson(tmp.path), { from: "json" });
  });

  it("returns null for invalid JSON", () => {
    writeFile(tmp.path, "deno.json", "{ not valid }");
    strictEqual(readDenoJson(tmp.path), null);
  });
});

// ── getDenoImportNames ────────────────────────────────────────

describe("getDenoImportNames", () => {
  it("returns empty array for null input", () => {
    deepStrictEqual(getDenoImportNames(null), []);
  });

  it("returns empty array when no imports field", () => {
    deepStrictEqual(getDenoImportNames({}), []);
  });

  it("extracts npm: prefixed packages", () => {
    const result = getDenoImportNames({ imports: { express: "npm:express@^4" } });
    deepStrictEqual(result, ["express"]);
  });

  it("extracts jsr: prefixed packages", () => {
    const result = getDenoImportNames({ imports: { "@std/path": "jsr:@std/path@^1" } });
    deepStrictEqual(result, ["@std/path"]);
  });

  it("handles scoped npm packages", () => {
    const result = getDenoImportNames({
      imports: { "@supabase/supabase-js": "npm:@supabase/supabase-js@^2" },
    });
    deepStrictEqual(result, ["@supabase/supabase-js"]);
  });

  it("skips non-npm/jsr specifiers", () => {
    const result = getDenoImportNames({
      imports: {
        react: "npm:react@^19",
        local: "./local.ts",
        remote: "https://deno.land/x/mod@v1/mod.ts",
      },
    });
    deepStrictEqual(result, ["react"]);
  });

  it("handles multiple imports", () => {
    const result = getDenoImportNames({
      imports: { react: "npm:react@^19", hono: "npm:hono@^4", "@std/fs": "jsr:@std/fs@^1" },
    });
    ok(result.includes("react"));
    ok(result.includes("hono"));
    ok(result.includes("@std/fs"));
    strictEqual(result.length, 3);
  });
});

// ── detectTechnologies (Ruby/Rails) ───────────────────────────

describe("detectTechnologies (Ruby/Rails)", () => {
  const tmp = useTmpDir();

  it("detects Ruby from Gemfile", () => {
    writeFile(tmp.path, "Gemfile", "source 'https://rubygems.org'\ngem 'rails'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "ruby"));
  });

  it("detects Ruby on Rails from Gemfile", () => {
    writeFile(tmp.path, "Gemfile", "gem 'rails', '~> 7.1'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "rails"));
  });

  it("detects Rails from config/routes.rb", () => {
    writeFile(tmp.path, "config/routes.rb", "Rails.application.routes.draw do\nend\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "rails"));
  });

  it("detects PostgreSQL from pg gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'pg'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "postgres-ruby"));
  });

  it("detects Redis from redis gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'redis'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "redis-ruby"));
  });

  it("detects Redis from sidekiq gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'sidekiq'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "redis-ruby"));
    ok(detected.some((t) => t.id === "sidekiq"));
  });

  it("detects Sorbet from sorbet gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'sorbet'\ngem 'sorbet-runtime'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "sorbet"));
  });

  it("detects ActiveAdmin from activeadmin gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'activeadmin'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "activeadmin"));
  });

  it("detects Devise from devise gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'devise'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "devise"));
  });

  it("detects RSpec from rspec-rails gem", () => {
    writeFile(tmp.path, "Gemfile", "gem 'rspec-rails'\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "rspec"));
  });

  it("detects RuboCop from .rubocop.yml", () => {
    writeFile(tmp.path, ".rubocop.yml", "AllCops:\n  TargetRubyVersion: 3.2\n");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "rubocop"));
  });

  it("detects multiple Ruby technologies from a single Gemfile", () => {
    writeFile(
      tmp.path,
      "Gemfile",
      "gem 'rails', '~> 7.1'\ngem 'pg'\ngem 'redis'\ngem 'sidekiq'\ngem 'devise'\ngem 'sorbet-runtime'\n",
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("ruby"));
    ok(ids.includes("rails"));
    ok(ids.includes("postgres-ruby"));
    ok(ids.includes("redis-ruby"));
    ok(ids.includes("sidekiq"));
    ok(ids.includes("devise"));
    ok(ids.includes("sorbet"));
  });
});

// ── detectTechnologies (monorepo) ─────────────────────────────

describe("detectTechnologies (monorepo)", () => {
  const tmp = useTmpDir();

  it("detects technologies from workspace subpackages", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/web", { dependencies: { next: "^15", react: "^19" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("nextjs"));
    ok(ids.includes("react"));
  });

  it("merges root and workspace technologies", () => {
    writePackageJson(tmp.path, {
      devDependencies: { typescript: "^5" },
      workspaces: ["packages/*"],
    });
    writeFile(tmp.path, "tsconfig.json", "{}");
    addWorkspace(tmp.path, "packages/api", { dependencies: { express: "^4" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("typescript"), "root tech should be detected");
    ok(ids.includes("express"), "workspace tech should be detected");
  });

  it("deduplicates technologies across workspaces", () => {
    writePackageJson(tmp.path, { workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/ui", { dependencies: { react: "^19" } });
    addWorkspace(tmp.path, "packages/app", { dependencies: { react: "^19" } });
    const { detected } = detectTechnologies(tmp.path);
    const reactCount = detected.filter((t) => t.id === "react").length;
    strictEqual(reactCount, 1, "react should appear only once");
  });

  it("detects config files in workspace directories", () => {
    writePackageJson(tmp.path, { workspaces: ["apps/*"] });
    addWorkspace(tmp.path, "apps/web");
    writeFile(tmp.path, "apps/web/next.config.mjs", "export default {}");
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "nextjs"));
  });

  it("detects frontend from any workspace", () => {
    writePackageJson(tmp.path, { dependencies: { express: "^4" }, workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/ui", { dependencies: { react: "^19" } });
    const { isFrontend } = detectTechnologies(tmp.path);
    strictEqual(isFrontend, true);
  });

  it("detects combos across workspaces", () => {
    writePackageJson(tmp.path, { dependencies: { next: "^15" }, workspaces: ["packages/*"] });
    addWorkspace(tmp.path, "packages/db", { dependencies: { "@supabase/supabase-js": "^2" } });
    const { combos } = detectTechnologies(tmp.path);
    ok(
      combos.some((c) => c.id === "nextjs-supabase"),
      "cross-workspace combo should be detected",
    );
  });

  it("works with pnpm-workspace.yaml", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n");
    addWorkspace(tmp.path, "packages/app", { dependencies: { vue: "^3" } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "vue"));
  });

  it("detects config file content in workspaces", () => {
    writePackageJson(tmp.path, { workspaces: ["workers/*"] });
    addWorkspace(tmp.path, "workers/do-worker");
    writeJson(tmp.path, "workers/do-worker/wrangler.json", { durable_objects: { bindings: [] } });
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "cloudflare-durable-objects"));
  });
});

// ── detectCombos ──────────────────────────────────────────────

describe("detectCombos", () => {
  it("returns empty array when no combos match", () => {
    strictEqual(detectCombos(["react"]).length, 0);
  });

  it("returns empty array for empty input", () => {
    strictEqual(detectCombos([]).length, 0);
  });

  it("detects expo + tailwind combo", () => {
    ok(detectCombos(["expo", "tailwind"]).some((c) => c.id === "expo-tailwind"));
  });

  it("detects combo even with extra technologies", () => {
    ok(
      detectCombos(["react", "expo", "tailwind", "typescript"]).some(
        (c) => c.id === "expo-tailwind",
      ),
    );
  });

  it("detects multiple combos simultaneously", () => {
    const combos = detectCombos(["nextjs", "supabase", "playwright"]);
    const ids = combos.map((c) => c.id);
    ok(ids.includes("nextjs-supabase"));
    ok(ids.includes("nextjs-playwright"));
  });

  it("does not detect combo when only one requirement is met", () => {
    ok(!detectCombos(["nextjs"]).some((c) => c.id === "nextjs-supabase"));
  });

  it("detects nextjs-clerk combo", () => {
    const combo = detectCombos(["nextjs", "clerk"]).find((c) => c.id === "nextjs-clerk");
    ok(combo);
    ok(combo.skills.includes("clerk/skills/clerk-nextjs-patterns"));
  });

  it("detects nuxt-clerk combo", () => {
    const combo = detectCombos(["nuxt", "clerk"]).find((c) => c.id === "nuxt-clerk");
    ok(combo);
    ok(combo.skills.includes("clerk/skills/clerk-nuxt-patterns"));
  });

  it("detects vue-clerk combo", () => {
    ok(detectCombos(["vue", "clerk"]).some((c) => c.id === "vue-clerk"));
  });

  it("detects react-clerk combo", () => {
    ok(detectCombos(["react", "clerk"]).some((c) => c.id === "react-clerk"));
  });

  it("detects astro-clerk combo", () => {
    ok(detectCombos(["astro", "clerk"]).some((c) => c.id === "astro-clerk"));
  });

  it("detects expo-clerk combo", () => {
    ok(detectCombos(["expo", "clerk"]).some((c) => c.id === "expo-clerk"));
  });

  it("detects react-react-three-fiber combo", () => {
    ok(
      detectCombos(["threejs", "react", "@react-three/fiber"]).some(
        (c) => c.id === "react-react-three-fiber",
      ),
    );
  });

  it("does not detect react-react-three-fiber combo without react", () => {
    ok(
      !detectCombos(["threejs", "@react-three/fiber"]).some(
        (c) => c.id === "react-react-three-fiber",
      ),
    );
  });

  it("does not detect react-react-three-fiber combo without Three.js", () => {
    ok(
      !detectCombos(["react", "@react-three/fiber"]).some(
        (c) => c.id === "react-react-three-fiber",
      ),
    );
  });

  it("does not detect nextjs-clerk combo without clerk", () => {
    ok(!detectCombos(["nextjs"]).some((c) => c.id === "nextjs-clerk"));
  });

  it("detects react-router-clerk combo", () => {
    ok(detectCombos(["react-router", "clerk"]).some((c) => c.id === "react-router-clerk"));
  });

  it("does not detect react-router-clerk combo without clerk", () => {
    ok(!detectCombos(["react-router"]).some((c) => c.id === "react-router-clerk"));
  });

  it("detects tanstack-clerk combo", () => {
    ok(detectCombos(["tanstack-start", "clerk"]).some((c) => c.id === "tanstack-clerk"));
  });

  it("does not detect tanstack-clerk combo without tanstack-start", () => {
    ok(!detectCombos(["clerk"]).some((c) => c.id === "tanstack-clerk"));
  });

  it("detects chrome-extension-clerk combo", () => {
    ok(detectCombos(["chrome-extension", "clerk"]).some((c) => c.id === "chrome-extension-clerk"));
  });

  it("does not detect chrome-extension-clerk combo without chrome-extension", () => {
    ok(!detectCombos(["clerk"]).some((c) => c.id === "chrome-extension-clerk"));
  });

  it("detects swiftui-clerk combo", () => {
    ok(detectCombos(["swiftui", "clerk"]).some((c) => c.id === "swiftui-clerk"));
  });

  it("does not detect swiftui-clerk combo without clerk", () => {
    ok(!detectCombos(["swiftui"]).some((c) => c.id === "swiftui-clerk"));
  });

  it("detects android-clerk combo", () => {
    ok(detectCombos(["android", "clerk"]).some((c) => c.id === "android-clerk"));
  });

  it("does not detect android-clerk combo without clerk", () => {
    ok(!detectCombos(["android"]).some((c) => c.id === "android-clerk"));
  });

  it("detects rails-rspec combo", () => {
    ok(detectCombos(["rails", "rspec"]).some((c) => c.id === "rails-rspec"));
  });

  it("detects rails-sidekiq combo", () => {
    ok(detectCombos(["rails", "sidekiq"]).some((c) => c.id === "rails-sidekiq"));
  });

  it("does not detect rails-rspec combo without rspec", () => {
    ok(!detectCombos(["rails"]).some((c) => c.id === "rails-rspec"));
  });
});
