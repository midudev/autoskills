# Tauri v2+ Plugin Reference

## Contents

- General Installation Pattern
- File System
- Dialog
- Shell
- HTTP
- Store
- Clipboard Manager
- Notification
- Global Shortcut
- Updater
- Deep Link
- Opener
- Process

**Important:** Installing a plugin is not enough. Every plugin's permissions must be **explicitly granted** in a capability file under `src-tauri/capabilities/`. Without this, plugin calls will fail silently with permission errors.

*Last verified: 2026-04-02. Check the official plugin changelogs when install flow or permission names change.*

## General Installation Pattern

For most official plugins, the preferred installation method is using the Tauri CLI:

```bash
cargo tauri add <plugin-name>
```

This command automatically:
1. Adds the Rust crate to `src-tauri/Cargo.toml`.
2. Adds the JS/TS package to `package.json` (if applicable).
3. Registers the plugin in `src-tauri/src/lib.rs` (often requiring manual verification).

## 1. File System (`tauri-plugin-fs`)

Access the local file system.

**Install:**
```bash
cargo tauri add fs
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_fs::init())
```

**JS Package:** `@tauri-apps/plugin-fs`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["fs:default"]
}
```

**Common permissions:**
- `fs:allow-read-file`: Read file contents.
- `fs:allow-write-file`: Write/create files.
- `fs:allow-read-dir`: List directory contents.
- `fs:allow-exists`: Check if path exists.

**Scopes:**
Path access is restricted by scopes. Common variables: `$APPDATA`, `$HOME`, `$DOCUMENTS`, `$DOWNLOADS`.
**Cross-reference:** See [capabilities-reference.md](capabilities-reference.md) for scope examples.

## 2. Dialog (`tauri-plugin-dialog`)

Native system dialogs for file picking and messages.

**Install:**
```bash
cargo tauri add dialog
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_dialog::init())
```

**JS Package:** `@tauri-apps/plugin-dialog`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["dialog:default"]
}
```

**Common permissions:**
- `dialog:allow-open`: Open file/directory picker.
- `dialog:allow-save`: Save file picker.
- `dialog:allow-message`: Show message box.
- `dialog:allow-ask`: Show ask dialog (Yes/No).

## 3. Shell (`tauri-plugin-shell`)

Spawn child processes or open URLs.

**Install:**
```bash
cargo tauri add shell
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_shell::init())
```

**JS Package:** `@tauri-apps/plugin-shell`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["shell:default"]
}
```

**Common permissions:**
- `shell:allow-open`: Open URLs in default browser.
- `shell:allow-execute`: Execute arbitrary programs (requires heavy scoping).

**Scoping:**
`allow-execute` requires defining specific programs and allowed arguments in the capability file.
**Cross-reference:** See [capabilities-reference.md](capabilities-reference.md) for shell scope examples.

## 4. HTTP (`tauri-plugin-http`)

Perform HTTP requests from the Rust backend (bypassing CORS).

**Install:**
```bash
cargo tauri add http
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_http::init())
```

**JS Package:** `@tauri-apps/plugin-http`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["http:default"]
}
```

**Common permissions:**
- `http:default`: Basic request/response capabilities.

**Scoping:**
Access can be restricted to specific domains or URL patterns.
**Cross-reference:** See [capabilities-reference.md](capabilities-reference.md) for URL scope examples.

## 5. Store (`tauri-plugin-store`)

Simple key-value persistence.

**Install:**
```bash
cargo tauri add store
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_store::Builder::default().build())
```

**JS Package:** `@tauri-apps/plugin-store`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["store:default"]
}
```

**Common permissions:**
- `store:allow-get`: Retrieve values.
- `store:allow-set`: Save values.
- `store:allow-load`: Load store from disk.

## 6. Clipboard (`tauri-plugin-clipboard-manager`)

Read and write to the system clipboard.

**Install:**
```bash
cargo tauri add clipboard-manager
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_clipboard_manager::init())
```

**JS Package:** `@tauri-apps/plugin-clipboard-manager`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["clipboard-manager:default"]
}
```

**Common permissions:**
- `clipboard-manager:allow-read`: Read clipboard content.
- `clipboard-manager:allow-write`: Write to clipboard.

## 7. Notification (`tauri-plugin-notification`)

Send native desktop notifications.

**Install:**
```bash
cargo tauri add notification
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_notification::init())
```

**JS Package:** `@tauri-apps/plugin-notification`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["notification:default"]
}
```

**Common permissions:**
- `notification:allow-send`: Trigger notifications.
- `notification:allow-request-permission`: Check/ask for user permission.

## 8. Global Shortcut (`tauri-plugin-global-shortcut`)

Register system-wide keyboard shortcuts.

**Install:**
```bash
cargo tauri add global-shortcut
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_global_shortcut::Builder::new().build())
```

**JS Package:** `@tauri-apps/plugin-global-shortcut`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["global-shortcut:default"]
}
```

**Common permissions:**
- `global-shortcut:allow-register`: Register a new shortcut.
- `global-shortcut:allow-is-registered`: Check if a shortcut is active.

**Note:** Desktop only.

## 9. Updater (`tauri-plugin-updater`)

Automated application updates.

**Install:**
```bash
cargo tauri add updater
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_updater::Builder::new().build())
```

**JS Package:** `@tauri-apps/plugin-updater`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["updater:default"]
}
```

**Common permissions:**
- `updater:allow-check`: Check for updates.
- `updater:allow-download-and-install`: Execute update.

**Note:** Requires code signing and an update server/static JSON.
**Cross-reference:** See [updater-distribution-reference.md](updater-distribution-reference.md) for signing requirements.

## 10. Deep Link (`tauri-plugin-deep-link`)

Register and handle custom URL schemes (e.g., `myapp://`).

**Install:**
```bash
cargo tauri add deep-link
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_deep_link::init())
```

**JS Package:** `@tauri-apps/plugin-deep-link`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["deep-link:default"]
}
```

**Common permissions:**
- `deep-link:allow-get-current-url`: Retrieve the URL that launched the app.

## 11. Opener (`tauri-plugin-opener`)

Open files or URLs using the system's default applications. Replaces `shell:open` for many v2 use cases.

**Install:**
```bash
cargo tauri add opener
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_opener::init())
```

**JS Package:** `@tauri-apps/plugin-opener`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["opener:default"]
}
```

**Common permissions:**
- `opener:allow-open-url`: Open a website URL.
- `opener:allow-open-path`: Open a local file path with its associated app.

## 12. Process (`tauri-plugin-process`)

Control the application process (restart, exit).

**Install:**
```bash
cargo tauri add process
```

**Rust registration** (in `src-tauri/src/lib.rs`):
```rust
.plugin(tauri_plugin_process::init())
```

**JS Package:** `@tauri-apps/plugin-process`

**Capability permissions** (add to `src-tauri/capabilities/*.json`):
```json
{
  "permissions": ["process:default"]
}
```

**Common permissions:**
- `process:allow-restart`: Restart the app.
- `process:allow-exit`: Exit the app programmatically.

---

**See also:** [Capabilities Reference](capabilities-reference.md) for the security model | [Updater/Distribution](updater-distribution-reference.md) for the updater plugin deployment | [Advanced Runtime](advanced-runtime-reference.md) for tray, sidecar, and deep-link plugins
