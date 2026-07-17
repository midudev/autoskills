---
name: vcpkg
description: "Manage C/C++ dependencies with vcpkg. Use when adding libraries, creating vcpkg.json manifests, configuring triplets, or integrating with CMake/MSBuild in C/C++ projects. Covers both manifest and classic modes."
metadata:
  version: "1.0"
  source: "autoskills"
---

# vcpkg Package Manager

## When to Use

- Adding C/C++ libraries to a project via vcpkg
- Creating or editing `vcpkg.json` manifest files
- Configuring custom triplets for cross-compilation
- Integrating with CMake or MSBuild
- Resolving dependency conflicts
- Using binary caching for faster CI builds

## Quick Reference

### Essential Commands

| Task | Command | Notes |
|------|---------|-------|
| Install dependencies | `vcpkg install` | Manifest mode |
| Add a package | `vcpkg add port <name>` | Adds to vcpkg.json |
| Remove a package | `vcpkg remove <name>` | Removes from manifest |
| Search packages | `vcpkg search <name>` | Query available ports |
| Update packages | `vcpkg update` | Show outdated packages |
| Export package | `vcpkg export <name>` | Create relocatable package |
| List installed | `vcpkg list` | Show installed packages |
| Help triplet | `vcpkg help triplet` | List available triplets |

### vcpkg.json (Manifest)

```json
{
  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg-tool/main/docs/vcpkg.schema.json",
  "name": "myproject",
  "version-semver": "1.0.0",
  "dependencies": [
    "fmt",
    "nlohmann-json",
    "zlib",
    {
      "name": "openssl",
      "features": ["tools"],
      "platform": "!windows"
    }
  ],
  "builtin-baseline": "c82f74667287d3dc386bce81e44964370c91a289",
  "overrides": [],
  "vcpkg-configuration": {
    "registries": [
      {
        "kind": "git",
        "repository": "https://github.com/microsoft/vcpkg",
        "baseline": "c82f74667287d3dc386bce81e44964370c91a289"
      }
    ]
  }
}
```

## CMake Integration

```cmake
cmake_minimum_required(VERSION 3.15)
project(MyApp LANGUAGES CXX)

find_package(fmt CONFIG REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)

add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE fmt::fmt nlohmann_json::nlohmann_json)
```

Build:
```bash
cmake -B build -DCMAKE_TOOLCHAIN_FILE=[vcpkg root]/scripts/buildsystems/vcpkg.cmake
cmake --build build
```

### Presets (Recommended)

```json
// CMakePresets.json
{
  "version": 3,
  "configurePresets": [
    {
      "name": "vcpkg",
      "generator": "Ninja",
      "toolchainFile": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake",
      "binaryDir": "${sourceDir}/build"
    }
  ]
}
```

## Triplets

```bash
# Custom triplet for static linking on Linux
cat > $VCPKG_ROOT/triplets/custom-triplet.cmake << 'EOF'
set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE static)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CMAKE_CONFIGURE_OPTIONS -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
EOF

cmake -B build -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake \
  --overlay-triplets=$VCPKG_ROOT/triplets \
  -DVCPKG_TARGET_TRIPLET=custom-triplet
```

## Binary Caching

```bash
# Azure Blob Storage
export VCPKG_BINARY_SOURCES="clear;x-azblob,https://...;{SAS_TOKEN}"

# GitHub Actions cache
export VCPKG_BINARY_SOURCES="clear;files,$HOME/.cache/vcpkg/archives"

# NuGet
export VCPKG_BINARY_SOURCES="clear;nuget,https://nuget.pkg.github.com/..."
```

## Common Patterns

### Feature selection

```json
{
  "dependencies": [
    {
      "name": "qtbase",
      "features": ["gui", "widgets"]
    }
  ]
}
```

### Platform-specific

```json
{
  "dependencies": [
    {
      "name": "pthread",
      "platform": "linux"
    },
    {
      "name": "ws2_32",
      "platform": "windows"
    }
  ]
}
```

## Common Gotchas

- Always pin `builtin-baseline` in `vcpkg.json` for reproducible builds
- Use manifest mode (`vcpkg.json`) for projects, classic mode for global installs
- Set `VCPKG_ROOT` environment variable
- Binary caching dramatically speeds up CI — configure it early
- Use `vcpkg-configuration.json` for custom registries
- Triplet selection affects static vs dynamic linking
- Some ports have features that change dependencies — check with `vcpkg search <port> --features`

## Verification Checklist

- [ ] `vcpkg.json` is valid JSON with pinned baseline
- [ ] `cmake` finds packages via toolchain file
- [ ] Build links correctly against installed libraries
- [ ] Binary caching configured for CI
- [ ] Correct triplet selected for target platform
