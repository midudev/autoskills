---
name: meson
description: "Build C/C++ projects with the Meson build system. Use when writing meson.build files, configuring dependencies with pkg-config or wraps, cross-compiling, or working with Ninja backend. Covers Meson 1.x."
metadata:
  version: "1.0"
  source: "autoskills"
---

# Meson Build System

## When to Use

- Writing or maintaining `meson.build` files
- Managing dependencies via pkg-config or WrapDB
- Cross-compiling with cross files
- Setting up test suites
- Building with Ninja backend (default)
- Alternative to CMake for new C/C++ projects

## Quick Reference

### Essential Commands

| Task | Command | Notes |
|------|---------|-------|
| Configure | `meson setup builddir` | Create build directory |
| Build | `meson compile -C builddir` | Compile the project |
| Test | `meson test -C builddir` | Run test suite |
| Install | `meson install -C builddir` | Install to prefix |
| Clean | `meson setup builddir --wipe` | Reconfigure from scratch |
| Reconfigure | `meson configure builddir` | Change options |
| Introspect | `meson introspect builddir` | Query build info |

## meson.build Patterns

### Minimal Project

```meson
project('myproject', 'cpp',
  version: '1.0.0',
  default_options: ['cpp_std=c++17', 'warning_level=2'])

executable('myapp', 'main.cpp',
  install: true)
```

### Library + Executable

```meson
project('myproject', 'cpp',
  version: '1.0.0',
  default_options: ['cpp_std=c++17'])

# Shared library
mylib = shared_library('mylib',
  sources: ['src/mylib.cpp'],
  include_directories: include_directories('include'),
  install: true)

# Declare dependency for consumers
mylib_dep = declare_dependency(
  include_directories: include_directories('include'),
  link_with: mylib)

# Executable
executable('myapp',
  sources: ['main.cpp'],
  dependencies: [mylib_dep],
  install: true)
```

### Dependencies

```meson
# pkg-config (auto-detected)
fmt_dep = dependency('fmt', required: true)
nlohmann_json_dep = dependency('nlohmann_json', required: true)

# WrapDB
fmt_dep = dependency('fmt', fallback: ['fmt', 'fmt_dep'])

# Subproject
subdir('vendor/mylib')
mylib_dep = mylib.get_variable('mylib_dep')

# Build options
option('use_ssl', type: 'boolean', value: true, description: 'Enable SSL support')
```

### Testing

```meson
test('basic_test', executable('test_basic',
  sources: ['tests/test_basic.cpp'],
  dependencies: [mylib_dep]))

test('advanced_test', executable('test_advanced',
  sources: ['tests/test_advanced.cpp'],
  dependencies: [mylib_dep]),
  timeout: 60)
```

### Custom Targets

```meson
# Code generation
custom_target('generated',
  input: 'schema.json',
  output: 'generated.h',
  command: [find_program('generate'), '@INPUT@', '@OUTPUT@'],
  install: true,
  install_dir: 'include')

# Custom script
run_target('docs',
  command: [find_program('doxygen'), 'Doxyfile'])
```

## Cross Compilation

```ini
# cross.ini
[binaries]
c = 'arm-linux-gnueabihf-gcc'
cpp = 'arm-linux-gnueabihf-g++'
ar = 'arm-linux-gnueabihf-ar'
strip = 'arm-linux-gnueabihf-strip'

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'cortex-a7'
endian = 'little'

[properties]
needs_exe_wrapper = true
```

```bash
meson setup builddir --cross-file cross.ini
```

## Build Options

```bash
# List all options
meson configure builddir

# Set option
meson configure builddir -Duse_ssl=true
meson configure builddir -Dbuildtype=debugoptimized
meson configure builddir -Db_lto=true
```

## Common Options

| Option | Values | Default |
|--------|--------|---------|
| `buildtype` | `debug`, `debugoptimized`, `release`, `minsize` | `debugoptimized` |
| `cpp_std` | `c++11`, `c++14`, `c++17`, `c++20`, `c++23` | compiler default |
| `warning_level` | `0`, `1`, `2`, `3` | `1` |
| `b_lto` | `true`, `false` | `false` |
| `default_library` | `shared`, `static`, `both` | `shared` |
| `prefix` | path | `/usr/local` |

## Common Gotchas

- Build directory must not exist before `meson setup`
- Use `--wipe` to reconfigure (deletes build dir)
- Dependencies default to `required: true` — set `required: false` for optional
- `meson compile -C builddir` is preferred over raw `ninja` invocation
- Subprojects are in `subprojects/` directory — use `meson subprojects update`
- WrapDB wraps are auto-downloaded on first build
- Use `import('pkgconfig').generate()` to create `.pc` files
- Cross-compilation requires a cross file

## Verification Checklist

- [ ] `meson setup builddir` completes without errors
- [ ] `meson compile -C builddir` builds successfully
- [ ] `meson test -C builddir` passes all tests
- [ ] Dependencies found via pkg-config or wraps
- [ ] Correct `cpp_std` set for project requirements
- [ ] Install rules configured if needed
