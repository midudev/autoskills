---
name: dart-best-practices
description: |-
  General best practices for Dart development.
  Covers code style, effective Dart, and language features.
license: Apache-2.0
---

# Dart Best Practices

## 1. When to use this skill
Use this skill when:
-   Writing or reviewing Dart code.
-   Looking for guidance on idiomatic Dart usage.

## 2. Best Practices

### Multi-line Strings
Prefer using multi-line strings (`'''`) over concatenating strings with `+` and
`\n`, especially for large blocks of text like SQL queries, HTML, or
PEM-encoded keys. This improves readability and avoids
`lines_longer_than_80_chars` lint errors by allowing natural line breaks.

**Avoid:**
```dart
final pem = '-----BEGIN RSA PRIVATE KEY-----\n' +
    base64Encode(fullBytes) +
    '\n-----END RSA PRIVATE KEY-----';
```

**Prefer:**
```dart
final pem = '''
-----BEGIN RSA PRIVATE KEY-----
${base64Encode(fullBytes)}
-----END RSA PRIVATE KEY-----''';
```

### Line Length
Avoid lines longer than 80 characters, even in Markdown files and comments.
This ensures code is readable in split-screen views and on smaller screens
without horizontal scrolling.

**Prefer:**
Target 80 characters for wrapping text. Exceptions are allowed for long URLs
or identifiers that cannot be broken.

## Related Skills

- **[dart-modern-features]**: For idiomatic
  usage of modern Dart features like Pattern Matching (useful for deep JSON
  extraction), Records, and Switch Expressions.

[dart-modern-features]: https://github.com/kevmoo/dash_skills/blob/main/.agent/skills/dart-modern-features/SKILL.md
