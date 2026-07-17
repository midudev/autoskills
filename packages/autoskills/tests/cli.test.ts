import { describe, it } from "node:test";
import { ok, strictEqual } from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { existsSync, readFileSync, mkdirSync, writeFileSync, symlinkSync } from "node:fs";
import { join, resolve } from "node:path";
import { useTmpDir, writePackageJson, writeFile, writeJson, addWorkspace } from "./helpers.ts";

const CLI_PATH = resolve(import.meta.dirname!, "..", "index.mjs");

function run(args: string[] = [], cwd: string = process.cwd()): string {
  return execFileSync(process.execPath, [CLI_PATH, ...args], {
    cwd,
    encoding: "utf-8",
    timeout: 10_000,
    env: { ...process.env, NO_COLOR: "1" },
  });
}

describe("CLI", () => {
  const tmp = useTmpDir();

  it("shows help with --help", () => {
    const output = run(["--help"]);
    ok(output.includes("autoskills"));
    ok(output.includes("--dry-run"));
    ok(output.includes("--clear-cache"));
    ok(output.includes("--yes"));
    ok(output.includes("--agent"));
  });

  it("shows help with -h", () => {
    const output = run(["-h"]);
    ok(output.includes("autoskills"));
  });

  it("clears the autoskills cache with --clear-cache", () => {
    const cacheDir = join(tmp.path, "cache");
    const prevCacheDir = process.env.AUTOSKILLS_CACHE_DIR;

    process.env.AUTOSKILLS_CACHE_DIR = cacheDir;
    try {
      writeFile(tmp.path, "cache/bundle/SKILL.md", "# cached");

      const output = run(["--clear-cache"], tmp.path);

      ok(output.includes("Cleared autoskills cache"));
      ok(output.includes(cacheDir));
      ok(!existsSync(cacheDir));
    } finally {
      if (prevCacheDir === undefined) delete process.env.AUTOSKILLS_CACHE_DIR;
      else process.env.AUTOSKILLS_CACHE_DIR = prevCacheDir;
    }
  });

  describe("--dry-run", () => {
    const tmp = useTmpDir();

    it("shows detected technologies without installing", () => {
      writePackageJson(tmp.path, {
        dependencies: { react: "^19", next: "^15" },
        devDependencies: { typescript: "^5" },
      });
      writeFile(tmp.path, "tsconfig.json", "{}");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("React"));
      ok(output.includes("Next.js"));
      ok(output.includes("TypeScript"));
      ok(output.includes("--dry-run"));
      ok(output.includes("nothing was installed"));
    });

    it("warns when no technologies are detected", () => {
      writePackageJson(tmp.path);

      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("No supported technologies"));
    });

    it("shows skills grouped by source technology", () => {
      writePackageJson(tmp.path, {
        devDependencies: { tailwindcss: "^4", typescript: "^5" },
      });
      writeFile(tmp.path, "tsconfig.json", "{}");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("tailwind-css-patterns"));
      ok(output.includes("typescript-advanced-types"));
      ok(output.includes("Tailwind CSS"));
      ok(output.includes("TypeScript"));
    });

    it("detects technologies from config files only", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "next.config.mjs", "export default {}");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("Next.js"));
    });

    it("detects Bash scripts and suggests defensive patterns", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "scripts/deploy.sh", "#!/usr/bin/env bash\nset -euo pipefail\n");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("Bash"));
      ok(output.includes("bash-defensive-patterns"));
    });

    it("detects InstantDB and suggests the official skill", () => {
      writePackageJson(tmp.path, { dependencies: { "@instantdb/react": "^0.21.0" } });

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("InstantDB"));
      ok(output.includes("instantdb"));
    });

    it("detects Astro from package.json", () => {
      writePackageJson(tmp.path, { dependencies: { astro: "^5" } });

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("Astro"));
      ok(output.includes("astro"));
    });

    it("detects Astro from config file", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "astro.config.mjs", "export default {}");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("Astro"));
    });

    it("detects oxlint from package.json", () => {
      writePackageJson(tmp.path, { devDependencies: { oxlint: "^0.16" } });

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("oxlint"));
    });

    it("detects oxlint from config file", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, ".oxlintrc.json", "{}");

      const output = run(["--dry-run"], tmp.path);

      ok(output.includes("oxlint"));
    });

    it("detects Pinia from package.json", () => {
      writePackageJson(tmp.path, { dependencies: { pinia: "^2" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Pinia"));
      ok(output.includes("vue-pinia-best-practices"));
    });

    it("detects GSAP from package.json", () => {
      writePackageJson(tmp.path, { dependencies: { gsap: "^3" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("GSAP"));
      ok(output.includes("gsap-core"));
      ok(output.includes("gsap-scrolltrigger"));
    });

    it("detects GSAP + React combo", () => {
      writePackageJson(tmp.path, {
        dependencies: { gsap: "^3", react: "^19", "react-dom": "^19" },
      });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("GSAP"));
      ok(output.includes("React"));
      ok(output.includes("GSAP + React"));
      ok(output.includes("gsap-react"));
    });

    it("detects Tailwind + shadcn/ui combo", () => {
      writePackageJson(tmp.path, { devDependencies: { tailwindcss: "^4" } });
      writeFile(tmp.path, "components.json", "{}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Tailwind CSS"));
      ok(output.includes("shadcn/ui"));
      ok(output.includes("Tailwind CSS + shadcn/ui"));
      ok(output.includes("tailwind-v4-shadcn"));
    });

    it("detects Cloudflare base skills from wrangler package", () => {
      writePackageJson(tmp.path, { devDependencies: { wrangler: "^3" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare"));
      ok(output.includes("cloudflare"));
      ok(output.includes("wrangler"));
      ok(!output.includes("cloudflare/skills/cloudflare"));
      ok(output.includes("workers-best-practices"));
    });

    it("detects Cloudflare from wrangler.json config file", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "wrangler.json", { name: "my-worker" });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare"));
    });

    it("detects Durable Objects from wrangler.json content", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "wrangler.json", {
        name: "my-worker",
        durable_objects: { bindings: [{ name: "MY_DO", class_name: "MyDO" }] },
      });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Durable Objects"));
      ok(output.includes("durable-objects"));
      ok(!output.includes("cloudflare/skills/durable-objects"));
    });

    it("detects Cloudflare AI from wrangler.json content", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "wrangler.json", { name: "my-worker", ai: { binding: "AI" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare AI"));
      ok(output.includes("agents-sdk"));
    });

    it("detects Cloudflare Agents from agents package", () => {
      writePackageJson(tmp.path, { dependencies: { agents: "^1" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare Agents"));
      ok(output.includes("agents-sdk"));
      ok(output.includes("sandbox-sdk"));
    });

    it("detects Cloudflare + Vite combo for vinext", () => {
      writePackageJson(tmp.path, { devDependencies: { wrangler: "^3", vite: "^6" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare"));
      ok(output.includes("Vite"));
      ok(output.includes("Cloudflare + Vite"));
      ok(output.includes("migrate-to-vinext"));
    });

    it("detects Vercel deploy from .vercel directory", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, ".vercel/.gitkeep");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Vercel"));
      ok(output.includes("deploy-to-vercel"));
    });

    it("detects Vercel deploy from @astrojs/vercel adapter", () => {
      writePackageJson(tmp.path, { dependencies: { astro: "^5", "@astrojs/vercel": "^8" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Vercel"));
      ok(output.includes("deploy-to-vercel"));
    });

    it("detects Cloudflare from @astrojs/cloudflare adapter", () => {
      writePackageJson(tmp.path, { dependencies: { astro: "^5", "@astrojs/cloudflare": "^12" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Cloudflare"));
      ok(output.includes("cloudflare"));
      ok(!output.includes("cloudflare/skills/cloudflare"));
      ok(output.includes("workers-best-practices"));
    });

    it("detects Bun from bun.lockb", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "bun.lockb");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Bun"));
      ok(output.includes("midudev"));
      ok(output.includes("bun"));
      ok(!output.includes("https://bun.sh/docs"));
    });

    it("detects Bun from bunfig.toml", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "bunfig.toml", "[install]");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Bun"));
    });

    it("detects Deno from deno.json", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "deno.json", "{}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Deno"));
      ok(output.includes("deno-expert"));
      ok(output.includes("deno-typescript"));
    });

    it("detects Node.js from package-lock.json", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "package-lock.json", "{}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Node.js"));
      ok(output.includes("nodejs-backend-patterns"));
      ok(output.includes("nodejs-best-practices"));
    });

    it("detects Node.js + Express combo", () => {
      writePackageJson(tmp.path, { dependencies: { express: "^4" } });
      writeFile(tmp.path, "package-lock.json", "{}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Node.js"));
      ok(output.includes("Express"));
      ok(output.includes("Node.js + Express"));
      ok(output.includes("nodejs-express-server"));
    });

    it("shows Go curated skills in declared order", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "go.mod", "module example.com/test\n\ngo 1.24.0\n");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Go"));
      ok(output.includes("golang-patterns"));
      ok(output.includes("golang-testing"));
      ok(output.indexOf("golang-patterns") < output.indexOf("golang-testing"));
      ok(!output.includes("No skills available for your stack yet."));
      ok(output.includes("nothing was installed"));
    });

    it("detects WordPress from wp-config.php", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "wp-config.php", "<?php // WP config");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("WordPress"));
      ok(output.includes("wp-plugin-development"));
      ok(output.includes("wp-rest-api"));
      ok(output.includes("wp-performance"));
    });

    it("detects WordPress from @wordpress npm packages", () => {
      writePackageJson(tmp.path, { devDependencies: { "@wordpress/scripts": "^30" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("WordPress"));
      ok(output.includes("wp-block-development"));
    });

    it("detects WordPress from composer.json with wpackagist", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "composer.json", {
        require: { "wpackagist-plugin/advanced-custom-fields": "^6" },
      });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("WordPress"));
    });

    it("detects WordPress from style.css theme header", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "style.css", "/*\nTheme Name: My Theme\nAuthor: Test\n*/");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("WordPress"));
      ok(output.includes("wp-block-themes"));
    });

    it("detects Rust from Cargo.toml", () => {
      writeFile(tmp.path, "Cargo.toml", '[package]\nname = "my-crate"\nversion = "0.1.0"');
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Rust"));
      ok(output.includes("rust-best-practices"));
    });

    it("detects web frontend from .html files and installs web fundamentals", () => {
      writeFile(tmp.path, "public/index.html", "<html></html>");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Web frontend detected"));
      ok(output.includes("frontend-design"));
      ok(output.includes("accessibility"));
      ok(output.includes("seo"));
    });

    it("detects web frontend from .tpl files (PrestaShop)", () => {
      writeFile(tmp.path, "themes/classic/templates/index.tpl", "{block name='content'}{/block}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Web frontend detected"));
      ok(output.includes("frontend-design"));
    });

    it("detects web frontend from .twig files (Symfony/PHP)", () => {
      writeFile(tmp.path, "templates/base.html.twig", "{% block body %}{% endblock %}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Web frontend detected"));
    });

    it("detects web frontend from .blade.php files (Laravel)", () => {
      writeFile(tmp.path, "resources/views/app.blade.php", "@yield('content')");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Web frontend detected"));
    });

    it("detects web frontend from .css files", () => {
      writeFile(tmp.path, "assets/main.css", "body { margin: 0 }");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Web frontend detected"));
    });

    it("does NOT detect web frontend from .php files alone", () => {
      writeFile(tmp.path, "src/index.php", "<?php echo 'hello';");
      writeFile(tmp.path, "src/controller.php", "<?php class Controller {}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("No supported technologies"));
    });

    it("detects technologies from monorepo workspaces with --dry-run", () => {
      writePackageJson(tmp.path, {
        devDependencies: { typescript: "^5" },
        workspaces: ["packages/*", "apps/*"],
      });
      writeFile(tmp.path, "tsconfig.json", "{}");
      addWorkspace(tmp.path, "packages/ui", { dependencies: { react: "^19", tailwindcss: "^4" } });
      addWorkspace(tmp.path, "apps/web", { dependencies: { next: "^15" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("TypeScript"), "root tech detected");
      ok(output.includes("React"), "workspace tech detected");
      ok(output.includes("Next.js"), "workspace tech detected");
      ok(output.includes("Tailwind"), "workspace tech detected");
      ok(output.includes("nothing was installed"));
    });

    it("detects technologies from pnpm monorepo with --dry-run", () => {
      writePackageJson(tmp.path);
      writeFile(tmp.path, "pnpm-workspace.yaml", "packages:\n  - packages/*\n");
      addWorkspace(tmp.path, "packages/api", { dependencies: { express: "^4" } });
      writeFile(tmp.path, "package-lock.json", "{}");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Express"), "workspace tech detected via pnpm");
      ok(output.includes("Node.js"));
    });

    it("detects technologies from Gradle multi-module project with --dry-run", () => {
      writePackageJson(tmp.path);
      writeFile(
        tmp.path,
        "settings.gradle.kts",
        'rootProject.name = "my-app"\ninclude("adapters:web")',
      );
      writeFile(tmp.path, "build.gradle.kts", "sourceCompatibility = JavaVersion.VERSION_17");
      writeFile(
        tmp.path,
        "adapters/web/build.gradle.kts",
        'plugins { id("org.springframework.boot") }',
      );
      writeFile(tmp.path, "src/main/resources/application.properties", "server.port=8080");
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Java"));
      ok(output.includes("Spring Boot"));
    });

    it("adds web fundamentals when npm frontend is detected too", () => {
      writePackageJson(tmp.path, { dependencies: { react: "^19", next: "^15" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("React"));
      ok(output.includes("frontend-design"));
      ok(output.includes("accessibility"));
      ok(output.includes("seo"));
    });

    it("shows auto-detected agents in dry-run output", () => {
      writePackageJson(tmp.path, { dependencies: { react: "^19" } });
      const output = run(["--dry-run"], tmp.path);
      ok(output.includes("Agents:"));
      ok(output.includes("universal"));
    });

    it("shows user-specified agents instead of auto-detected", () => {
      writePackageJson(tmp.path, { dependencies: { react: "^19" } });
      const output = run(["--dry-run", "-a", "cursor"], tmp.path);
      ok(output.includes("Agents: cursor"));
      ok(!output.includes("universal"));
    });
  });

  describe("remove", () => {
    const tmp = useTmpDir();

    it("shows informative message when no skills are installed", () => {
      writePackageJson(tmp.path);
      const output = run(["remove"], tmp.path);
      ok(output.includes("No skills installed"));
    });

    it("shows dry-run message for remove when skill is installed", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "skills-lock.json", {
        version: 1,
        skills: { "react-best-practices": { source: "test", sourceType: "test", computedHash: "abc" } },
      });
      writeFile(tmp.path, ".agents/skills/react-best-practices/SKILL.md", "# React best practices");
      const output = run(["remove", "react-best-practices", "--dry-run"], tmp.path);
      ok(output.includes("Would remove"));
      ok(output.includes("react-best-practices"));
    });

    it("removes skill from .agents/skills directory", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "skills-lock.json", {
        version: 1,
        skills: { "react-best-practices": { source: "test", sourceType: "test", computedHash: "abc" } },
      });
      writeFile(tmp.path, ".agents/skills/react-best-practices/SKILL.md", "# React best practices");
      run(["remove", "react-best-practices", "-y"], tmp.path);
      ok(!existsSync(join(tmp.path, ".agents/skills/react-best-practices")));
    });

    it("removes skill entry from skills-lock.json", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "skills-lock.json", {
        version: 1,
        skills: {
          "react-best-practices": { source: "test", sourceType: "test", computedHash: "abc" },
          "vue-best-practices": { source: "test", sourceType: "test", computedHash: "def" },
        },
      });
      run(["remove", "react-best-practices", "-y"], tmp.path);
      const lock = JSON.parse(readFileSync(join(tmp.path, "skills-lock.json"), "utf-8"));
      ok(!("react-best-practices" in lock.skills));
      ok("vue-best-practices" in lock.skills);
    });

    it("removes symlinks from all agent folders", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "skills-lock.json", {
        version: 1,
        skills: { "react-best-practices": { source: "test", sourceType: "test", computedHash: "abc" } },
      });
      writeFile(tmp.path, ".agents/skills/react-best-practices/SKILL.md", "# React best practices");
      const canonicalPath = join(tmp.path, ".agents/skills/react-best-practices");
      for (const folder of [".claude", ".cursor", ".junie"]) {
        const skillsDir = join(tmp.path, folder, "skills");
        mkdirSync(skillsDir, { recursive: true });
        const linkPath = join(skillsDir, "react-best-practices");
        try {
          symlinkSync(canonicalPath, linkPath, "dir");
        } catch {}
      }
      run(["remove", "react-best-practices", "-y"], tmp.path);
      ok(!existsSync(join(tmp.path, ".claude/skills/react-best-practices")));
      ok(!existsSync(join(tmp.path, ".cursor/skills/react-best-practices")));
      ok(!existsSync(join(tmp.path, ".junie/skills/react-best-practices")));
    });

    it("shows informative message when removing non-installed skill", () => {
      writePackageJson(tmp.path);
      writeJson(tmp.path, "skills-lock.json", {
        version: 1,
        skills: { "vue-best-practices": { source: "test", sourceType: "test", computedHash: "def" } },
      });
      const output = run(["remove", "non-existent-skill"], tmp.path);
      ok(output.includes("is not installed"));
    });

    it("shows remove command in help", () => {
      const output = run(["--help"]);
      ok(output.includes("remove"));
      ok(output.includes("rm"));
    });
  });
});
