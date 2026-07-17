---
name: doxygen
description: "Generate documentation for C/C++ projects with Doxygen. Use when writing Doxyfile configs, documenting code with Doxygen comments, generating HTML/PDF docs, or creating class/library references."
metadata:
  version: "1.0"
  source: "autoskills"
---

# Doxygen Documentation

## When to Use

- Generating API documentation from C/C++ source code
- Writing Doxygen-compatible comments and documentation blocks
- Configuring `Doxyfile` for custom output
- Creating HTML, PDF, or LaTeX documentation
- Documenting class hierarchies, modules, and file structures
- Integrating documentation generation into build systems

## Quick Reference

### Essential Commands

| Task | Command | Notes |
|------|---------|-------|
| Generate config | `doxygen -g` | Creates Doxyfile |
| Generate docs | `doxygen Doxyfile` | Build documentation |
| Generate + open | `doxygen && open docs/html/index.html` | macOS |
| Minimal config | `doxygen -s -g` | Stripped-down config |

## Code Documentation Syntax

### File Header

```cpp
/**
 * @file mylib.h
 * @brief Library for managing widgets.
 * @author John Doe
 * @date 2026-01-15
 * @version 2.1.0
 *
 * This library provides widget management capabilities
 * including creation, deletion, and transformation.
 */
```

### Function Documentation

```cpp
/**
 * @brief Computes the distance between two points.
 *
 * @param x1 X coordinate of first point
 * @param y1 Y coordinate of first point
 * @param x2 X coordinate of second point
 * @param y2 Y coordinate of second point
 * @return Euclidean distance as a double
 *
 * @pre Both points must be in the same coordinate system
 * @post No side effects
 *
 * @note Uses double precision for accuracy
 * @see Point, Vector
 *
 * @code
 * double d = distance(0, 0, 3, 4); // returns 5.0
 * @endcode
 */
double distance(double x1, double y1, double x2, double y2);
```

### Class Documentation

```cpp
/**
 * @class Widget
 * @brief A graphical user interface element.
 *
 * Widget is the base class for all UI elements.
 * It manages positioning, rendering, and event handling.
 *
 * @par Inheritance
 * Widget is inherited by Button, Label, and TextField.
 *
 * @see Button, Label, TextField
 */
class Widget {
public:
    /**
     * @brief Constructs a Widget at the given position.
     *
     * @param x Horizontal position
     * @param y Vertical position
     * @param parent Parent widget (nullable)
     */
    Widget(int x, int y, Widget* parent = nullptr);

    /** @brief Virtual destructor for polymorphic deletion. */
    virtual ~Widget() = default;

    /**
     * @brief Renders the widget.
     *
     * @param ctx Rendering context
     * @return true if rendering succeeded
     */
    virtual bool render(RenderContext& ctx) = 0;

    /**
     * @brief Widget position.
     *
     * @{
     */
    int x() const { return x_; }
    int y() const { return y_; }
    /** @} */
};
```

### Enum Documentation

```cpp
/**
 * @enum Alignment
 * @brief Text alignment options.
 */
enum class Alignment {
    Left,   ///< Align text to the left
    Center, ///< Center-align text
    Right,  ///< Align text to the right
    Justify ///< Justify text (full width)
};
```

### Grouping

```cpp
/**
 * @defgroup networking Network Communication
 * @brief HTTP, TCP, and WebSocket utilities.
 *
 * @{
 */

/** @brief HTTP client for REST API calls. */
class HttpClient { /* ... */ };

/** @brief WebSocket connection handler. */
class WebSocket { /* ... */ };

/** @} */ // end of networking group
```

## Doxyfile Configuration

```ini
# Project
PROJECT_NAME           = "My Project"
PROJECT_NUMBER         = "2.1.0"
PROJECT_BRIEF          = "Widget management library"
OUTPUT_DIRECTORY       = docs

# Input
INPUT                  = src include
FILE_PATTERNS          = *.cpp *.h *.hpp *.c
RECURSIVE              = YES
EXCLUDE_PATTERNS       = */test/* */build/*

# Output formats
GENERATE_HTML          = YES
GENERATE_LATEX         = NO
GENERATE_TREEVIEW      = YES

# Extraction
EXTRACT_ALL            = YES
EXTRACT_PRIVATE        = NO
EXTRACT_STATIC         = YES

# Diagrams
HAVE_DOT               = YES
DOT_NUM_THREADS        = 4
CLASS_DIAGRAMS         = YES
CALL_GRAPH             = YES
CALLER_GRAPH           = YES

# Warnings
QUIET                  = YES
WARN_IF_UNDOCUMENTED   = YES
WARN_NO_PARAMDOC       = YES

# Optimization
JAVADOC_AUTOBRIEF      = YES
BUILTIN_STL_SUPPORT    = YES
MARKDOWN_SUPPORT       = YES
```

## CMake Integration

```cmake
find_package(Doxygen REQUIRED)

set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

add_custom_target(docs
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Generating API documentation with Doxygen"
    VERBATIM)
```

## Best Practices

- Use `@brief` for one-line summaries (or rely on `JAVADOC_AUTOBRIEF`)
- Document all public APIs — use `WARN_NO_PARAMDOC = YES`
- Use `@param`, `@return`, `@note`, `@see` consistently
- Group related classes/modules with `@defgroup`
- Use `@{` and `@}` to mark group members
- Keep documentation close to code (not in separate files)
- Use `/**` for documentation, `///` for member docs
- Check for missing docs: `doxygen Doxyfile 2>&1 | grep "is not documented"`

## Common Gotchas

- `EXTRACT_ALL = YES` documents everything — use `NO` for API-only docs
- `INPUT` must include all source directories — missing dirs = empty docs
- `HAVE_DOT = YES` requires Graphviz installed
- LaTeX output requires a LaTeX distribution (pdflatex)
- Use `GENERATE_TREEVIEW = YES` for better navigation
- `WARN_IF_UNDOCUMENTED = YES` helps enforce documentation coverage

## Verification Checklist

- [ ] `doxygen Doxyfile` generates without errors
- [ ] HTML opens correctly in browser
- [ ] All public classes/functions are documented
- [ ] Diagrams render correctly (if HAVE_DOT enabled)
- [ ] No "not documented" warnings (with WARN_NO_PARAMDOC)
