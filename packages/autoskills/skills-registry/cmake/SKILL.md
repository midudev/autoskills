---
name: cmake
description: "Build and configure C/C++ projects with CMake. Use when writing CMakeLists.txt, managing dependencies with find_package or FetchContent, setting up build configurations, cross-compiling, or working with modern CMake targets and properties."
metadata:
  version: "1.0"
  source: "autoskills"
---

# CMake Build System

## When to Use

- Writing or maintaining `CMakeLists.txt` files
- Managing C/C++ dependencies (`find_package`, `FetchContent`, `Conan`, `vcpkg`)
- Setting up build types (Debug, Release, RelWithDebInfo)
- Cross-compilation and toolchain files
- Testing with `CTest`
- Packaging with `CPack`
- Modern CMake target-based configuration

## Quick Reference

### Essential Commands

| Task | Command | Notes |
|------|---------|-------|
| Configure | `cmake -B build -S .` | Out-of-source build |
| Build | `cmake --build build` | Compile the project |
| Clean rebuild | `cmake --build build --clean-first` | Clean + build |
| Install | `cmake --install build` | Install to prefix |
| Run tests | `ctest --test-dir build` | After build |
| List generators | `cmake --help` | Shows available generators |

### Build Types

| Type | Flags | Use Case |
|------|-------|----------|
| `Debug` | `-g -O0` | Development |
| `Release` | `-O3 -DNDEBUG` | Production |
| `RelWithDebInfo` | `-O2 -g -DNDEBUG` | Profiling |
| `MinSizeRel` | `-Os -DNDEBUG` | Size-constrained |

```bash
cmake -B build -DCMAKE_BUILD_TYPE=Release
```

## CMakeLists.txt Patterns

### Minimum Project

```cmake
cmake_minimum_required(VERSION 3.16)
project(MyApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE some::lib)
```

### Library + Executable

```cmake
cmake_minimum_required(VERSION 3.16)
project(MyProject LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Library
add_library(mylib STATIC
    src/mylib.cpp
    src/mylib_internal.cpp
)
target_include_directories(mylib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

# Executable
add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE mylib)
```

### Finding Dependencies

```cmake
# Standard find_package
find_package(Qt6 REQUIRED COMPONENTS Core Widgets)
target_link_libraries(myapp PRIVATE Qt6::Core Qt6::Widgets)

# FetchContent (download at configure time)
include(FetchContent)
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 10.2.1
)
FetchContent_MakeAvailable(fmt)
target_link_libraries(myapp PRIVATE fmt::fmt)
```

### Testing

```cmake
enable_testing()
find_package(GTest REQUIRED)

add_executable(tests test_main.cpp test_mylib.cpp)
target_link_libraries(tests PRIVATE GTest::gtest_main mylib)

include(GoogleTest)
gtest_discover_tests(tests)
```

### Options and Conditionals

```cmake
option(BUILD_TESTS "Build tests" ON)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# Platform checks
if(WIN32)
    target_compile_definitions(mylib PRIVATE PLATFORM_WINDOWS)
elseif(APPLE)
    target_compile_definitions(mylib PRIVATE PLATFORM_MACOS)
elseif(UNIX)
    target_compile_definitions(mylib PRIVATE PLATFORM_LINUX)
endif()
```

### Install Rules

```cmake
include(GNUInstallDirs)

install(TARGETS mylib
    EXPORT mylib-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# CMake package config
install(EXPORT mylib-config
    NAMESPACE mylib::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/mylib
)
```

## Best Practices

- Use **target-based** commands (`target_link_libraries`, `target_compile_options`) instead of global (`link_libraries`, `add_compile_options`)
- Use `PRIVATE`, `PUBLIC`, `INTERFACE` visibility correctly on `target_link_libraries`
- Use generator expressions for build/install interfaces: `$<BUILD_INTERFACE:...>` / `$<INSTALL_INTERFACE:...>`
- Use `CMAKE_CXX_STANDARD` instead of compiler flags for C++ standard
- Always use `CMAKE_CXX_STANDARD_REQUIRED ON`
- Use `FetchContent` for vendored dependencies, `find_package` for system deps
- Use `CMAKE_EXPORT_COMPILE_COMMANDS ON` for IDE/editor integration
- Use `configure_file()` for config headers instead of `add_definitions`
- Set minimum CMake version to 3.16+ (supports modern features)

## Common Gotchas

- Out-of-source builds: always use `-B build` (never build in source root)
- `CMAKE_BUILD_TYPE` is single-config generators only (Makefiles, Ninja)
- Multi-config generators (Visual Studio, Xcode) set build type at build time
- `FetchContent` downloads at configure time — pin specific tags/commits
- `find_package` vs `find_package(... CONFIG)`: CONFIG mode uses package config files
- Variable scope: use `PARENT_SCOPE` or `CACHE` when needed
- Use `${CMAKE_CURRENT_SOURCE_DIR}` not `${CMAKE_SOURCE_DIR}` in subdirectories
- `CMAKE_INSTALL_PREFIX` controls install location (default `/usr/local`)

## Verification Checklist

- [ ] Uses target-based commands (not global)
- [ ] `CMAKE_CXX_STANDARD_REQUIRED ON` set
- [ ] Dependencies pinned to specific versions
- [ ] Build tests with `enable_testing()` + `ctest`
- [ ] Install rules use `GNUInstallDirs` variables
- [ ] No in-source builds
- [ ] `compile_commands.json` generated for IDE support
