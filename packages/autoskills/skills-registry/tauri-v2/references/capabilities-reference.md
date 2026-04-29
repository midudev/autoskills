# Tauri v2+ Capabilities & Permissions Reference

## Contents

- Security Model: v1 vs v2
- Overview
- Capability File Structure
- Core Permissions
- Plugin Permissions
- Scopes
- Permission Sets
- Window and Webview Targeting
- Capability Best Practices
- Common Capability Patterns
- Anti-Patterns

## Security Model: v1 vs v2

Tauri v2 replaces the v1 `allowlist` with a capabilities-first security model. In v1, you listed allowed API calls in `tauri.conf.json`'s `allowlist`. In v2, permissions must be explicitly granted via capability files in `src-tauri/capabilities/`.

**Three-layer security model:**
- **Capability**: A named collection of permissions, scoped to specific windows/webviews. Lives in `src-tauri/capabilities/*.json`.
- **Permission**: An identifier that grants access to a specific command or feature (e.g., `fs:allow-read-file`). Defined per-plugin.
- **Scope**: Optional constraint on a permission that limits what it can access (e.g., only `$APPDATA/*` paths). Part of a permission object.

## Overview

Tauri v2+ uses a capabilities-based security model. By default, **nothing is allowed** - you must explicitly grant permissions through capability files.

*Last verified: 2026-04-02. Check the official Tauri changelog when capability semantics or permission names change.*

## Capability File Structure

Location: `src-tauri/capabilities/`

```json
{
    "$schema": "../gen/schemas/desktop-schema.json",
    "identifier": "capability-name",
    "description": "What this capability allows",
    "windows": ["main", "settings"],
    "webviews": [],
    "permissions": [
        "core:default",
        "plugin-name:permission-name"
    ]
}
```

## Core Permissions

### Essential (Almost Always Needed)

```json
{
    "permissions": [
        "core:default",
        "core:window:default",
        "core:event:default"
    ]
}
```

### Window Permissions

| Permission | Description |
|------------|-------------|
| `core:window:default` | Basic window operations |
| `core:window:allow-close` | Allow closing windows |
| `core:window:allow-set-title` | Allow changing window title |
| `core:window:allow-minimize` | Allow minimizing |
| `core:window:allow-maximize` | Allow maximizing |
| `core:window:allow-set-size` | Allow resizing |
| `core:window:allow-set-position` | Allow repositioning |
| `core:window:allow-set-fullscreen` | Allow fullscreen toggle |

### Event Permissions

| Permission | Description |
|------------|-------------|
| `core:event:default` | Basic event listening |
| `core:event:allow-emit` | Allow emitting events |
| `core:event:allow-listen` | Allow listening to events |

## Plugin Permissions

### File System (`tauri-plugin-fs`)

```json
{
    "permissions": [
        "fs:default",
        "fs:allow-read-dir",
        "fs:allow-read-file",
        "fs:allow-write-file",
        "fs:allow-create-dir",
        "fs:allow-remove-file",
        "fs:allow-rename"
    ]
}
```

**With Scopes:**
```json
{
    "permissions": [
        {
            "identifier": "fs:allow-read-file",
            "allow": [
                { "path": "$APPDATA/*" },
                { "path": "$HOME/Documents/*" }
            ]
        }
    ]
}
```

### Dialog (`tauri-plugin-dialog`)

```json
{
    "permissions": [
        "dialog:default",
        "dialog:allow-open",
        "dialog:allow-save",
        "dialog:allow-message",
        "dialog:allow-ask",
        "dialog:allow-confirm"
    ]
}
```

### Shell (`tauri-plugin-shell`)

```json
{
    "permissions": [
        "shell:default",
        "shell:allow-open",
        "shell:allow-execute"
    ]
}
```

**Scoped Execute:**
```json
{
    "permissions": [
        {
            "identifier": "shell:allow-execute",
            "allow": [
                { "name": "git", "args": true },
                { "name": "npm", "args": ["install", "run"] }
            ]
        }
    ]
}
```

### HTTP (`tauri-plugin-http`)

```json
{
    "permissions": [
        "http:default"
    ]
}
```

**With URL Scopes:**
```json
{
    "permissions": [
        {
            "identifier": "http:default",
            "allow": [
                { "url": "https://api.example.com/*" },
                { "url": "https://*.myapp.com/*" }
            ]
        }
    ]
}
```

