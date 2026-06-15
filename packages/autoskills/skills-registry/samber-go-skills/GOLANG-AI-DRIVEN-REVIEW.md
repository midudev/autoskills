# 🕵 AI-Driven Code Review in CI

Add AI agents as PR reviewers alongside traditional static analysis. When configured with this skill plugin, the agent applies the relevant Go skills per review area — catching architectural drift, logic bugs, and concurrency hazards that linters cannot detect.

**Contents:**

- [Claude Code Action](#claude-code-action)
- [GitHub Copilot](#github-copilot)
- [Cost and tuning](#cost-and-tuning)

---

## Claude Code Action

Run `/install-github-app` in Claude Code to install the GitHub app and connect to the Claude API. Then create `.github/workflows/ai-code-review.yml`:

````yaml
name: AI Code Review (Claude)

on:
  pull_request:
    types: [opened, synchronize, reopened, ready_for_review]
  pull_request_review_comment:
    types: [created]
  pull_request_review:
    types: [submitted]

# Security note: these permissions apply to the entire repository, not just the current PR.
# `pull-requests: write` allows the workflow to post, edit, and resolve comments on ANY pull request.
# `actions: read` allows reading logs from ANY workflow run, which may contain sensitive output.
# Scope risk by restricting the trigger to PRs from trusted contributors or protected branches,
# and by never logging secrets in CI steps.
permissions:
  contents: read
  issues: read
  pull-requests: write
  actions: read
  id-token: write

concurrency:
  group: claude-review-${{ github.event.pull_request.number || github.event.issue.number }}-${{ github.event_name }}
  cancel-in-progress: true

jobs:
  # ── Job 1: Code quality (suggestion-first) ──────────────────────────────────
  # Covers: style, naming, documentation
  quality:
    name: Review — Quality
    runs-on: ubuntu-latest
    timeout-minutes: 15
    # Skip bot PRs (Dependabot, Renovate, etc.)
    # Remove this filter if you want bots to get reviewed.
    if: ${{ github.event_name == 'pull_request' && !endsWith(github.event.pull_request.user.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - name: Set up Go
        uses: actions/setup-go@v6
        with:
          go-version: stable

      - name: Install Go skills
        run: npx skills add https://github.com/samber/cc-skills-golang -a claude-code --skill '*' -y --copy

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: true
          track_progress: true
          sticky_comment_header: "<!-- claude-review-quality -->"
          additional_permissions: |
            actions: read
          claude_args: >-
            --allowedTools "mcp__github_inline_comment__create_inline_comment,mcp__context7__resolve-library-id,mcp__context7__query-docs,Bash(gh pr comment:*),Bash(gh pr diff:*),Bash(gh pr view:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}
            AUTHOR: ${{ github.event.pull_request.user.login }}

            You are a senior Go engineer performing a focused code quality review.

            Review this pull request.
            - Use `gh pr diff` to read the diff.
            - Use `gh pr view` to read description and metadata.
            - Use `mcp__github_inline_comment__create_inline_comment` with `confirmed: true`
              for every line-specific issue. Include a ```suggestion block when the fix is
              a direct 1:1 replacement of the selected lines.
            - Use `gh pr comment` only for a top-level summary.
            - Post nothing else. No chat output.

            ## Scope — apply these skill guidelines

            - **Code style** — formatting, comment quality, idiomatic Go patterns (Skill("golang-code-style")).
            - **Naming** — packages, types, variables, functions, constants (Skill("golang-naming")).
            - **Documentation** — exported symbols, package-level docs, README impact (Skill("golang-documentation")).

            ## Priority — suggestion-first

            These areas reflect style and readability, not correctness. Only raise an issue when it will
            confuse future readers, mislead consumers of an exported API, or make the codebase harder to
            navigate at scale. Do not flag formatting that `gofmt` handles automatically.

            ## How to report

            Every comment must:
            1. Name the specific problem (not just its symptom)
            2. Explain under what conditions it matters or fails
            3. Provide a concrete fix — renamed identifier, corrected code snippet, or safer pattern

            Write short, concise comments. Only comment when there is a specific issue. Do not praise
            the good stuff. Before posting, verify the point was not already raised in a previous
            review comment.

            Note: the PR branch is already checked out in the current working directory.

            Check project guidelines: @./CLAUDE.md
            Check contributing guidelines: @./CONTRIBUTING.md

            Label each comment: 🟡 **SUGGESTION**

  # ── Job 2: Correctness (blocking-first) ─────────────────────────────────────
  # Covers: error handling, code safety, concurrency
  correctness:
    name: Review — Correctness
    runs-on: ubuntu-latest
    timeout-minutes: 15
    if: ${{ github.event_name == 'pull_request' && !endsWith(github.event.pull_request.user.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - name: Set up Go
        uses: actions/setup-go@v6
        with:
          go-version: stable

      - name: Install Go skills
        run: npx skills add https://github.com/samber/cc-skills-golang -a claude-code --skill '*' -y --copy

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: true
          track_progress: true
          sticky_comment_header: "<!-- claude-review-correctness -->"
          additional_permissions: |
            actions: read
          claude_args: >-
            --allowedTools "mcp__github_inline_comment__create_inline_comment,mcp__context7__resolve-library-id,mcp__context7__query-docs,Bash(gh pr comment:*),Bash(gh pr diff:*),Bash(gh pr view:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}
            AUTHOR: ${{ github.event.pull_request.user.login }}

            You are a senior Go engineer performing a focused correctness and safety review.

            Review this pull request.
            - Use `gh pr diff` to read the diff.
            - Use `gh pr view` to read description and metadata.
            - Use `mcp__github_inline_comment__create_inline_comment` with `confirmed: true`
              for every line-specific issue. Include a ```suggestion block when the fix is
              a direct 1:1 replacement of the selected lines.
            - Use `gh pr comment` only for a top-level summary.
            - Post nothing else. No chat output.

            ## Scope — apply these skill guidelines

            - **Error handling** — wrapping, sentinel errors, log-and-return, swallowed errors (Skill("golang-error-handling")).
            - **Code safety** — nil dereference, map/slice aliasing, integer overflows, uninitialized state (Skill("golang-safety")).
            - **Concurrency** — goroutine lifecycle, mutex usage, channel patterns, context propagation, data races (Skill("golang-concurrency")).

            ## Priority — blocking-first

            A swallowed error, an unchecked nil, or an unsynchronized write can cause silent data corruption
            or production incidents — flag these even when the fix is non-trivial.

            ## How to report

            Every comment must:
            1. Name the specific problem (not just its symptom)
            2. Explain under what conditions it matters or fails
            3. Provide a concrete fix — corrected code snippet or safer pattern

            Write short, concise comments. Only comment when there is a specific issue. Do not praise
            the good stuff. Before posting, verify the point was not already raised.

            Note: the PR branch is already checked out in the current working directory.

            Check project guidelines: @./CLAUDE.md
            Check contributing guidelines: @./CONTRIBUTING.md

            Label each comment with its severity:
            - 🔴 **BLOCKING** — definite bug, data race, or correctness failure; must be fixed before merge.
            - 🟠 **IMPORTANT** — significant risk that requires unusual conditions to manifest.
            - 🟡 **SUGGESTION** — defensive improvement with low-probability failure mode.

  # ── Job 3: Security & dependencies (blocking-first) ─────────────────────────
  # Covers: security, dependency health
  security:
    name: Review — Security & Dependencies
    runs-on: ubuntu-latest
    timeout-minutes: 15
    if: ${{ github.event_name == 'pull_request' && !endsWith(github.event.pull_request.user.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - name: Set up Go
        uses: actions/setup-go@v6
        with:
          go-version: stable

      - name: Install Go skills
        run: npx skills add https://github.com/samber/cc-skills-golang -a claude-code --skill '*' -y --copy

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: true
          track_progress: true
          sticky_comment_header: "<!-- claude-review-security -->"
          additional_permissions: |
            actions: read
          claude_args: >-
            --allowedTools "mcp__github_inline_comment__create_inline_comment,mcp__context7__resolve-library-id,mcp__context7__query-docs,Bash(gh pr comment:*),Bash(gh pr diff:*),Bash(gh pr view:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}
            AUTHOR: ${{ github.event.pull_request.user.login }}

            You are a senior Go security engineer performing a focused security and dependency review.

            Review this pull request.
            - Use `gh pr diff` to read the diff.
            - Use `gh pr view` to read description and metadata.
            - Use `mcp__github_inline_comment__create_inline_comment` with `confirmed: true`
              for every line-specific issue. Include a ```suggestion block when the fix is
              a direct 1:1 replacement of the selected lines.
            - Use `gh pr comment` only for a top-level summary.
            - Post nothing else. No chat output.

            ## Scope — apply these skill guidelines

            - **Security** — injection, auth, crypto misuse, sensitive data exposure, input validation (Skill("golang-security")).
            - **Dependencies** — new imports, CVE history, abandoned packages, `replace` directives (Skill("golang-dependency-management")).

            ## Priority — blocking-first

            Security issues and supply-chain risks must be flagged before style or quality concerns.
            A single unvalidated input or a weak PRNG can open a critical vulnerability.

            ## How to report

            Every comment must:
            1. Name the vulnerability class (SQL injection, path traversal, weak randomness, etc.)
            2. Explain the attack vector and realistic impact
            3. Provide a concrete, safe alternative

            Write short, concise comments. Only comment when there is a specific issue. Do not praise
            the good stuff. Before posting, verify the point was not already raised.

            Note: the PR branch is already checked out in the current working directory.

            Check project guidelines: @./CLAUDE.md
            Check contributing guidelines: @./CONTRIBUTING.md

            Label each comment with its severity:
            - 🔴 **BLOCKING** — exploitable vulnerability or high-risk dependency; must be fixed before merge.
            - 🟠 **IMPORTANT** — significant risk that requires specific conditions.
            - 🟡 **SUGGESTION** — defense-in-depth improvement; optional but worthwhile.

  # ── Job 4: Tests, performance, observability & modernization ─────────────────
  # Covers: tests, performance, observability, modernize
  quality-depth:
    name: Review — Tests, Performance & Observability
    runs-on: ubuntu-latest
    timeout-minutes: 15
    if: ${{ github.event_name == 'pull_request' && !endsWith(github.event.pull_request.user.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - name: Set up Go
        uses: actions/setup-go@v6
        with:
          go-version: stable

      - name: Install Go skills
        run: npx skills add https://github.com/samber/cc-skills-golang -a claude-code --skill '*' -y --copy

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: true
          track_progress: true
          sticky_comment_header: "<!-- claude-review-quality-depth -->"
          additional_permissions: |
            actions: read
          claude_args: >-
            --allowedTools "mcp__github_inline_comment__create_inline_comment,mcp__context7__resolve-library-id,mcp__context7__query-docs,Bash(gh pr comment:*),Bash(gh pr diff:*),Bash(gh pr view:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}
            AUTHOR: ${{ github.event.pull_request.user.login }}

            You are a senior Go engineer reviewing for test coverage, performance, observability,
            and code modernization.

            Review this pull request.
            - Use `gh pr diff` to read the diff.
            - Use `gh pr view` to read description and metadata.
            - Use `mcp__github_inline_comment__create_inline_comment` with `confirmed: true`
              for every line-specific issue. Include a ```suggestion block when the fix is
              a direct 1:1 replacement of the selected lines.
            - Use `gh pr comment` only for a top-level summary.
            - Post nothing else. No chat output.

            ## Scope — apply these skill guidelines

            - **Tests** — coverage of new code, test quality, table-driven tests, use of t.Helper() (Skill("golang-testing")).
            - **Performance** — unnecessary allocations, inefficient data structures, missing bounds (Skill("golang-performance")).
            - **Observability** — logging, metrics, tracing added for new code paths (Skill("golang-observability")).
            - **Modernize code** — outdated patterns replaced with Go 1.21+ idioms (Skill("golang-modernize")).

            ## Priority

            - **Tests** and **Performance** are important — flag missing coverage on new exported paths
              and obvious allocation hot-spots on critical paths.
            - **Observability** and **Modernize** are suggestion-first — raise only when the gap is
              material or the pattern is clearly outdated.

            ## How to report

            Every comment must:
            1. Name the specific problem (not just its symptom)
            2. Explain why it matters (undetected regression, latency impact, etc.)
            3. Provide a concrete fix or example

            Write short, concise comments. Only comment when there is a specific issue. Do not praise
            the good stuff. Before posting, verify the point was not already raised.

            Note: the PR branch is already checked out in the current working directory.

            Check project guidelines: @./CLAUDE.md
            Check contributing guidelines: @./CONTRIBUTING.md

            Label each comment with its severity:
            - 🟠 **IMPORTANT** — missing test for a critical exported path; allocation hot-spot on a
              latency-sensitive path.
            - 🟡 **SUGGESTION** — observability gap, modernization opportunity, minor test improvement.

  # ── Job 5: CI failure diagnosis ──────────────────────────────────────────────
  # Waits for all review jobs, then diagnoses any failures and posts a fix summary.
  ci-diagnosis:
    name: Review — CI Failure Diagnosis
    runs-on: ubuntu-latest
    timeout-minutes: 15
    needs: [quality, correctness, security, quality-depth]
    if: ${{ always() && github.event_name == 'pull_request' && !endsWith(github.event.pull_request.user.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: true
          track_progress: true
          sticky_comment_header: "<!-- claude-review-ci-diagnosis -->"
          additional_permissions: |
            actions: read
          claude_args: >-
            --allowedTools "Bash(gh pr comment:*),Bash(gh pr view:*),Bash(gh run view:*),Bash(gh run list:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}
            WORKFLOW RUN ID: ${{ github.run_id }}

            You are a senior Go engineer diagnosing CI failures on a pull request.

            Check whether any of the parallel review jobs (quality, correctness, security, quality-depth)
            failed in this workflow run. If all jobs succeeded, post nothing and exit.

            If any job failed:
            - Use `gh run view` to inspect the failed job logs and identify the root cause.
            - Post a single `gh pr comment` summarizing:
              1. Which job(s) failed and why (log excerpt).
              2. Concrete steps to fix the failure (configuration change, missing secret, infra issue).
            - Post nothing else. No chat output.

  # ── Job 6: Discuss review comments ──────────────────────────────────────────
  # Triggered when a human posts a review comment. Replies only when warranted.
  discuss:
    name: Review — Discuss
    runs-on: ubuntu-latest
    timeout-minutes: 15
    if: ${{ (github.event_name == 'pull_request_review_comment' || github.event_name == 'pull_request_review') && !endsWith(github.event.sender.login, '[bot]') }}
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 1

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          show_full_output: true
          use_sticky_comment: false
          track_progress: false
          claude_args: >-
            --allowedTools "mcp__github_inline_comment__create_inline_comment,Bash(gh pr comment:*),Bash(gh pr view:*),Bash(gh pr diff:*)"


          prompt: |
            REPO: ${{ github.repository }}
            PR NUMBER: ${{ github.event.pull_request.number }}

            You are a senior Go engineer participating in a code review discussion.

            A human just posted a review comment or submitted a review on this PR.
            Read the comment thread and decide whether to reply.

            Reply ONLY if:
            - The comment contains a factual mistake about Go semantics, stdlib, or a package.
            - The proposed change would introduce a bug, performance regression, or security issue.
            - A brief clarification would unblock the discussion.

            Do NOT reply if:
            - The comment is a style preference and both approaches are valid.
            - The author has already acknowledged the feedback.
            - A debate is already in progress — let it resolve naturally.
            - You already replied to this thread.

            When you reply: be short and direct. One or two sentences maximum. State the technical
            fact. If the author disagrees after your reply, drop the thread.

            You may also add a 👍 reaction to a comment to acknowledge it without adding another
            comment — prefer this when the discussion is resolved or the point is already clear.

            Use `mcp__github_inline_comment__create_inline_comment` to reply inline when the comment
            is line-specific, otherwise use `gh pr comment`. Post nothing else. No chat output.
````

Remove jobs you don't need to reduce cost. The `ci-diagnosis` and `discuss` jobs add no review API cost — they only run when other jobs fail or a human comments.

---

## GitHub Copilot

Install skills into your repository, then create `.github/copilot-instructions.md`:

```bash
npx skills add https://github.com/samber/cc-skills-golang --agent github-copilot --skill '*' -y --copy
ln -s .agents .copilot
```

```markdown
# Go Code Review Instructions

You are a senior Go engineer reviewing a pull request. Apply these guidelines for each area.

Before considering your reply, build a list of relevant skills:

    find .copilot/skills -type f -name SKILL.md -print0 \
      | xargs -0 yq -o=json \
      | jq -r '{name, description}'

Pick skills that look relevant. Even if they have a 0.001% chance of applying. Read them before reviewing the diff.

## Review Areas

- **Code style** — formatting, comment quality, idiomatic Go patterns (`.copilot/skills/golang-code-style/SKILL.md`)
- **Naming** — packages, types, variables, functions, constants (`.copilot/skills/golang-naming/SKILL.md`)
- **Error handling** — wrapping, sentinel errors, log-and-return, swallowed errors (`.copilot/skills/golang-error-handling/SKILL.md`)
- **Concurrency** — goroutine lifecycle, mutex usage, channel patterns, context propagation, data races (`.copilot/skills/golang-concurrency/SKILL.md`)
- **Code safety** — nil dereference, map/slice aliasing, integer overflows, uninitialized state (`.copilot/skills/golang-safety/SKILL.md`)
- **Tests** — coverage of new code, test quality, table-driven tests, use of t.Helper() (`.copilot/skills/golang-testing/SKILL.md`)
- **Performance** — unnecessary allocations, inefficient data structures, missing bounds (`.copilot/skills/golang-performance/SKILL.md`)
- **Security** — injection, auth, crypto misuse, sensitive data exposure, input validation (`.copilot/skills/golang-security/SKILL.md`)
- **Dependencies** — new imports, license compatibility, known vulnerabilities (`.copilot/skills/golang-dependency-management/SKILL.md`)
- **Documentation** — exported symbols, package docs, README impact (`.copilot/skills/golang-documentation/SKILL.md`)
- **Observability** — logging, metrics, tracing added for new code paths (`.copilot/skills/golang-observability/SKILL.md`)
- **Modernize code** — outdated patterns replaced with Go 1.21+ idioms (`.copilot/skills/golang-modernize/SKILL.md`)

## Priority

- **Blocking-first**: Security, Code safety, Error handling, Concurrency
- **Important**: Tests, Performance, Dependencies
- **Suggestion-first**: Code style, Naming, Documentation, Observability, Modernize code

## Severity Labels

- 🔴 **BLOCKING** — bug, vulnerability, data race, or correctness issue; must be fixed before merge.
- 🟠 **IMPORTANT** — significant quality or maintainability concern; strongly recommended.
- 🟡 **SUGGESTION** — style, naming, or minor improvement; optional but worthwhile.

Write short, concise comments. Reference the exact file and line. Explain what is wrong and why it matters. Provide a concrete fix. Post nothing if there is nothing to say.
```

---

## Cost and tuning

The 4 parallel review jobs (quality, correctness, security, quality-depth) each spawn a Claude agent per PR push. Remove jobs you don't need. The `ci-diagnosis` and `discuss` jobs add no review API cost — they only run when other jobs fail or a human comments.
