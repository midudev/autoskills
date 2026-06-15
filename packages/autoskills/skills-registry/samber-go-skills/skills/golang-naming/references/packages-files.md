# Packages, Files & Import Aliasing

## Packages

Package names MUST be **lowercase, single-word**, with no underscores or MixedCaps. They should be short, concise, and evocative of their purpose. Numbers are allowed (`oauth2`, `k8s`).

```go
// Good
package json
package http
package tabwriter
package oauth2

// Bad
package httpServer    // no MixedCaps
package http_server   // no underscores
package util          // too generic
package common        // meaningless
package helpers       // what does it help with?
package base          // says nothing
package model         // too vague
```

NEVER use generic package names like `util`, `helper`, `common`, `base`, `model`. They fail to communicate purpose and cause import collisions. If you reach for `util`, the function probably belongs in a more specific package.

Package names SHOULD be **singular**, not plural — `net/url` not `net/urls`, `go/token` not `go/tokens`.

### Directory vs Package Name

Directory names SHOULD **match the package name** when possible. Multi-word directories use **hyphens**, but since package names cannot contain hyphens, the package drops them.

```
// Good — directory matches package
httputil/          → package httputil
middleware/        → package middleware
auth/              → package auth

// Good — hyphenated directory, package drops hyphens
user-service/      → package userservice
rate-limit/        → package ratelimit
go-chi/            → package chi

// Good — special directories
cmd/api/           → package main       (cmd/ subdirectories are always main)
internal/auth/     → package auth       (internal/ restricts visibility)

// Bad
user_service/      → package user_service  (underscores in both)
UserService/       → package UserService   (no MixedCaps in directories)
myPackage/         → package mypackage     (directory has caps, package doesn't)
```

Special directories have Go toolchain meaning and don't follow normal naming:

- `cmd/` — entry points, each subdirectory is `package main`
- `internal/` — restricts import visibility to parent module
- `testdata/` — ignored by the Go tool
- `vendor/` — vendored dependencies

Package names SHOULD NOT duplicate exported names — users see `bufio.Reader`, not `bufio.BufReader`. Think about the call site.

## Files

File names MUST be **lowercase** with words separated by **underscores**.

```
user_handler.go
string_converter.go
http_client_test.go
```

Special suffixes:

- `_test.go` — test files (excluded from production builds)
- `_linux.go`, `_amd64.go` — OS/architecture-specific (build constraints)

## Import Aliasing

Import aliases SHOULD only be used on name collision. When an alias is necessary, use a descriptive short name.

```go
// Good — no alias needed
import "github.com/go-chi/chi/v5"

// Good — alias resolves collision
import (
    "crypto/rand"
    mrand "math/rand"
)

// Good — conventional alias for generated code
import pb "myapp/proto/userpb"

// Bad — unnecessary alias
import f "fmt"
```
