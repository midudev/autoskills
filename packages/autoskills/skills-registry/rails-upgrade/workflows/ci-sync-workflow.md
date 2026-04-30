# CI Sync Workflow

**When to load:** Step 5, immediately before declaring the upgrade complete or opening a PR. Also any time the user reports a red CI build after an upgrade PR is opened.

**Purpose:** Verify every CI configuration file in the repo matches the versions declared in the upgraded `Gemfile` / `Gemfile.lock`. CI drift (old Ruby version, old Rails matrix, stale service versions) is a frequent cause of red builds on the upgrade PR and is easy to miss because the local test suite passes.

This workflow is **mandatory**, not a reminder — produce a written CI sync report and do not open the PR until every CI file matches the Gemfile.

---

## Step 1: Enumerate CI files

Use Glob to find every CI configuration file in the repo. Check all of these locations — projects commonly have more than one:

- `.github/workflows/*.yml` and `.github/workflows/*.yaml` (GitHub Actions)
- `.circleci/config.yml` (CircleCI)
- `Jenkinsfile`, `Jenkinsfile.*`, `.jenkins/*` (Jenkins)
- `.gitlab-ci.yml` (GitLab CI)
- `appveyor.yml`, `.appveyor.yml` (AppVeyor)
- `.travis.yml` (Travis CI — rare today but still present on legacy apps)
- `azure-pipelines.yml` (Azure Pipelines)
- `bitbucket-pipelines.yml` (Bitbucket Pipelines)
- `buildkite/*.yml`, `.buildkite/*.yml` (Buildkite)

If none are found:

- The app may rely on an external CI system (Heroku CI, Render, etc.) that this skill cannot inspect — flag this to the user and stop; the user has to verify CI themselves.
- The app may have no CI at all. Do **not** create one from scratch as part of the upgrade — the shape of a CI setup depends on the team's deploy pipeline and is out of scope here. Note it in the report (`No CI files found — skipping CI sync`) and continue with the rest of Step 5; do not block the upgrade on it. Adding CI is a separate decision the team should make outside the upgrade flow.

## Step 2: Read the Gemfile baseline

**First, identify the upgrade scope:** is this a Rails upgrade or a Ruby upgrade? Check what changed in the Gemfile / `Gemfile.next` compared to current `Gemfile.lock`. Only sync the dimension that actually changed — a Rails upgrade leaves the Ruby matrix alone; a Ruby upgrade leaves the Rails matrix alone. Touching the unchanged dimension adds noise and risks breaking a currently-green CI job.

Then record the versions CI should match. Only read the ones relevant to this upgrade (Ruby for a Ruby upgrade, Rails for a Rails upgrade):

