---
name: c
description: "Build systems programming projects in C. Use when writing C code, debugging memory issues, working with Makefiles/CMake, managing headers, or building libraries and executables. Covers C11/C17/C23 standards, POSIX, and common patterns."
metadata:
  version: "1.0"
  source: "autoskills"
---

# C Programming

## When to Use

- Writing or reviewing C source code (`.c` / `.h` files)
- Debugging memory management (malloc/free, buffer overflows, leaks)
- Working with Makefiles or CMake build systems
- Building shared/static libraries
- POSIX system programming (file I/O, processes, threads, sockets)
- Embedded or bare-metal development
- Interfacing with hardware or OS APIs

## Quick Reference

### Compilation

| Task | Command | Notes |
|------|---------|-------|
| Compile single file | `gcc -o out file.c` | Default C standard |
| Specify standard | `gcc -std=c17 -o out file.c` | C11, C17, C23 |
| Enable warnings | `gcc -Wall -Wextra -Werror -o out file.c` | Treat warnings as errors |
| Debug build | `gcc -g -fsanitize=address -o out file.c` | ASan for memory errors |
| Optimize | `gcc -O2 -o out file.c` | Production build |
| Link math lib | `gcc -o out file.c -lm` | Required for `<math.h>` |
| Compile only | `gcc -c file.c` | Produces `file.o` |

### Common Flags

| Flag | Purpose |
|------|---------|
| `-Wall -Wextra` | Enable most warnings |
| `-Werror` | Treat warnings as errors |
| `-fsanitize=address` | AddressSanitizer (memory errors) |
| `-fsanitize=undefined` | UndefinedBehaviorSanitizer |
| `-fsanitize=thread` | ThreadSanitizer (data races) |
| `-pedantic` | Strict ISO compliance |
| `-std=c17` | Use C17 standard |
| `-std=c23` | Use C23 standard (latest) |
| `-I/dir` | Add include path |
| `-L/dir` | Add library search path |
| `-l[name]` | Link library (e.g., `-lpthread`) |

## Memory Management

```c
// Allocate
int *arr = malloc(n * sizeof(int));
if (!arr) { /* handle error */ }

// Reallocate: use temporary to preserve original on failure
if (new_size > SIZE_MAX / sizeof(int)) { /* handle overflow */ }
void *tmp = realloc(arr, new_size * sizeof(int));
if (tmp) arr = tmp;
else     { /* handle failure — arr still valid */ }

// Free
free(arr);
arr = NULL;  // Avoid dangling pointer
```

### Valgrind

```bash
valgrind --leak-check=full --track-origins=yes ./program
```

## Common Patterns

### Header Guard

```c
#ifndef MYHEADER_H
#define MYHEADER_H

#ifdef __cplusplus
extern "C" {
#endif

/* declarations */

#ifdef __cplusplus
}
#endif

#endif /* MYHEADER_H */
```

### Makefile

```makefile
CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -g
LDFLAGS =
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
TARGET = program

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean
```

### Static Library

```bash
gcc -c file1.c file2.c
ar rcs libmylib.a file1.o file2.o
gcc -o program main.c -L. -lmylib
```

### Shared Library

```bash
gcc -shared -fPIC -o libmylib.so file1.c file2.c
gcc -o program main.c -L. -lmylib -Wl,-rpath,'$ORIGIN'
# Only use $ORIGIN when libraries are distributed alongside the executable
```

## Common Gotchas

- Always check `malloc`/`calloc` return values for `NULL`
- Never use `gets()` — use `fgets()` instead
- Free memory in dependency order: release dependent objects before their owning containers
- Use `size_t` for sizes and indices, not `int`
- Initialize all variables before use
- Use `const` for read-only parameters
- Watch for integer overflow in `malloc(n * size)` — check for `SIZE_MAX / size < n`
- Use `snprintf()` instead of `sprintf()` to prevent buffer overflow
- Null-terminate strings properly

## Debugging

```bash
# GDB basics
gcc -g -o program program.c
gdb ./program

# Inside GDB
(gdb) break main
(gdb) run
(gdb) next        # Step over
(gdb) step        # Step into
(gdb) print var   # Inspect variable
(gdb) backtrace   # Call stack
```

## Verification Checklist

- [ ] Compiled with `-Wall -Wextra` and no warnings
- [ ] No memory leaks (verified with Valgrind or ASan)
- [ ] All `malloc`/`calloc` returns checked
- [ ] No use of deprecated/unsafe functions (`gets`, `strcpy` without bounds)
- [ ] Header guards present in all `.h` files
- [ ] Return values of system calls checked
