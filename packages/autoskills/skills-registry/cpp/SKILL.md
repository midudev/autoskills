---
name: cpp
description: "Build modern C++ applications. Use when writing C++17/20/23 code, working with templates, smart pointers, STL containers, concurrency, RAII, or debugging C++ projects. Covers modern idioms, best practices, and common pitfalls."
metadata:
  version: "1.0"
  source: "autoskills"
---

# C++ Programming

## When to Use

- Writing or reviewing C++ source code (`.cpp` / `.hpp` / `.h` files)
- Working with modern C++ features (C++17/20/23)
- Designing class hierarchies, templates, or generic code
- Memory management with smart pointers
- Concurrency and multithreading
- Performance-critical systems programming
- Building with CMake or other build systems

## Quick Reference

### Compilation

| Task | Command | Notes |
|------|---------|-------|
| Compile | `g++ -std=c++17 -o out file.cpp` | C++17 default |
| C++20 | `g++ -std=c++20 -o out file.cpp` | Latest stable |
| C++23 | `g++ -std=c++23 -o out file.cpp` | Cutting edge |
| Debug | `g++ -g -fsanitize=address,undefined -o out file.cpp` | ASan + UBSan |
| Optimize | `g++ -O2 -march=native -o out file.cpp` | Release build |
| Concepts (C++20) | `g++ -std=c++20 -o out file.cpp` | Concepts included |

### Common Flags

| Flag | Purpose |
|------|---------|
| `-std=c++17/20/23` | C++ standard version |
| `-Wall -Wextra -Wpedantic` | Enable warnings |
| `-Werror` | Treat warnings as errors |
| `-fsanitize=address` | AddressSanitizer |
| `-fsanitize=undefined` | UndefinedBehaviorSanitizer |
| `-fsanitize=thread` | ThreadSanitizer |
| `-fno-exceptions` | Disable exceptions (embedded) |
| `-fno-rtti` | Disable RTTI |
| `-pthread` | Link POSIX threads |
| `-fcoroutines` | Enable coroutines (GCC) |
| `-ftemplate-depth=N` | Increase template depth limit |

## Modern C++ Idioms

### Smart Pointers (RAII)

```cpp
#include <memory>

// Unique ownership
auto ptr = std::make_unique<MyClass>(args);

// Shared ownership
auto shared = std::make_shared<MyClass>(args);

// Weak reference (no ownership)
std::weak_ptr<MyClass> weak = shared;
if (auto locked = weak.lock()) {
    // Use locked
}

// NEVER: raw new/delete in modern C++
```

### Move Semantics

```cpp
class Buffer {
    std::vector<uint8_t> data_;
public:
    // Move constructor
    Buffer(Buffer &&other) noexcept = default;
    // Move assignment
    Buffer &operator=(Buffer &&other) noexcept = default;

    // Disable copy
    Buffer(const Buffer &) = delete;
    Buffer &operator=(const Buffer &) = delete;
};
```

### RAII Wrappers

```cpp
// File handle
std::ifstream file("data.txt");
if (!file) { /* handle error */ }

// Lock guard
std::mutex mtx;
{
    std::lock_guard lock(mtx);  // C++17: CTAD
    // critical section
}

// Scope guard (C++11 pattern with custom RAII)
class ScopeGuard {
    std::function<void()> f_;
public:
    explicit ScopeGuard(std::function<void()> f) : f_(std::move(f)) {}
    ~ScopeGuard() { if (f_) f_(); }
    void dismiss() { f_ = nullptr; }
};

auto guard = ScopeGuard([&]() { cleanup(); });
```

## STL Quick Reference

### Containers

| Container | Use Case | Header |
|-----------|----------|--------|
| `std::vector` | Dynamic array | `<vector>` |
| `std::string` | String manipulation | `<string>` |
| `std::unordered_map` | Fast key-value lookup | `<unordered_map>` |
| `std::map` | Ordered key-value | `<map>` |
| `std::set` | Unique sorted elements | `<set>` |
| `std::unordered_set` | Unique fast lookup | `<unordered_set>` |
| `std::deque` | Double-ended queue | `<deque>` |
| `std::list` | Doubly-linked list | `<list>` |
| `std::array` | Fixed-size array | `<array>` |

### Algorithms