- **Ruby version** — precedence: `Gemfile`'s `ruby "..."` line → current CI's Ruby → `.ruby-version`. The Gemfile is preferred because a `NextRails.next?` conditional makes both current and next Ruby explicit for the matrix.
- **Rails version constraint** — from `Gemfile` (`gem "rails", "~> X.Y.Z"`) and the resolved version in `Gemfile.lock`.
- **Next-Rails version** — if dual-boot is active, from `Gemfile.next.lock`.
- **Service versions** — default is to **replicate whatever the current CI already runs** (Postgres, Redis, MySQL, Elasticsearch, etc.). If CI is green today, those versions work. Only propose a bump when the upgrade explicitly requires it (e.g. the version guide or a bumped gem's changelog calls out a minimum). When in doubt, keep current CI service versions and note them in the report as `unchanged — matches current CI`.
- **Node / Yarn / bun version** — default to whatever the current CI uses. Only flag for change if the app's `package.json` engines, `.nvmrc`, or `.tool-versions` disagree with CI, or if the upgrade explicitly bumps the Node requirement.

## Step 3: Diff each CI file against the baseline

For each CI file, read it and check:

1. **Ruby version(s)** in the CI matrix, setup-ruby action, container image tag, or `rvm:` / `ruby:` key match the Gemfile baseline. For dual-boot, confirm both current Ruby AND (if applicable) next Ruby are present.
2. **Rails / BUNDLE_GEMFILE matrix** includes both `Gemfile` and `Gemfile.next` during dual-boot. After dual-boot cleanup, only `Gemfile`.
   - **If dual-boot is active but CI has no `Gemfile.next` matrix entry at all** (common when CI was set up before the upgrade started): this is a `DRIFT` finding. Extend the existing job matrix with a `BUNDLE_GEMFILE=Gemfile.next` entry (or duplicate the job and add the env var) so both versions run on every PR. Do NOT silently add it — show the user the proposed matrix diff and confirm before editing. Refer to the dual-boot skill's CI reference for platform-specific matrix patterns (GitHub Actions, CircleCI, etc.).
   - **If the CI file has no matrix concept at all** (single-job Jenkinsfile, simple Bitbucket pipeline): flag as `DRIFT — needs dual-boot wiring` and surface to the user rather than attempting an automatic rewrite; the shape of the fix depends on the pipeline.
3. **Service containers / images** (Postgres, Redis, MySQL, etc.) — default to leaving current CI service versions as-is. Only flag `DRIFT` if the upgrade explicitly requires a bump (called out in the version guide or a bumped gem's changelog). If a dual-boot job is being added, copy the services block from the current job rather than inventing new versions.
4. **Node / Yarn / bun** — keep the current CI value unless `package.json` engines / `.nvmrc` / `.tool-versions` disagree with it, or the upgrade explicitly bumps the Node requirement.
5. **Bundler version** pinned in CI (`bundler-cache: true` or `bundle install` step) is not older than `Gemfile.lock`'s `BUNDLED WITH`.
6. **Cache keys** that include Ruby or Rails version in the key string are updated, otherwise the cache will hit stale data and miss the new dependencies.
7. **Deprecated action versions** (e.g. `actions/checkout@v2`, `ruby/setup-ruby@v1` with an old Ruby) — optional to flag.

## Step 4: Produce the CI sync report

Emit a concise report. Only include CI files that were actually found in the repo — skip absent ones. One block per found file, plus a top-level verdict:

```
CI Sync Report
--------------
Gemfile baseline: Ruby 3.3.6, Rails 7.2.2, Node 20

.github/workflows/ci.yml
  Ruby matrix: [3.1, 3.2] ✗ (expected 3.3.6)
  Rails matrix: [Gemfile] (dual-boot removed — OK)
  Postgres service: 13 (unchanged — matches current CI)
  Verdict: DRIFT — fix before PR

Overall: 1 file needs changes. BLOCKING.
```

If the verdict is `DRIFT` for any file, do not mark Step 5 complete. Apply the edits, re-run the diff, and only proceed when the overall verdict is `OK`.

## Step 5: Apply fixes

Edit each drifting CI file directly. Prefer:

- **Reuse the existing matrix shape.** If a matrix is already defined (Ruby versions, Gemfile variants, service combinations), keep its structure and just update the values. Do not invent a new matrix layout when one exists.
- Bump matrix entries in place rather than adding new ones, unless the user explicitly wants to keep the old version running alongside.
- Only change service image tags when the upgrade explicitly requires it; otherwise preserve what the current CI runs.
- Remove `Gemfile.next` matrix entries only after the dual-boot cleanup step has run (coordinate with the dual-boot skill's cleanup contract).

After fixes, re-run Step 3 and regenerate the report. The report is part of the upgrade PR description when possible — it gives reviewers a clear audit trail.

---

## Common failure modes this workflow catches

- CI still running on the old Ruby patch after `.ruby-version` was bumped.
- Postgres / MySQL service container on a version the new Rails release dropped support for.
- Dual-boot removed locally but CI matrix still has `BUNDLE_GEMFILE=Gemfile.next` entries (builds fail because `Gemfile.next` no longer exists).
- Dual-boot set up locally but CI was never extended — the matrix still runs only the current `Gemfile`, so the next-Rails build never runs on PRs and breakages land unnoticed.
- GitHub Actions cache key pinned to old Rails version, causing phantom "works locally, fails in CI" bundle resolution mismatches.
- Node engine bumped in `package.json` but CI still using an older Node major — asset compilation fails.