### Store (`tauri-plugin-store`)

```json
{
    "permissions": [
        "store:default",
        "store:allow-get",
        "store:allow-set",
        "store:allow-delete",
        "store:allow-keys",
        "store:allow-clear"
    ]
}
```

### Clipboard (`tauri-plugin-clipboard-manager`)

```json
{
    "permissions": [
        "clipboard-manager:default",
        "clipboard-manager:allow-read",
        "clipboard-manager:allow-write"
    ]
}
```

### Notification (`tauri-plugin-notification`)

```json
{
    "permissions": [
        "notification:default",
        "notification:allow-send",
        "notification:allow-request-permission"
    ]
}
```

### Global Shortcut (`tauri-plugin-global-shortcut`)

```json
{
    "permissions": [
        "global-shortcut:default",
        "global-shortcut:allow-register",
        "global-shortcut:allow-unregister"
    ]
}
```

## Permission Sets

Permission sets allow grouping multiple permissions into a single reusable identifier. You can use preset permission sets provided by plugins (like `fs:default`) or define your own in `src-tauri/permissions/`.

```json
{
  "permissions": [
    "fs:default",          // Permission set: includes common fs operations
    "fs:allow-read-file",  // Individual permission: specific operation
    {
      "identifier": "fs:allow-read-file",  // Permission with scope
      "allow": [{ "path": "$APPDATA/*" }]
    }
  ]
}
```

## Platform-Specific Capabilities

```json
{
    "identifier": "desktop-only",
    "platforms": ["linux", "macos", "windows"],
    "permissions": ["global-shortcut:default"]
}
```

```json
{
    "identifier": "mobile-only",
    "platforms": ["iOS", "android"],
    "permissions": ["biometric:default", "haptics:default"]
}
```

## Windows and Webviews Targeting

Capabilities are applied to specific windows and webviews by their labels. A window or webview can be part of multiple capabilities, in which case their permissions are merged.

```json
{
  "identifier": "main-window-cap",
  "windows": ["main"],        // Target by window label
  "webviews": [],             // Or target specific webviews
  "permissions": ["core:default", "fs:default"]
}
```

## Remote URL Access

Allow Tauri commands from remote URLs:

```json
{
    "identifier": "remote-access",
    "remote": {
        "urls": ["https://*.myapp.com"]
    },
    "permissions": ["http:default"]
}
```

## Custom Permission Files

Create custom permissions in `src-tauri/permissions/`:

**`custom.toml`:**
```toml
[[permission]]
identifier = "allow-home-documents"
description = "Allow access to home documents"
commands.allow = ["read_file", "write_file"]

[[scope.allow]]
path = "$HOME/Documents/**"
```

Reference in capability:
```json
{
    "permissions": ["custom:allow-home-documents"]
}
```

## Capability Best Practices

1. **Principle of Least Privilege**: Only grant what's needed
2. **Use Scopes**: Limit file/URL access to specific paths
3. **Separate Capabilities**: Create focused capability files for different features
4. **Platform-Specific**: Use platform filtering for platform-specific features
5. **Document**: Add descriptions to explain why permissions are needed

**See also:** [Plugin Reference](plugin-reference.md) for plugin-specific permission strings | [Advanced Runtime](advanced-runtime-reference.md) for tray/sidecar capabilities

## Anti-Pattern: Missing Capability

Plugin installed but **NOT** in capabilities = silent permission denied at runtime. Always add plugin permissions to a capability file that targets the window using the plugin.

## Common Capability Patterns

### Minimal App

```json
{
    "identifier": "minimal",
    "windows": ["main"],
    "permissions": ["core:default"]
}
```

### File Manager

```json
{
    "identifier": "file-manager",
    "windows": ["main"],
    "permissions": [
        "core:default",
        "fs:default",
        "dialog:allow-open",
        "dialog:allow-save"
    ]
}
```

### Web-Connected App

```json
{
    "identifier": "web-app",
    "windows": ["main"],
    "permissions": [
        "core:default",
        "http:default",
        "shell:allow-open"
    ]
}
```

### Full Desktop App

```json
{
    "identifier": "full-desktop",
    "windows": ["main"],
    "permissions": [
        "core:default",
        "core:window:default",
        "core:event:default",
        "fs:default",
        "dialog:default",
        "shell:default",
        "clipboard-manager:default",
        "notification:default",
        "global-shortcut:default",
        "store:default"
    ]
}
```
