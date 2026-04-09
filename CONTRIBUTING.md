# Contributing to AutoSkills

Thank you for contributing to AutoSkills. This guide covers the full workflow, from finding an issue to opening a clean PR.

## 1. Find or open an issue first

Before writing code, [open an issue](../../issues) or find an existing one.

Describe what you want to add or fix and why. Maintainers use issues to coordinate work, avoid duplicates, and give early feedback before you invest time in a PR.

## 2. Fork and create a branch

[Fork AutoSkills](../../fork), then create a descriptive branch:

```sh
git checkout -b 325-add-tailwind-detection
git checkout -b fix/ruby-gems-empty-array
git checkout -b docs/improve-contributing-guide
```

## 3. Make your changes

Make the smallest change that fully solves the problem. Ask for help in the PR — you don't need to wait until it's perfect.

## 4. Follow the style

- Lint and format before pushing
- Add or update tests for every behavior change
- Make sure all tests pass locally before opening a PR

## 5. Open a pull request

Sync with main before pushing:

```sh
git remote add upstream https://github.com/midudev/autoskills.git
git checkout main
git pull upstream main
git checkout your-branch
git rebase main
git push --set-upstream origin your-branch
```

Keep the PR title short and in the imperative mood: `feat: add Bun detection`, `fix: empty gems array in Ruby entry`, `test: validate skills map entries`.

## 6. Keep your PR up to date

When a maintainer asks you to rebase, the base branch has moved. Update your branch:

```sh
git fetch upstream
git rebase upstream/main
git push --force-with-lease
```

## 7. AutoSkills-specific contributions

Most AutoSkills changes fall into one of these:

- Add detection for a new technology
- Fix a detection edge case
- Add or update skills for an existing technology
- Add a combo that provides value beyond individual detections

**Keep each PR to one concern.** One technology, one fix, one combo. Mixing unrelated changes slows review.

---

### Adding a technology

Add one entry to `SKILLS_MAP` in `packages/autoskills/skills-map.mjs`:

```js
{
  id: "bun",
  name: "Bun",
  detect: {
    configFiles: ["bun.lockb", "bunfig.toml"],
  },
  skills: [
    "owner/repo/bun-best-practices",
  ],
}
```

Every entry requires these four fields:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `string` | Stable, unique, lowercase. Use `-` as separator. |
| `name` | `string` | User-facing display name. |
| `detect` | `object` | At least one detection signal (see below). |
| `skills` | `string[]` | One or more skill references. |

#### Detection signals — choose the simplest one that works

Use signals in this order of preference:

**1. `packages`** — match npm/pip/cargo package names

```js
detect: {
  packages: ["react", "react-dom"],
}
```

**2. `configFiles`** — match specific filenames in the project root

```js
detect: {
  configFiles: ["next.config.js", "next.config.mjs", "next.config.ts"],
}
```

**3. `gems`** — match Ruby gem names

```js
detect: {
  gems: ["rails", "sinatra"],
}
```

**4. `packagePatterns`** — match packages by RegExp when a prefix covers multiple packages

```js
detect: {
  packagePatterns: [/^@aws-sdk\//, /^aws-cdk/],
}
```

**5. `configFileContent`** — search file contents when names and packages are not enough

```js
// Standard form — search inside specific files
detect: {
  configFileContent: {
    files: ["wrangler.json", "wrangler.toml"],
    patterns: ["durable_objects"],
  },
}

// Gradle form — let the scanner find build.gradle files automatically
detect: {
  configFileContent: {
    scanGradleLayout: true,
    patterns: ["com.android.application", "com.android.library"],
  },
}
```

You can combine signals — the entry matches when any signal is found:

```js
detect: {
  packages: ["tailwindcss"],
  configFiles: ["tailwind.config.js", "tailwind.config.ts"],
}
```

#### Skill reference format

```
owner/repo/skill-name          # GitHub-hosted skill
https://example.com/skill      # URL-based skill
```

Real example: `"vercel-labs/agent-skills/vercel-react-best-practices"`

Verify that the referenced skill actually exists before opening a PR.

#### What the validator catches

Run the tests and you'll see exactly what needs fixing:

```
✗ [my-tech] detect.packages is empty — add at least one package name (e.g. ["react", "react-dom"])
✗ [my-tech] skill "my-best-practices" is not a valid reference — use "owner/repo/skill-name" or an https:// URL
✗ [my-tech] detect has no signals — define at least one of: packages, configFiles, gems, packagePatterns, or configFileContent
```

Common mistakes:

```js
// ✗ packages is empty
detect: { packages: [] }

// ✗ skill ref is missing owner/repo
skills: ["react-best-practices"]

// ✗ packagePattern is a string, not a RegExp
detect: { packagePatterns: ["^@aws-sdk/"] }

// ✓ correct
detect: { packages: ["react"] }
skills: ["vercel-labs/agent-skills/vercel-react-best-practices"]
detect: { packagePatterns: [/^@aws-sdk\//] }
```

---

### Adding a combo

Add one entry to `COMBO_SKILLS_MAP` in `packages/autoskills/skills-map.mjs`:

```js
{
  id: "nextjs-supabase",
  name: "Next.js + Supabase",
  requires: ["nextjs", "supabase"],
  skills: [
    "supabase/agent-skills/supabase-postgres-best-practices",
  ],
}
```

Add a combo only when it provides skills that are not already covered by the individual technology entries. A combo that just duplicates standalone skills adds noise.

| Field | Requirement |
|-------|-------------|
| `id` | Unique, lowercase, hyphen-separated. |
| `name` | User-facing, e.g. `"Next.js + Supabase"`. |
| `requires` | Array of two or more existing `SKILLS_MAP` ids. |
| `skills` | At least one valid skill reference. |

If you reference an id that doesn't exist in `SKILLS_MAP`, the test fails:

```
✗ [nextjs-supabase] requires "supbase" which is not in SKILLS_MAP — fix the typo or add the technology first
```

---

### Run the tests

```sh
cd packages/autoskills
node --test 'tests/*.test.mjs'
```

Expected output when everything is correct:

```
✔ SKILLS_MAP validation › has unique technology ids
✔ SKILLS_MAP validation › validates every technology entry shape
✔ COMBO_SKILLS_MAP validation › has unique combo ids
✔ COMBO_SKILLS_MAP validation › validates every combo entry shape
```

---

### PR checklists

#### Adding a technology

- [ ] One entry added to `SKILLS_MAP` in `packages/autoskills/skills-map.mjs`
- [ ] Detection uses the simplest reliable signal
- [ ] All skill refs follow the `owner/repo/skill-name` or `https://` format
- [ ] Tests pass locally (`node --test 'tests/*.test.mjs'`)
- [ ] PR title uses the imperative mood: `feat: add Bun detection`

#### Adding a combo

- [ ] One entry added to `COMBO_SKILLS_MAP` in `packages/autoskills/skills-map.mjs`
- [ ] `requires` contains at least two ids that exist in `SKILLS_MAP`
- [ ] The combo adds skills not already covered by the individual entries
- [ ] Tests pass locally
- [ ] PR title uses the imperative mood: `feat: add Next.js + Supabase combo`

#### Fixing detection

- [ ] Existing entry updated in `packages/autoskills/skills-map.mjs`
- [ ] A test in `packages/autoskills/tests/detect.test.mjs` covers the fixed case
- [ ] Tests pass locally
- [ ] PR title describes the fix: `fix: detect Tailwind from @tailwindcss/vite`

---

Thank you for contributing!
