import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual } from "node:assert/strict";
import {
  getAllPackageNames,
  readPackageJson,
  readDenoJson,
  getDenoImportNames,
  detectTechnologies,
  detectCombos,
} from "../lib.mjs";
import { useTmpDir, writePackageJson, writeJson, writeFile, addWorkspace } from "./helpers.mjs";

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
    const ids = detected.map((t) => t.id);

    ok(ids.includes("go"));
  });

  it("detects Go from go.work", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "go.work", "go 1.24.0\n");

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);

    ok(ids.includes("go"));
  });

  it("does not detect Go without go.mod or go.work", () => {
    writePackageJson(tmp.path);

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);

    ok(!ids.includes("go"));
  });

  it("detects Three.js from dependencies", () => {
    writePackageJson(tmp.path, { dependencies: { three: "^0.173.0" } });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("threejs"));
  });

  it("keeps Three.js detection when React and React Three Fiber are present", () => {
    writePackageJson(tmp.path, {
      dependencies: { three: "^0.173.0", react: "^19.0.0", "react-dom": "^19.0.0" },
    });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("threejs"));
  });

  it("detects React + React Three Fiber combo when Three.js is present", () => {
    writePackageJson(tmp.path, {
      dependencies: { three: "^0.173.0", react: "^19.0.0", "@react-three/fiber": "^9.0.0" },
    });
    const { combos } = detectTechnologies(tmp.path);
    const comboIds = combos.map((c) => c.id);
    ok(comboIds.includes("react-react-three-fiber"));
  });

  it("detects shadcn/ui from components.json", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "components.json", "{}");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("shadcn"));
  });

  it("detects Cloudflare from wrangler.toml", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "wrangler.toml");
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("cloudflare"));
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
    const comboIds = combos.map((c) => c.id);
    ok(comboIds.includes("expo-tailwind"));
  });

  it("returns no combos when only one technology of a pair is present", () => {
    writePackageJson(tmp.path, { dependencies: { expo: "^52.0.0" } });
    const { combos } = detectTechnologies(tmp.path);
    const comboIds = combos.map((c) => c.id);
    ok(!comboIds.includes("expo-tailwind"));
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
      `<project>
        <dependencies>
          <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
          </dependency>
        </dependencies>
      </project>`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "springboot"));
  });

  it("detects both Java and Spring Boot from a Maven Spring Boot project", () => {
    writeFile(
      tmp.path,
      "pom.xml",
      `<project>
        <dependencies>
          <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
          </dependency>
        </dependencies>
      </project>`,
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
      `
import PackageDescription
let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/clerk/clerk-ios", from: "1.0.0"),
  ]
)
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from Package.swift with ClerkSDK import", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `
import PackageDescription
let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/example/ClerkSDK", from: "2.0.0"),
  ]
)
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("does not detect Clerk from Package.swift without Clerk references", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `
import PackageDescription
let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
  ]
)
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "clerk"));
  });

  it("detects Clerk from Gradle with com.clerk dependency", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `
plugins {
  id("com.android.application")
}
dependencies {
  implementation("com.clerk:clerk-android:1.0.0")
}
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(detected.some((t) => t.id === "clerk"));
  });

  it("does not detect Clerk from Gradle without com.clerk", () => {
    writePackageJson(tmp.path);
    writeFile(
      tmp.path,
      "app/build.gradle.kts",
      `
plugins {
  id("com.android.application")
}
dependencies {
  implementation("com.google.firebase:firebase-auth:22.0.0")
}
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    ok(!detected.some((t) => t.id === "clerk"));
  });

  it("detects both SwiftUI and Clerk from a Swift project with Clerk", () => {
    writeFile(
      tmp.path,
      "Package.swift",
      `
import PackageDescription
let package = Package(
  name: "MySwiftApp",
  dependencies: [
    .package(url: "https://github.com/clerk/clerk-ios", from: "1.0.0"),
  ]
)
`,
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
      `
plugins {
  id("com.android.application")
}
dependencies {
  implementation("com.clerk:clerk-android:1.0.0")
}
`,
    );
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("android"));
    ok(ids.includes("clerk"));
  });

  it("detects React from deno.json npm: import", () => {
    writeJson(tmp.path, "deno.json", {
      imports: { react: "npm:react@^19", "react-dom": "npm:react-dom@^19" },
    });
    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("react"));
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
      `
plugins { id("com.android.application") }
dependencies { implementation("com.clerk:clerk-android:1.0.0") }
`,
    );
    const { detected, combos } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("android"));
    ok(ids.includes("clerk"));
    ok(combos.some((c) => c.id === "android-clerk"));
  });

  it("detects Terraform from .terraform.lock.hcl", () => {
    writeFile(tmp.path, ".terraform.lock.hcl", "# This file is maintained automatically by terraform");
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
      imports: {
        react: "npm:react@^19",
        hono: "npm:hono@^4",
        "@std/fs": "jsr:@std/fs@^1",
      },
    });
    ok(result.includes("react"));
    ok(result.includes("hono"));
    ok(result.includes("@std/fs"));
    strictEqual(result.length, 3);
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
    const ids = detected.map((t) => t.id);
    ok(ids.includes("nextjs"));
  });

  it("detects frontend from any workspace", () => {
    writePackageJson(tmp.path, {
      dependencies: { express: "^4" },
      workspaces: ["packages/*"],
    });
    addWorkspace(tmp.path, "packages/ui", { dependencies: { react: "^19" } });

    const { isFrontend } = detectTechnologies(tmp.path);
    strictEqual(isFrontend, true);
  });

  it("detects combos across workspaces", () => {
    writePackageJson(tmp.path, {
      dependencies: { next: "^15" },
      workspaces: ["packages/*"],
    });
    addWorkspace(tmp.path, "packages/db", { dependencies: { "@supabase/supabase-js": "^2" } });

    const { combos } = detectTechnologies(tmp.path);
    const ids = combos.map((c) => c.id);
    ok(ids.includes("nextjs-supabase"), "cross-workspace combo should be detected");
  });

  it("works with pnpm-workspace.yaml", () => {
    writePackageJson(tmp.path);
    writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n");
    addWorkspace(tmp.path, "packages/app", { dependencies: { vue: "^3" } });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("vue"));
  });

  it("detects config file content in workspaces", () => {
    writePackageJson(tmp.path, { workspaces: ["workers/*"] });
    addWorkspace(tmp.path, "workers/do-worker");
    writeJson(tmp.path, "workers/do-worker/wrangler.json", { durable_objects: { bindings: [] } });

    const { detected } = detectTechnologies(tmp.path);
    const ids = detected.map((t) => t.id);
    ok(ids.includes("cloudflare-durable-objects"));
  });
});

// ── detectCombos ──────────────────────────────────────────────

describe("detectCombos", () => {
  it("returns empty array when no combos match", () => {
    const combos = detectCombos(["react"]);
    strictEqual(combos.length, 0);
  });

  it("returns empty array for empty input", () => {
    const combos = detectCombos([]);
    strictEqual(combos.length, 0);
  });

  it("detects expo + tailwind combo", () => {
    const combos = detectCombos(["expo", "tailwind"]);
    ok(combos.some((c) => c.id === "expo-tailwind"));
  });

  it("detects combo even with extra technologies", () => {
    const combos = detectCombos(["react", "expo", "tailwind", "typescript"]);
    ok(combos.some((c) => c.id === "expo-tailwind"));
  });

  it("detects multiple combos simultaneously", () => {
    const combos = detectCombos(["nextjs", "supabase", "playwright"]);
    const ids = combos.map((c) => c.id);
    ok(ids.includes("nextjs-supabase"));
    ok(ids.includes("nextjs-playwright"));
  });

  it("does not detect combo when only one requirement is met", () => {
    const combos = detectCombos(["nextjs"]);
    ok(!combos.some((c) => c.id === "nextjs-supabase"));
  });

  it("detects nextjs-clerk combo", () => {
    const combos = detectCombos(["nextjs", "clerk"]);
    const combo = combos.find((c) => c.id === "nextjs-clerk");
    ok(combo);
    ok(combo.skills.includes("clerk/skills/clerk-nextjs-patterns"));
  });

  it("detects nuxt-clerk combo", () => {
    const combos = detectCombos(["nuxt", "clerk"]);
    const combo = combos.find((c) => c.id === "nuxt-clerk");
    ok(combo);
    ok(combo.skills.includes("clerk/skills/clerk-nuxt-patterns"));
  });

  it("detects vue-clerk combo", () => {
    const combos = detectCombos(["vue", "clerk"]);
    ok(combos.some((c) => c.id === "vue-clerk"));
  });

  it("detects react-clerk combo", () => {
    const combos = detectCombos(["react", "clerk"]);
    ok(combos.some((c) => c.id === "react-clerk"));
  });

  it("detects astro-clerk combo", () => {
    const combos = detectCombos(["astro", "clerk"]);
    ok(combos.some((c) => c.id === "astro-clerk"));
  });

  it("detects expo-clerk combo", () => {
    const combos = detectCombos(["expo", "clerk"]);
    ok(combos.some((c) => c.id === "expo-clerk"));
  });

  it("detects react-react-three-fiber combo", () => {
    const combos = detectCombos(["threejs", "react", "@react-three/fiber"]);
    ok(combos.some((c) => c.id === "react-react-three-fiber"));
  });

  it("does not detect react-react-three-fiber combo without react", () => {
    const combos = detectCombos(["threejs", "@react-three/fiber"]);
    ok(!combos.some((c) => c.id === "react-react-three-fiber"));
  });

  it("does not detect react-react-three-fiber combo without Three.js", () => {
    const combos = detectCombos(["react", "@react-three/fiber"]);
    ok(!combos.some((c) => c.id === "react-react-three-fiber"));
  });

  it("does not detect nextjs-clerk combo without clerk", () => {
    const combos = detectCombos(["nextjs"]);
    ok(!combos.some((c) => c.id === "nextjs-clerk"));
  });

  it("detects react-router-clerk combo", () => {
    const combos = detectCombos(["react-router", "clerk"]);
    ok(combos.some((c) => c.id === "react-router-clerk"));
  });

  it("does not detect react-router-clerk combo without clerk", () => {
    const combos = detectCombos(["react-router"]);
    ok(!combos.some((c) => c.id === "react-router-clerk"));
  });

  it("detects tanstack-clerk combo", () => {
    const combos = detectCombos(["tanstack-start", "clerk"]);
    ok(combos.some((c) => c.id === "tanstack-clerk"));
  });

  it("does not detect tanstack-clerk combo without tanstack-start", () => {
    const combos = detectCombos(["clerk"]);
    ok(!combos.some((c) => c.id === "tanstack-clerk"));
  });

  it("detects chrome-extension-clerk combo", () => {
    const combos = detectCombos(["chrome-extension", "clerk"]);
    ok(combos.some((c) => c.id === "chrome-extension-clerk"));
  });

  it("does not detect chrome-extension-clerk combo without chrome-extension", () => {
    const combos = detectCombos(["clerk"]);
    ok(!combos.some((c) => c.id === "chrome-extension-clerk"));
  });

  it("detects swiftui-clerk combo", () => {
    const combos = detectCombos(["swiftui", "clerk"]);
    ok(combos.some((c) => c.id === "swiftui-clerk"));
  });

  it("does not detect swiftui-clerk combo without clerk", () => {
    const combos = detectCombos(["swiftui"]);
    ok(!combos.some((c) => c.id === "swiftui-clerk"));
  });

  it("detects android-clerk combo", () => {
    const combos = detectCombos(["android", "clerk"]);
    ok(combos.some((c) => c.id === "android-clerk"));
  });

  it("does not detect android-clerk combo without clerk", () => {
    const combos = detectCombos(["android"]);
    ok(!combos.some((c) => c.id === "android-clerk"));
  });
});
