import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join, resolve } from "node:path";
import { tmpdir } from "node:os";

const CLI_PATH = resolve(import.meta.dirname, "..", "index.mjs");

function run(args = [], cwd = process.cwd()) {
  return execFileSync(process.execPath, [CLI_PATH, ...args], {
    cwd,
    encoding: "utf-8",
    timeout: 10_000,
    env: { ...process.env, NO_COLOR: "1" },
  });
}

describe("CLI", () => {
  it("shows help with --help", () => {
    const output = run(["--help"]);
    assert.ok(output.includes("autoskills"));
    assert.ok(output.includes("--dry-run"));
    assert.ok(output.includes("--yes"));
    assert.ok(output.includes("--agent"));
  });

  it("shows help with -h", () => {
    const output = run(["-h"]);
    assert.ok(output.includes("autoskills"));
  });

  describe("--dry-run", () => {
    let tmpDir;

    beforeEach(() => {
      tmpDir = mkdtempSync(join(tmpdir(), "autoskills-cli-"));
    });

    afterEach(() => {
      rmSync(tmpDir, { recursive: true, force: true });
    });

    it("shows detected technologies without installing", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { react: "^19", next: "^15" },
          devDependencies: { typescript: "^5" },
        }),
      );
      writeFileSync(join(tmpDir, "tsconfig.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("React"));
      assert.ok(output.includes("Next.js"));
      assert.ok(output.includes("TypeScript"));
      assert.ok(output.includes("--dry-run"));
      assert.ok(output.includes("nothing was installed"));
    });

    it("warns when no technologies are detected", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));

      const output = run(["--dry-run"], tmpDir);
      assert.ok(output.includes("No supported technologies"));
    });

    it("shows skills grouped by source technology", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { tailwindcss: "^4", typescript: "^5" },
        }),
      );
      writeFileSync(join(tmpDir, "tsconfig.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("tailwind-css-patterns"));
      assert.ok(output.includes("typescript-advanced-types"));
      assert.ok(output.includes("Tailwind CSS"));
      assert.ok(output.includes("TypeScript"));
    });

    it("detects technologies from config files only", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "next.config.mjs"), "export default {}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Next.js"));
    });

    it("detects Astro from package.json", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { astro: "^5" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Astro"));
      assert.ok(output.includes("astro"));
    });

    it("detects Astro from config file", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "astro.config.mjs"), "export default {}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Astro"));
    });

    it("detects oxlint from package.json", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { oxlint: "^0.16" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("oxlint"));
    });

    it("detects oxlint from config file", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, ".oxlintrc.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("oxlint"));
    });

    it("detects Pinia from package.json", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { pinia: "^2" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Pinia"));
      assert.ok(output.includes("vue-pinia-best-practices"));
    });

    it("detects GSAP from package.json", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { gsap: "^3" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("GSAP"));
      assert.ok(output.includes("gsap-core"));
      assert.ok(output.includes("gsap-scrolltrigger"));
    });

    it("detects GSAP + React combo", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { gsap: "^3", react: "^19", "react-dom": "^19" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("GSAP"));
      assert.ok(output.includes("React"));
      assert.ok(output.includes("GSAP + React"));
      assert.ok(output.includes("gsap-react"));
    });

    it("detects Tailwind + shadcn/ui combo", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { tailwindcss: "^4" },
        }),
      );
      writeFileSync(join(tmpDir, "components.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Tailwind CSS"));
      assert.ok(output.includes("shadcn/ui"));
      assert.ok(output.includes("Tailwind CSS + shadcn/ui"));
      assert.ok(output.includes("tailwind-v4-shadcn"));
    });

    it("detects Cloudflare base skills from wrangler package", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { wrangler: "^3" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare"));
      assert.ok(output.includes("cloudflare/skills/cloudflare"));
      assert.ok(output.includes("cloudflare/skills/wrangler"));
      assert.ok(output.includes("workers-best-practices"));
    });

    it("detects Cloudflare from wrangler.json config file", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "wrangler.json"), JSON.stringify({ name: "my-worker" }));

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare"));
    });

    it("detects Durable Objects from wrangler.json content", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(
        join(tmpDir, "wrangler.json"),
        JSON.stringify({
          name: "my-worker",
          durable_objects: { bindings: [{ name: "MY_DO", class_name: "MyDO" }] },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Durable Objects"));
      assert.ok(output.includes("cloudflare/skills/durable-objects"));
    });

    it("detects Cloudflare AI from wrangler.json content", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(
        join(tmpDir, "wrangler.json"),
        JSON.stringify({ name: "my-worker", ai: { binding: "AI" } }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare AI"));
      assert.ok(output.includes("building-ai-agent-on-cloudflare"));
    });

    it("detects Cloudflare Agents from agents package", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { agents: "^1" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare Agents"));
      assert.ok(output.includes("agents-sdk"));
      assert.ok(output.includes("building-mcp-server-on-cloudflare"));
    });

    it("detects Cloudflare + Vite combo for vinext", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { wrangler: "^3", vite: "^6" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare"));
      assert.ok(output.includes("Vite"));
      assert.ok(output.includes("Cloudflare + Vite"));
      assert.ok(output.includes("migrate-to-vinext"));
    });

    it("detects Vercel deploy from .vercel directory", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      mkdirSync(join(tmpDir, ".vercel"), { recursive: true });

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Vercel"));
      assert.ok(output.includes("deploy-to-vercel"));
    });

    it("detects Vercel deploy from @astrojs/vercel adapter", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { astro: "^5", "@astrojs/vercel": "^8" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Vercel"));
      assert.ok(output.includes("deploy-to-vercel"));
    });

    it("detects Cloudflare from @astrojs/cloudflare adapter", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { astro: "^5", "@astrojs/cloudflare": "^12" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Cloudflare"));
      assert.ok(output.includes("cloudflare/skills/cloudflare"));
      assert.ok(output.includes("workers-best-practices"));
    });

    it("detects Bun from bun.lockb", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "bun.lockb"), "");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Bun"));
      assert.ok(output.includes("https://bun.sh/docs"));
    });

    it("detects Bun from bunfig.toml", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "bunfig.toml"), "[install]");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Bun"));
    });

    it("detects Deno from deno.json", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "deno.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Deno"));
      assert.ok(output.includes("deno-expert"));
      assert.ok(output.includes("deno-typescript"));
    });

    it("detects Node.js from package-lock.json", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "package-lock.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Node.js"));
      assert.ok(output.includes("nodejs-backend-patterns"));
      assert.ok(output.includes("nodejs-best-practices"));
    });

    it("detects Node.js + Express combo", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { express: "^4" },
        }),
      );
      writeFileSync(join(tmpDir, "package-lock.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Node.js"));
      assert.ok(output.includes("Express"));
      assert.ok(output.includes("Node.js + Express"));
      assert.ok(output.includes("nodejs-express-server"));
    });

    it("detects WordPress from wp-config.php", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "wp-config.php"), "<?php // WP config");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("WordPress"));
      assert.ok(output.includes("wp-plugin-development"));
      assert.ok(output.includes("wp-rest-api"));
      assert.ok(output.includes("wp-performance"));
    });

    it("detects WordPress from @wordpress npm packages", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { "@wordpress/scripts": "^30" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("WordPress"));
      assert.ok(output.includes("wp-block-development"));
    });

    it("detects WordPress from composer.json with wpackagist", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(
        join(tmpDir, "composer.json"),
        JSON.stringify({
          require: { "wpackagist-plugin/advanced-custom-fields": "^6" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("WordPress"));
    });

    it("detects WordPress from style.css theme header", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "style.css"), "/*\nTheme Name: My Theme\nAuthor: Test\n*/");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("WordPress"));
      assert.ok(output.includes("wp-block-themes"));
    });

    it("detects web frontend from .html files and installs web fundamentals", () => {
      mkdirSync(join(tmpDir, "public"));
      writeFileSync(join(tmpDir, "public", "index.html"), "<html></html>");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Web frontend detected"));
      assert.ok(output.includes("frontend-design"));
      assert.ok(output.includes("accessibility"));
      assert.ok(output.includes("seo"));
    });

    it("detects web frontend from .tpl files (PrestaShop)", () => {
      mkdirSync(join(tmpDir, "themes", "classic", "templates"), { recursive: true });
      writeFileSync(
        join(tmpDir, "themes", "classic", "templates", "index.tpl"),
        "{block name='content'}{/block}",
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Web frontend detected"));
      assert.ok(output.includes("frontend-design"));
    });

    it("detects web frontend from .twig files (Symfony/PHP)", () => {
      mkdirSync(join(tmpDir, "templates"));
      writeFileSync(join(tmpDir, "templates", "base.html.twig"), "{% block body %}{% endblock %}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Web frontend detected"));
    });

    it("detects web frontend from .blade.php files (Laravel)", () => {
      mkdirSync(join(tmpDir, "resources", "views"), { recursive: true });
      writeFileSync(join(tmpDir, "resources", "views", "app.blade.php"), "@yield('content')");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Web frontend detected"));
    });

    it("detects web frontend from .css files", () => {
      mkdirSync(join(tmpDir, "assets"));
      writeFileSync(join(tmpDir, "assets", "main.css"), "body { margin: 0 }");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Web frontend detected"));
    });

    it("does NOT detect web frontend from .php files alone", () => {
      mkdirSync(join(tmpDir, "src"));
      writeFileSync(join(tmpDir, "src", "index.php"), "<?php echo 'hello';");
      writeFileSync(join(tmpDir, "src", "controller.php"), "<?php class Controller {}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("No supported technologies"));
    });

    it("detects technologies from monorepo workspaces with --dry-run", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          devDependencies: { typescript: "^5" },
          workspaces: ["packages/*", "apps/*"],
        }),
      );
      writeFileSync(join(tmpDir, "tsconfig.json"), "{}");

      mkdirSync(join(tmpDir, "packages", "ui"), { recursive: true });
      writeFileSync(
        join(tmpDir, "packages", "ui", "package.json"),
        JSON.stringify({ dependencies: { react: "^19", tailwindcss: "^4" } }),
      );

      mkdirSync(join(tmpDir, "apps", "web"), { recursive: true });
      writeFileSync(
        join(tmpDir, "apps", "web", "package.json"),
        JSON.stringify({ dependencies: { next: "^15" } }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("TypeScript"), "root tech detected");
      assert.ok(output.includes("React"), "workspace tech detected");
      assert.ok(output.includes("Next.js"), "workspace tech detected");
      assert.ok(output.includes("Tailwind"), "workspace tech detected");
      assert.ok(output.includes("nothing was installed"));
    });

    it("detects technologies from pnpm monorepo with --dry-run", () => {
      writeFileSync(join(tmpDir, "package.json"), JSON.stringify({}));
      writeFileSync(join(tmpDir, "pnpm-workspace.yaml"), "packages:\n  - packages/*\n");

      mkdirSync(join(tmpDir, "packages", "api"), { recursive: true });
      writeFileSync(
        join(tmpDir, "packages", "api", "package.json"),
        JSON.stringify({ dependencies: { express: "^4" } }),
      );
      writeFileSync(join(tmpDir, "package-lock.json"), "{}");

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Express"), "workspace tech detected via pnpm");
      assert.ok(output.includes("Node.js"));
    });

    it("adds web fundamentals when npm frontend is detected too", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { react: "^19", next: "^15" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("React"));
      assert.ok(output.includes("frontend-design"));
      assert.ok(output.includes("accessibility"));
      assert.ok(output.includes("seo"));
    });

    it("shows auto-detected agents in dry-run output", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { react: "^19" },
        }),
      );

      const output = run(["--dry-run"], tmpDir);

      assert.ok(output.includes("Agents:"));
      assert.ok(output.includes("universal"));
    });

    it("shows user-specified agents instead of auto-detected", () => {
      writeFileSync(
        join(tmpDir, "package.json"),
        JSON.stringify({
          dependencies: { react: "^19" },
        }),
      );

      const output = run(["--dry-run", "-a", "cursor"], tmpDir);

      assert.ok(output.includes("Agents: cursor"));
      assert.ok(!output.includes("universal"));
    });
  });
});
