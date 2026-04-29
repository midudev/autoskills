# Tauri v2+ Updater & Distribution Reference

## Contents

- Part 1: Updater (tauri-plugin-updater)
- Part 2: Distribution and Signing
- Part 3: Bundle Configuration

> ⚠️ **Signing is MANDATORY for production updates.** Unsigned artifacts will be rejected by the Tauri updater. Production update endpoints MUST use HTTPS.

## Part 1: Updater (tauri-plugin-updater)

### Install
```bash
cargo tauri add updater
```

### Configuration (tauri.conf.json)
```json
{
  "plugins": {
    "updater": {
      "active": true,
      "endpoints": ["https://your-server.com/update/{{target}}/{{current_version}}"],
      "pubkey": "BASE64_PUBLIC_KEY_HERE",
      "dialog": true
    }
  }
}
```
- **Endpoints:** Array of HTTPS URLs.
- **Pubkey:** Base64 encoded public key.
- **Dialog:** Boolean to show built-in update dialog.
- **HTTPS:** Endpoints MUST be HTTPS in production.

### Key Generation
```bash
cargo tauri signer generate -w ~/.tauri/myapp.key
```
Outputs: private key file + public key string.
- Store private key SECURELY. Never commit to repo.
- Set `TAURI_SIGNING_PRIVATE_KEY` env var for CI/CD.
- Set `TAURI_SIGNING_PRIVATE_KEY_PASSWORD` if key is encrypted.
- Add pubkey to `tauri.conf.json` `plugins.updater.pubkey`.

### Signed Build
```bash
TAURI_SIGNING_PRIVATE_KEY=... cargo tauri build
```
Produces: installer file + `.sig` signature file.
Both files must be served from your update server.

### Update Server Response Format
The update endpoint must return this JSON format:
```json
{
  "version": "1.0.1",
  "notes": "Bug fixes",
  "pub_date": "2026-04-02T00:00:00Z",
  "platforms": {
    "darwin-aarch64": {
      "signature": "<content of .sig file>",
      "url": "https://your-server/MyApp_1.0.1_aarch64.dmg"
    },
    "windows-x86_64": {
      "signature": "<content of .sig file>",
      "url": "https://your-server/MyApp_1.0.1_x64-setup.exe"
    }
  }
}
```

### Capability Permission
The updater plugin requires capability permission: `updater:default`

### Checking for Updates in Code
```rust
use tauri_plugin_updater::UpdaterExt;

#[tauri::command]
async fn check_for_updates(app: tauri::AppHandle) -> Result<String, String> {
    let update = app.updater().map_err(|e| e.to_string())?
        .check().await.map_err(|e| e.to_string())?;
    
    if let Some(update) = update {
        update.download_and_install(|_, _| {}, || {})
            .await.map_err(|e| e.to_string())?;
        Ok("Updated".to_string())
    } else {
        Ok("Already up to date".to_string())
    }
}
```

## Part 2: Distribution and Signing

### macOS
- Code signing requires Apple Developer certificate.
- Notarization required for distribution outside Mac App Store.
- **Environment vars:** `APPLE_CERTIFICATE`, `APPLE_CERTIFICATE_PASSWORD`, `APPLE_SIGNING_IDENTITY`, `APPLE_ID`, `APPLE_PASSWORD`, `APPLE_TEAM_ID`.
- Command: `cargo tauri build` handles signing/notarization with env vars set.
- **Bundle type:** `.dmg`, `.app`.
- macOS bundles for arm64 (Apple Silicon) and x86_64 are separate.

### Windows
- Code signing requires a code signing certificate (EV or OV).
- Without signing, SmartScreen warnings appear for users.
- Self-signed certs are only suitable for development.
- **Env vars for signing:** via `TAURI_WINDOWS_SIGNING_CERTIFICATE` or custom script.
- **Bundle types:** `.msi` (WiX), `.exe` (NSIS).
- `bundle.windows.certificateThumbprint` in `tauri.conf.json` for direct cert config.

### Linux
- No mandatory code signing, but packaging for distros matters.
- **Bundle types:** `.deb` (Debian/Ubuntu), `.rpm` (Fedora/RHEL), `.AppImage` (universal).
- AppImage is portable but unsigned.
- For store distribution: use appropriate store SDK.

## Part 3: Bundle Configuration
Key `bundle` section in `tauri.conf.json`:
```json
{
  "bundle": {
    "active": true,
    "targets": "all",
    "identifier": "com.example.myapp",
    "icon": ["icons/32x32.png", "icons/icon.icns", "icons/icon.ico"],
    "resources": [],
    "copyright": "",
    "category": "Utility",
    "shortDescription": "",
    "longDescription": ""
  }
}
```

> *Last verified: 2026-04-02. Check the [updater plugin changelog](https://github.com/tauri-apps/plugins-workspace/blob/v2/plugins/updater/CHANGELOG.md) for any updates to the signing/key format.*
