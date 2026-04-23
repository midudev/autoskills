import { describe, it } from "node:test";
import { deepEqual, equal } from "node:assert/strict";
import { scanMarkdown } from "../markdown-scanner.ts";
import { SKILLS_MAP } from "../skills-map.ts";

describe("scanMarkdown — json fences", () => {
  it("detects tech from dependencies block", () => {
    const md = "```json\n{\"dependencies\":{\"react\":\"^19\"}}\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches.length, 1);
    equal(matches[0].techId, "react");
    equal(matches[0].source, "code-fence");
  });

  it("detects tech from devDependencies block", () => {
    const md = "```json\n{\"devDependencies\":{\"typescript\":\"^5\"}}\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches[0].techId, "typescript");
  });

  it("skips malformed JSON without throwing", () => {
    const md = "```json\n{\"dependencies\":{\"react\":^19}\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("returns [] for empty fence", () => {
    const md = "```json\n\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("returns [] for no-language fence", () => {
    const md = "```\n{\"dependencies\":{\"react\":\"^19\"}}\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });
});

describe("scanMarkdown — shell fences", () => {
  it("extracts packages from 'pnpm add'", () => {
    const md = "```bash\npnpm add react tailwindcss\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    const ids = matches.map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("handles npm install / yarn add / bun add / npm i", () => {
    for (const cmd of ["npm install react", "yarn add react", "bun add react", "npm i react"]) {
      const matches = scanMarkdown("```sh\n" + cmd + "\n```", SKILLS_MAP);
      equal(matches[0]?.techId, "react");
    }
  });

  it("accepts sh / shell / zsh as aliases for bash", () => {
    for (const lang of ["sh", "shell", "zsh"]) {
      const matches = scanMarkdown("```" + lang + "\npnpm add react\n```", SKILLS_MAP);
      equal(matches[0]?.techId, "react");
    }
  });

  it("rejects pseudo-command prefix (F-002 regression: requires word boundary)", () => {
    const md = "```bash\nxnpm install react\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("stops at shell operators when chaining commands (F-003 regression)", () => {
    const md = "```bash\nnpm install react && cd apps/web\n```";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId);
    deepEqual(ids, ["react"]);
  });

  it("stops at semicolon chain", () => {
    const md = "```bash\nnpm install react ; npm run build\n```";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId);
    deepEqual(ids, ["react"]);
  });
});

describe("scanMarkdown — yaml/toml/ruby fences", () => {
  it("detects flutter from a yaml fence containing 'flutter:'", () => {
    const md = "```yaml\nname: my_app\nflutter:\n  uses-material-design: true\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    const ids = matches.map(m => m.techId);
    equal(ids.includes("flutter"), true);
    equal(matches[0].source, "code-fence");
  });

  it("detects cloudflare-durable-objects from a toml fence containing 'durable_objects'", () => {
    const md = "```toml\nname = \"my-worker\"\n[durable_objects]\nbindings = []\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    const ids = matches.map(m => m.techId);
    equal(ids.includes("cloudflare-durable-objects"), true);
  });

  it("detects rails from a ruby fence with gem 'rails'", () => {
    const md = "```ruby\nsource 'https://rubygems.org'\ngem 'rails', '~> 7.1'\ngem 'pg'\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    const ids = matches.map(m => m.techId);
    equal(ids.includes("rails"), true);
    equal(ids.includes("postgres-ruby"), true);
  });

  it("returns [] for a no-language fence with YAML-looking content", () => {
    const md = "```\nflutter:\n  uses-material-design: true\n```";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });

  it("does not throw on an unterminated yaml fence", () => {
    const md = "```yaml\nflutter:\n  uses-material-design: true";
    // extractFences reads to EOF; the important thing is no exception is thrown
    const result = scanMarkdown(md, SKILLS_MAP);
    equal(Array.isArray(result), true);
  });
});

describe("scanMarkdown — stack headings", () => {
  it("detects bullets under 'Tech Stack' heading", () => {
    const md = "## Tech Stack\n\n- React\n- Tailwind CSS\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("accepts Stack | Dependencies | Built With | Technologies | Tecnologías", () => {
    for (const title of ["Stack", "Dependencies", "Built With", "Technologies", "Tecnologías"]) {
      const md = `## ${title}\n- React\n`;
      equal(scanMarkdown(md, SKILLS_MAP)[0]?.techId, "react");
    }
  });

  it("is case-insensitive", () => {
    equal(scanMarkdown("### TECH STACK\n- React\n", SKILLS_MAP)[0]?.techId, "react");
  });

  it("accepts h1, h2, h3 but not h4", () => {
    equal(scanMarkdown("#### Tech Stack\n- React\n", SKILLS_MAP).length, 0);
  });

  it("strips version numbers and parens from bullets", () => {
    equal(scanMarkdown("## Stack\n- React 19 (UI library)\n", SKILLS_MAP)[0]?.techId, "react");
  });

  it("skips version-only bullets", () => {
    deepEqual(scanMarkdown("## Stack\n- 19\n- 1.0\n", SKILLS_MAP), []);
  });

  it("matches via aliases (Next.js -> nextjs)", () => {
    equal(scanMarkdown("## Stack\n- Next.js\n", SKILLS_MAP)[0]?.techId, "nextjs");
  });

  it("does NOT match prose mid-paragraph", () => {
    const md = "# Intro\n\nOur tech stack includes React but we also use Vue.\n";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
  });
});
