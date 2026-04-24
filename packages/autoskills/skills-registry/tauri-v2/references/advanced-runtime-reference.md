# Tauri v2+ Advanced Runtime Reference

## Contents

- System Tray (`TrayIconBuilder`)
- Sidecars (External Binaries)
- Deep Links (`tauri-plugin-deep-link`)
- Custom Protocols

> Covers system tray integration, sidecar processes, deep links, and custom protocols.
> *Last verified: 2026-04-02. Check official Tauri v2+ docs for updates.*

**See also:**
- [plugin-reference.md](plugin-reference.md) — plugin installation and permissions
- [capabilities-reference.md](capabilities-reference.md) — capability/permission model

## Section 1: System Tray (`TrayIconBuilder`)

> **v2 Change:** `SystemTray` from v1 is replaced by `TrayIconBuilder` in v2. Do NOT use `SystemTray`.

```rust
// In lib.rs run() function, in setup hook:
use tauri::{
    tray::{MouseButton, MouseButtonState, TrayIconBuilder, TrayIconEvent},
    Manager,
};

tauri::Builder::default()
    .setup(|app| {
        let tray = TrayIconBuilder::new()
            .icon(app.default_window_icon().unwrap().clone())
            .tooltip("My App")
            .on_tray_icon_event(|tray, event| {
                if let TrayIconEvent::Click {
                    button: MouseButton::Left,
                    button_state: MouseButtonState::Up,
                    ..
                } = event
                {
                    let app = tray.app_handle();
                    if let Some(window) = app.get_webview_window("main") {
                        let _ = window.show();
                        let _ = window.set_focus();
                    }
                }
            })
            .build(app)?;
        Ok(())
    })
```

Show tray menu example:

```rust
use tauri::menu::{Menu, MenuItem};

let quit_item = MenuItem::with_id(app, "quit", "Quit", true, None::<&str>)?;
let menu = Menu::with_items(app, &[&quit_item])?;
let tray = TrayIconBuilder::new()
    .icon(app.default_window_icon().unwrap().clone())
    .menu(&menu)
    .on_menu_event(|app, event| match event.id.as_ref() {
        "quit" => app.exit(0),
        _ => {}
    })
    .build(app)?;
```

Platform notes:
- **macOS:** tray icon appears in menu bar; supports template images
- **Windows:** tray icon in system tray; click events differ from macOS
- **Linux:** tray support varies by desktop environment (requires `libappindicator` or `libayatana-appindicator`)

## Section 2: Sidecars (External Binaries)

Show config and usage for bundled executables:

```json
// tauri.conf.json
{
  "bundle": {
    "externalBin": [
      "binaries/my-sidecar"
    ]
  }
}
```

Capability permission required:

```json
{
  "permissions": [
    {
      "identifier": "shell:allow-execute",
      "allow": [
        { "name": "my-sidecar", "args": true, "sidecar": true }
      ]
    }
  ]
}
```

Rust code to execute sidecar:

```rust
use tauri_plugin_shell::ShellExt;

#[tauri::command]
async fn run_sidecar(app: tauri::AppHandle) -> Result<String, String> {
    let output = app.shell()
        .sidecar("my-sidecar")
        .map_err(|e| e.to_string())?
        .args(["--flag", "value"])
        .output()
        .await
        .map_err(|e| e.to_string())?;
    
    Ok(String::from_utf8_lossy(&output.stdout).to_string())
}
```

Binary naming convention (for cross-platform bundling):
- **macOS (Intel):** `my-sidecar-x86_64-apple-darwin`
- **macOS (ARM):** `my-sidecar-aarch64-apple-darwin`
- **Windows:** `my-sidecar-x86_64-pc-windows-msvc.exe`
- **Linux:** `my-sidecar-x86_64-unknown-linux-gnu`

## Section 3: Deep Links (`tauri-plugin-deep-link`)

```bash
cargo tauri add deep-link
```

Config in tauri.conf.json:

```json
{
  "plugins": {
    "deep-link": {
      "mobile": [
        { "scheme": "myapp" }
      ],
      "desktop": [
        { "schemes": ["myapp"] }
      ]
    }
  }
}
```

Capability:

```json
{ "permissions": ["deep-link:default"] }
```

Handling deep links in Rust:

```rust
use tauri_plugin_deep_link::DeepLinkExt;

app.deep_link().on_open_url(|event| {
    println!("Deep link: {:?}", event.urls());
});
```

Platform notes:
- **macOS:** registers URL scheme in Info.plist automatically
- **Windows:** registry entry created during install
- **Linux:** .desktop file update required
- **iOS/Android:** configure in respective platform files (AndroidManifest.xml or Info.plist)

## Section 4: Custom Protocols

> **Scope note:** Custom protocol (`tauri://` and custom schemes via `invoke_filter` or `asset_protocol`) is a more advanced feature. The primary official pattern is the built-in `asset` protocol for serving local files. Custom protocol handlers require careful security consideration.

Show asset protocol access (most common use case):

```json
// tauri.conf.json
{
  "app": {
    "security": {
      "assetScope": ["$APPDATA/assets/**", "$RESOURCE/**"]
    }
  }
}
```

```typescript
// Access local file via asset protocol
const imgSrc = convertFileSrc('/path/to/image.png');
```

Note: Full custom protocol registration (`tauri::Builder::register_uri_scheme_protocol`) is available but underdocumented in official v2+ docs as of 2026-04-02. Prefer asset protocol for local file serving.
