import { describe, it } from "node:test";
import { deepEqual, equal, ok } from "node:assert/strict";
import { scanMarkdown, normalizeHeadingTitle } from "../markdown-scanner.ts";
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

  it("accepts numbered heading (## 2. Tech Stack)", () => {
    const md = "## 2. Tech Stack\n\n- React\n- Tailwind CSS\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });
  it("accepts emoji-prefixed heading (## 🚀 Tech Stack)", () => {
    equal(scanMarkdown("## 🚀 Tech Stack\n- React\n", SKILLS_MAP)[0]?.techId, "react");
  });
  it("accepts bold-wrapped heading (## **Dependencies**)", () => {
    equal(scanMarkdown("## **Dependencies**\n- React\n", SKILLS_MAP)[0]?.techId, "react");
  });
  it("accepts bracketed heading (## [Stack])", () => {
    equal(scanMarkdown("## [Stack]\n- React\n", SKILLS_MAP)[0]?.techId, "react");
  });
  it("accepts trailing-colon heading (## Tech Stack:)", () => {
    equal(scanMarkdown("## Tech Stack:\n- React\n", SKILLS_MAP)[0]?.techId, "react");
  });
  it("rejects prose narrative heading (## Why we picked our Stack)", () => {
    deepEqual(scanMarkdown("## Why we picked our Stack\n- React\n", SKILLS_MAP), []);
  });
  it("still rejects h4+ after normalization (#### 1. Tech Stack)", () => {
    deepEqual(scanMarkdown("#### 1. Tech Stack\n- React\n", SKILLS_MAP), []);
  });

  it("accepts numbered bullets with dot (1. Astro)", () => {
    const md = "## Tech Stack\n\n1. React\n2. Tailwind CSS\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });
  it("accepts numbered bullets with paren (1) Astro)", () => {
    const md = "## Stack\n1) React\n2) Tailwind CSS\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("accepts comma-separated inline list on one line", () => {
    const md = "## Tech Stack\n\nReact, Tailwind CSS, TypeScript\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind", "typescript"].sort());
  });
  it("accepts comma-separated inline mixed with bullets", () => {
    const md = "## Tech Stack\n\n- React\nTailwind CSS, TypeScript\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind", "typescript"].sort());
  });
  it("does not accept comma text outside a stack heading", () => {
    deepEqual(scanMarkdown("Intro\n\nReact, Vue, Svelte — pick one.\n", SKILLS_MAP), []);
  });

  it("accepts simple 2-column table (Tech | Version)", () => {
    const md =
      "## Tech Stack\n\n" +
      "| Tech | Version |\n" +
      "|------|---------|\n" +
      "| React | 19 |\n" +
      "| Tailwind CSS | 4 |\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("picks 'Framework' column from 3-col table via header heuristic", () => {
    const md =
      "## Tech Stack\n\n" +
      "| Category | Framework | Notes |\n" +
      "|----------|-----------|-------|\n" +
      "| UI | React | renderer |\n" +
      "| Styling | Tailwind CSS | utility |\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("falls back to first column when no heuristic keyword in header", () => {
    const md =
      "## Stack\n\n" +
      "| Name | Purpose |\n" +
      "|------|---------|\n" +
      "| React | UI |\n";
    equal(scanMarkdown(md, SKILLS_MAP)[0]?.techId, "react");
  });

  it("normalizes cell content: links, bold, backticks", () => {
    const md =
      "## Tech Stack\n\n" +
      "| Tech |\n" +
      "|------|\n" +
      "| [React](https://react.dev) |\n" +
      "| **Tailwind CSS** |\n" +
      "| `typescript` |\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind", "typescript"].sort());
  });

  it("splits comma-separated cell (| React, Tailwind |)", () => {
    const md =
      "## Tech Stack\n\n" +
      "| Tech |\n" +
      "|------|\n" +
      "| React, Tailwind CSS |\n";
    const ids = scanMarkdown(md, SKILLS_MAP).map(m => m.techId).sort();
    deepEqual(ids, ["react", "tailwind"].sort());
  });

  it("ignores table outside stack heading", () => {
    const md =
      "## Overview\n\n" +
      "| Tech | Version |\n" +
      "|------|---------|\n" +
      "| React | 19 |\n";
    deepEqual(scanMarkdown(md, SKILLS_MAP), []);
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

describe("scanMarkdown — dedupe and edge cases", () => {
  it("one match when tech appears in both fence and heading (source = stack-heading, headings scanned first)", () => {
    const md = "## Stack\n- React\n\n```bash\npnpm add react\n```\n";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches.length, 1);
    equal(matches[0].techId, "react");
    equal(matches[0].source, "stack-heading");
  });

  it("returns [] for empty input", () => {
    deepEqual(scanMarkdown("", SKILLS_MAP), []);
  });

  it("does not throw on 100KB input and returns no matches for non-tech prose", () => {
    const big = "lorem ipsum ".repeat(10000);
    const matches = scanMarkdown(big, SKILLS_MAP);
    equal(matches.length, 0);
  });

  it("does not throw on unterminated fence", () => {
    const md = "```json\n{\"dependencies\":{\"react\":\"^19\"}}\n";
    const matches = scanMarkdown(md, SKILLS_MAP);
    ok(Array.isArray(matches));
  });

  it("deduplicates same tech appearing in two separate fences", () => {
    const md = "```bash\npnpm add react\n```\n```json\n{\"dependencies\":{\"react\":\"^19\"}}\n```";
    const matches = scanMarkdown(md, SKILLS_MAP);
    equal(matches.length, 1);
    equal(matches[0].techId, "react");
  });
});

describe("normalizeHeadingTitle", () => {
  it("returns plain title unchanged", () => {
    equal(normalizeHeadingTitle("Tech Stack"), "Tech Stack");
  });
  it("strips leading numbering with dot (2. Tech Stack)", () => {
    equal(normalizeHeadingTitle("2. Tech Stack"), "Tech Stack");
  });
  it("strips leading numbering with paren (1) Stack)", () => {
    equal(normalizeHeadingTitle("1) Stack"), "Stack");
  });
  it("strips leading numbering with dash (3 - Dependencies)", () => {
    equal(normalizeHeadingTitle("3 - Dependencies"), "Dependencies");
  });
  it("strips leading emoji prefix", () => {
    equal(normalizeHeadingTitle("🚀 Tech Stack"), "Tech Stack");
  });
  it("strips trailing emoji", () => {
    equal(normalizeHeadingTitle("Tech Stack 🚀"), "Tech Stack");
  });
  it("strips trailing colon", () => {
    equal(normalizeHeadingTitle("Tech Stack:"), "Tech Stack");
  });
  it("unwraps bold **Tech Stack**", () => {
    equal(normalizeHeadingTitle("**Tech Stack**"), "Tech Stack");
  });
  it("unwraps italic *Tech Stack*", () => {
    equal(normalizeHeadingTitle("*Tech Stack*"), "Tech Stack");
  });
  it("unwraps underscore italic _Dependencies_", () => {
    equal(normalizeHeadingTitle("_Dependencies_"), "Dependencies");
  });
  it("unwraps double-underscore __Dependencies__", () => {
    equal(normalizeHeadingTitle("__Dependencies__"), "Dependencies");
  });
  it("unwraps brackets [Tech Stack]", () => {
    equal(normalizeHeadingTitle("[Tech Stack]"), "Tech Stack");
  });
  it("strips trailing paren annotation", () => {
    equal(normalizeHeadingTitle("Tech Stack (frontend)"), "Tech Stack");
  });
  it("combines numbering + bold + colon", () => {
    equal(normalizeHeadingTitle("2. **Tech Stack**:"), "Tech Stack");
  });
});