```cpp
#include <algorithm>
#include <ranges>  // C++20

// C++20 ranges
auto even = [](int n) { return n % 2 == 0; };
auto squared = [](int n) { return n * n; };

auto result = numbers
    | std::views::filter(even)
    | std::views::transform(squared);

// Traditional
std::sort(v.begin(), v.end());
auto it = std::find_if(v.begin(), v.end(), predicate);
std::transform(v.begin(), v.end(), out.begin(), func);
std::accumulate(v.begin(), v.end(), init);
```

## Concurrency

```cpp
#include <thread>
#include <mutex>
#include <future>
#include <atomic>

// std::thread
std::thread t([]{ work(); });
t.join();

// std::async
auto future = std::async(std::launch::async, []{ return compute(); });
auto result = future.get();

// std::atomic
std::atomic<int> counter{0};
counter.fetch_add(1, std::memory_order_relaxed);

// Thread pool pattern
class ThreadPool {
    std::vector<std::jthread> workers_;
    std::queue<std::function<void()>> tasks_;
    std::mutex mtx_;
    std::condition_variable cv_;
    bool stop_ = false;
public:
    ThreadPool(size_t threads = std::thread::hardware_concurrency()) {
        for (size_t i = 0; i < threads; ++i) {
            workers_.emplace_back([this] {
                while (true) {
                    std::function<void()> task;
                    {
                        std::unique_lock lock(mtx_);
                        cv_.wait(lock, [this] { return stop_ || !tasks_.empty(); });
                        if (stop_ && tasks_.empty()) return;
                        task = std::move(tasks_.front());
                        tasks_.pop();
                    }
                    task();
                }
            });
        }
    }

    ~ThreadPool() {
        {
            std::lock_guard lock(mtx_);
            stop_ = true;
        }
        cv_.notify_all();
    }

    template<typename F>
    void enqueue(F&& f) {
        {
            std::lock_guard lock(mtx_);
            tasks_.emplace(std::forward<F>(f));
        }
        cv_.notify_one();
    }
};
```

## Templates

```cpp
// Function template
template<typename T>
T clamp(T value, T lo, T hi) {
    return std::max(lo, std::min(value, hi));
}

// C++20 Concepts
template<typename T>
concept Numeric = std::is_arithmetic_v<T>;

template<Numeric T>
T add(T a, T b) { return a + b; }

// Variable template
template<typename T>
constexpr T pi = T(3.14159265358979323846);

// Class template
template<typename T, size_t N>
class StaticVector {
    std::array<T, N> data_;
    size_t size_ = 0;
public:
    void push_back(const T& val) {
        if (size_ >= N) throw std::length_error("StaticVector capacity exceeded");
        data_[size_++] = val;
    }
    size_t size() const { return size_; }
};
```

## Common Gotchas

- **Slicing**: Pass polymorphic objects by pointer/reference, not by value
- **Dangling references**: Be careful with `std::string_view` and `std::span`
- **Integer overflow**: Use checked arithmetic for untrusted input
- **Use-after-move**: Don't access objects after `std::move()`
- **Thread safety**: Shared mutable state needs synchronization
- **One Definition Rule**: Don't define the same function in multiple translation units
- **Header-only libraries**: Watch compile times with heavy template usage
- **Exception safety**: Use RAII, prefer `noexcept` on move operations
- **`auto` pitfalls**: `auto` deduces value types, dropping references — use `auto&` or `decltype(auto)`
- **Virtual destructors**: Always make base class destructors virtual if using polymorphism

## Debugging

```bash
# Compile with debug symbols
g++ -g -O0 -fsanitize=address,undefined -o program program.cpp

# GDB for C++
gdb ./program
(gdb) catch throw          # Break on exception
(gdb) print obj            # Print object
(gdb) call obj.method()    # Call method
(gdb) info vtable obj      # Virtual table

# AddressSanitizer output
# ==12345==ERROR: AddressSanitizer: stack-buffer-overflow
```

## Verification Checklist

- [ ] Compiled with `-Wall -Wextra -Wpedantic` and no warnings
- [ ] Smart pointers used instead of raw `new`/`delete`
- [ ] RAII for resource management
- [ ] No undefined behavior (UBSan clean)
- [ ] No memory errors (ASan clean)
- [ ] Thread safety verified (TSan clean if multithreaded)
- [ ] Rule of Five/Zero followed for custom types
