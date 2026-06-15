# Automated Dependency Updates

Automate minor/patch dependency updates to reduce maintenance burden and stay current with security fixes. This requires a solid CI pipeline — tests and linting must pass before any auto-merge.

## Dependabot vs Renovate

| Feature | Dependabot | Renovate |
| --- | --- | --- |
| Platform | GitHub only | GitHub, GitLab, Bitbucket, self-hosted |
| `go mod tidy` | Automatic | Opt-in (`gomodTidy`) |
| Automerge | Separate workflow | Native support |
| Grouping | Pattern-based | More flexible rules |
| Monorepo support | Basic | Go workspaces aware |
| Regex managers | No | Yes (Dockerfiles, Makefiles, etc) |

**Renovate is generally more mature and configurable.** Dependabot is simpler to set up for GitHub-only projects.

## Auto-Merge Strategy

- **Minor and patch updates**: Auto-merge only after CI passes (tests + lint + govulncheck) and the package is low-risk for the project
- **Major updates**: Create PR for manual review (may contain breaking changes)
- **Security updates**: Auto-merge regardless of version bump type

For workflow configuration files (dependabot.yml, renovate.json, auto-merge workflows), see the `samber/cc-skills-golang@golang-continuous-integration` skill.

## Update Verification

Before committing a dependency update:

0. Changelogs may suggest improvements applicable to the project.
1. Run `go test ./...` and `go build ./...`
2. Scan with `govulncheck ./...` or `go tool govulncheck ./...`
3. Release notes/changelogs for libraries that affect persistence, serialization, networking, authentication, authorization, cryptography, or public APIs may contain important information about breaking changes
4. Major version upgrades may contain breaking changes — the package's changelog documents them
5. New APIs or patterns introduced in the updated version may offer improvements worth considering
