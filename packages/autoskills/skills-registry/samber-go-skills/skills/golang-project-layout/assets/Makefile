# Variables
BINARY_NAME=myapp
GO=go
GOFLAGS=-v

# Build variables
VERSION?=$(shell git describe --tags --always --dirty)
LDFLAGS=-ldflags "-X main.Version=$(VERSION)"

.PHONY: all build clean test lint run install help
.PHONY: benchmark lint-fix outdated weight audit
.PHONY: watch-test watch-build watch-run

all: clean lint test build

## build: Build the application
build:
	@echo "Building $(BINARY_NAME)..."
	$(GO) build $(GOFLAGS) $(LDFLAGS) -o bin/$(BINARY_NAME) ./cmd/server

## build-all: Build all binaries in cmd/
build-all:
	@echo "Building all binaries..."
	$(GO) build $(GOFLAGS) $(LDFLAGS) -o bin/ ./cmd/...

## clean: Clean build artifacts
clean:
	@echo "Cleaning..."
	rm -rf bin/
	rm -f coverage.out

## test: Run all tests
test:
	@echo "Running tests..."
	$(GO) test -v -race -coverprofile=coverage.out ./...
	$(GO) tool cover -html=coverage.out -o coverage.html

## test-short: Run tests without long-running ones
test-short:
	$(GO) test -v -short ./...

## benchmark: Run benchmarks
benchmark:
	@echo "Running benchmarks..."
	$(GO) test -bench=. -benchmem ./...

## lint: Run linter
lint:
	@echo "Running linter..."
	golangci-lint run ./...

## lint-fix: Run linter and auto-fix issues
lint-fix:
	@echo "Running linter with auto-fix..."
	golangci-lint run --fix ./...

## fmt: Format code
fmt:
	$(GO) fmt ./...
	$(GO) vet ./...

## outdated: Check for outdated dependencies
outdated:
	@echo "Checking for outdated dependencies..."
	go list -u -m -json all | go-mod-outdated -update -direct

## weight: Analyze package dependencies
weight:
	@echo "Analyzing package weight..."
	goweight

## audit: Audit dependencies for security vulnerabilities
audit:
	@echo "Auditing dependencies..."
	govulncheck ./...

## run: Build and run the application
run: build
	@echo "Running $(BINARY_NAME)..."
	./bin/$(BINARY_NAME)

## install: Install dependencies
install:
	$(GO) mod download
	$(GO) mod tidy

## deps-update: Update dependencies (patch only for safety)
deps-update:
	$(GO) get -u=patch ./...
	$(GO) mod tidy

## watch-test: Run tests on file changes (requires air)
watch-test:
	@echo "Watching for changes to run tests..."
	air -test

## watch-build: Rebuild on file changes (requires air)
watch-build:
	@echo "Watching for changes to rebuild..."
	air -build

## watch-run: Rebuild and run on file changes (requires air)
watch-run:
	@echo "Watching for changes to run..."
	air

## help: Show this help message
help:
	@echo "Usage: make [target]"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'
