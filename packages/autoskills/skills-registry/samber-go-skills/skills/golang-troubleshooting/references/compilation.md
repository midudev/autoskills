# Compilation Issues

## Module Problems

```bash
go clean -modcache      # clean module cache
go mod download         # re-download dependencies
go mod verify           # verify dependencies
go mod tidy             # tidy dependencies
go mod why <package>    # why is this dependency here?
```

## CGO Issues

```bash
go env CGO_ENABLED                         # check CGO is enabled
export CGO_CFLAGS="-I/usr/local/include"   # set CGO CFLAGS
# macOS: brew install pkg-config
# Ubuntu: apt install pkg-config
```

## Version Mismatch

```bash
go version              # check Go version
go mod edit -go=1.21    # set minimum required version
```
