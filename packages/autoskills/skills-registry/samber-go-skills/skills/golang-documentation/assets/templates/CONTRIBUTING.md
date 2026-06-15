# Contributing to {project-name}

Thank you for your interest in contributing!

## Prerequisites

- Go {version} or later
- Make (optional but recommended)
- Docker (for integration tests only)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/{owner}/{repo}.git
cd {repo}

# Build
go build -o myapp ./cmd/main.go

# Run unit tests
go test -race ./...

# Run integration tests
go test -race -tags=integration -timeout=300s ./...

# Run linter
golangci-lint run --fix ./...
```

## Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Make your changes
4. Add tests for new functionality
5. Run `go test ./...` and `golangci-lint run`
6. Commit with a descriptive message
7. Push and open a Pull Request

## Code Guidelines

- Follow [Effective Go](https://go.dev/doc/effective_go)
- Add doc comments to all exported symbols
- Write table-driven tests
- Keep test coverage above {X}%

## Reporting Issues

Use [GitHub Issues](https://github.com/{owner}/{repo}/issues). Include:

- Go version (`go version`)
- OS and architecture
- Steps to reproduce
- Expected vs actual behavior
