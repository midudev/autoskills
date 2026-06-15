# Tooling Modernization

Beyond the Go language itself, suggest updating all non-functional developer tools that improve code quality or security for free. These are low-risk, high-value improvements: CI actions/plugins, linters (e.g. golangci-lint), SAST tools (e.g. gosec, Snyk, Semgrep), vulnerability scanners (e.g. govulncheck, Trivy), Docker base images, test coverage reporters, dependency management bots (e.g. Renovate, Dependabot), etc.

## Update to the latest Go version

Compare the project's `go` directive in `go.mod` against the latest stable release and suggest updating it and the `toolchain` directive if present. Each Go release brings performance improvements, security fixes, and new features.

```bash
# Check current version
go version

# Update go.mod to target a newer version
go mod edit -go=1.26

# Update toolchain
go get toolchain@latest
```

## golangci-lint v2 _(golangci-lint v2.0.0+, March 2025)_

Upgrade to golangci-lint v2. **Migration**: Run `golangci-lint migrate` to convert v1 config to v2. See the `samber/cc-skills-golang@golang-lint` skill for the recommended configuration.

## govulncheck _(works best with Go 1.22+)_

`govulncheck` scans Go code for known vulnerabilities using the Go vulnerability database at `vuln.go.dev`. It analyzes call graphs to report only **reachable** vulnerabilities.

**Note**: The vulnerability database tracks Go standard library issues starting from Go 1.18. Third-party module vulnerabilities are tracked regardless of Go version. For best results (better call graph analysis), use Go 1.22+.

```bash
# Pin in the module (Go 1.24+)
go get -tool golang.org/x/vuln/cmd/govulncheck@latest

# Scan source code
go tool govulncheck ./...

# Scan a compiled binary
go tool govulncheck -mode=binary ./myapp
```

## Profile-Guided Optimization (PGO) _(Go 1.21+)_

PGO is generally available since Go 1.21, providing 2-14% performance improvements:

```bash
# 1. Build and run with CPU profiling
go test -cpuprofile=default.pgo -bench=. ./...

# 2. Place default.pgo in the main package directory
# 3. Rebuild — PGO is applied automatically
go build ./...
```

Go 1.22+ expanded PGO to devirtualize more interface calls. Go 1.23+ reduced PGO build time overhead to single digits.

## AI-Driven Code Review in CI

Add an AI agent as a PR reviewer alongside traditional static analysis. When configured with this skill plugin, the agent loads the relevant Go skills — `golang-security` for security review, `golang-concurrency` for concurrency issues, `golang-error-handling` for error handling, and so on — giving it the same expertise as a senior Go reviewer. This catches architectural drift, logic bugs, missing context in errors, and subtle concurrency hazards that linters cannot detect.

See the `samber/cc-skills-golang@golang-continuous-integration` skill for ready-to-use GitHub Actions assets for both Claude Code and GitHub Copilot.
