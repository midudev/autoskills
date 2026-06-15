# Project Documentation

→ See `samber/cc-skills-golang@golang-continuous-integration` skill for automating changelog generation and release workflows.

## README.md

A LICENSE file MUST exist in every project. A README is the front page of your project. Make it simple, clear, and scannable. A copy-paste template with empty sections is available at [templates/README.md](./templates/README.md).

### Section Order

Follow this exact order (all sections are in the template):

1. **Title** — project name as `# heading`
2. **Badges** — shields.io pictograms (Go version, license, CI, coverage, Go Report Card)
3. **Summary** — 1-2 sentences explaining what the project does
4. **Demo** — code snippet (libraries), GIF/video (CLIs), or screenshot (web UIs)
5. **Getting Started** — installation + minimal working example
6. **Features / Specification** — the longest section, organized by feature area
7. **Contributing** — link to CONTRIBUTING.md or inline if very short
8. **License** — license name + link

The template includes commented-out sections for applications (binary download table, Docker, Homebrew) that you can uncomment as needed.

---

## CONTRIBUTING.md

The goal: a new contributor should be able to clone the repo, make a change, and run the tests **in under 10 minutes**. If your project takes longer, add tooling to fix that.

Copy the template from [templates/CONTRIBUTING.md](./templates/CONTRIBUTING.md).

### The 10-Minute Rule

If setup takes more than 10 minutes, add these improvements:

| Problem | Solution |
| --- | --- |
| Complex build steps | Add a `Makefile` with `make build`, `make test`, `make lint` |
| External service dependencies | Add `docker-compose.yml` for local dev |
| Inconsistent dev environments | Add `.devcontainer/` for VS Code devcontainers |
| Slow test suite | Separate unit tests (fast) from integration tests (build tags) |
| Missing documentation | Add `make help` that lists available targets |

---

## Changelog

CHANGELOG MUST be updated for every release. Track notable changes for each release. Use [Keep a Changelog](https://keepachangelog.com/) format. Copy the template from [templates/CHANGELOG.md](./templates/CHANGELOG.md).

### Format

```markdown
## [1.2.0] - 2026-03-08

### Added

- New `WithTimeout` option for client configuration

### Changed

- Improved retry logic to use exponential backoff

### Fixed

- Race condition in connection pool under heavy load

### Deprecated

- `SetTimeout()` method — use `WithTimeout()` option instead

[1.2.0]: https://github.com/{owner}/{repo}/compare/v1.1.0...v1.2.0
```

### Change Categories

- **Added** — new features
- **Changed** — changes in existing functionality
- **Deprecated** — features that will be removed
- **Removed** — removed features
- **Fixed** — bug fixes
- **Security** — vulnerability fixes

### GitHub Releases as Alternative

For simpler projects, GitHub Releases can replace a CHANGELOG file. GoReleaser auto-generates release notes from git commits.

---

## Distribution

**YOU MUST offer multiple installation paths** (binaries, containers, APT/Homebrew/... package managers, source). Because:

- Each installation method eliminates friction for a different user segment
- Users adopt tools that fit their workflow, not tools that force workflow changes
- A single installation path is a hidden tax on adoption—DevOps engineers skip tools requiring npm, macOS developers skip tools without Homebrew
- Tools users _want to_ use spread faster than tools users _have to_ accommodate

### Dockerfile Best Practices

Use multi-stage builds with a minimal final image:

```dockerfile
# Build stage
FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/binary ./cmd/server

# Final stage
FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=builder /app/binary /binary
ENTRYPOINT ["/binary"]
```
