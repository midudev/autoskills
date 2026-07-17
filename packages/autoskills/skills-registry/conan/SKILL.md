---
name: conan
description: "Manage C/C++ dependencies with Conan package manager. Use when adding, removing, or updating libraries, creating conanfile.txt or conanfile.py, configuring remotes, or resolving dependency conflicts in C/C++ projects."
metadata:
  version: "1.0"
  source: "autoskills"
---

# Conan Package Manager

## When to Use

- Adding third-party C/C++ libraries to a project
- Managing dependency versions and configurations
- Creating reusable package recipes
- Configuring package remotes and mirrors
- Resolving transitive dependency conflicts
- Cross-compiling with Conan profiles

## Quick Reference

### Essential Commands

| Task | Command | Notes |
|------|---------|-------|
| Install dependencies | `conan install . --output-folder=build --build=missing` | Conan 2.x |
| Create package | `conan create .` | Build + test a recipe |
| Export recipe | `conan export .` | Add to local cache |
| Search packages | `conan search "zlib/*"` | Query remote |
| Remove package | `conan remove "zlib/*"` | Clean cache |
| List packages | `conan list "*"` | Show cached packages |
| Add remote | `conan remote add myremote https://...` | Register remote |
| Profile detect | `conan profile detect` | Auto-detect compiler |

### conanfile.txt (Simple)

```ini
[requires]
zlib/1.3.1
fmt/10.2.1
nlohmann_json/3.11.3

[generators]
CMakeDeps
CMakeToolchain

[layout]
cmake_layout
```

### conanfile.py (Full Control)

```python
from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout, CMakeDeps, CMakeToolchain
from conan.tools.files import copy, collect_libs
import os

class MyPkgConan(ConanFile):
    name = "mypkg"
    version = "1.0"
    license = "MIT"
    settings = "os", "compiler", "build_type", "arch"
    exports_sources = "CMakeLists.txt", "src/*", "include/*"

    def requirements(self):
        self.requires("zlib/1.3.1")
        self.requires("fmt/10.2.1")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()
        copy(self, "*.h", src=self.source_folder, dst=os.path.join(self.package_folder, "include"))

    def package_info(self):
        self.cpp_info.libs = collect_libs(self)
```

## CMake Integration

```cmake
cmake_minimum_required(VERSION 3.15)
project(MyApp LANGUAGES CXX)

find_package(zlib REQUIRED)
find_package(fmt REQUIRED)

add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE zlib::zlib fmt::fmt)
```

Build workflow:
```bash
conan install . --output-folder=build --build=missing -s build_type=Release
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

## Common Patterns

### Debug + Release side by side

```bash
conan install . -of=build-debug -s build_type=Debug --build=missing
conan install . -of=build-release -s build_type=Release --build=missing
```

### Header-only libraries

```python
def package_info(self):
    self.cpp_info.header_only()
```

### Custom settings

```ini
# conanfile.txt with options
[requires]
openssl/3.2.0

[options]
openssl:shared=True
```

## Common Gotchas

- Always use `--build=missing` in CI to avoid pre-built binary issues
- Lock files (`conan.lock`) for reproducible builds
- Use `conan profile detect` to set up compiler profiles
- Conan 2.x is incompatible with 1.x recipes — migrate carefully
- Use `CMakeDeps` + `CMakeToolchain` generators (not the old `cmake` generator)
- Never hardcode paths in recipes — use `self.dependencies` instead
- Set `settings.compiler.cppstd` for C++ standard version

## Verification Checklist

- [ ] `conan install` completes without errors
- [ ] `cmake` finds all dependencies via toolchain
- [ ] Build succeeds with correct linking
- [ ] `conan create .` passes package tests
- [ ] No version conflicts in dependency tree
