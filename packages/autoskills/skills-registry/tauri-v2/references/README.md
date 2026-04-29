# Tauri v2 References

Deep-dive reference documentation for Tauri v2 development. Use these when the main [`SKILL.md`](../SKILL.md) quick-start isn't enough.

## Reference Files

| File | Description | Key Topics |
|------|-------------|------------|
| [`capabilities-reference.md`](capabilities-reference.md) | **Security & Permissions** | Capability files, permissions, scopes, v1 vs v2 model |
| [`ipc-patterns.md`](ipc-patterns.md) | **IPC Decision Framework** | Commands vs Events vs Channels, typed `Channel<T>` |
| [`plugin-reference.md`](plugin-reference.md) | **Official Plugins** | Registration, JS package, and required capability permissions |
| [`updater-distribution-reference.md`](updater-distribution-reference.md) | **Updater & Distribution** | Signing, HTTPS endpoints, macOS/Windows/Linux packaging |
| [`advanced-runtime-reference.md`](advanced-runtime-reference.md) | **Advanced Runtime** | `TrayIconBuilder`, sidecars, deep links, custom protocols |

## Navigation Guide

- **New to Tauri v2 security?** → Start with [`capabilities-reference.md`](capabilities-reference.md) to understand the mandatory capability model.
- **Choosing an IPC method?** → See [`ipc-patterns.md`](ipc-patterns.md) for the "Commands vs Events vs Channels" decision matrix.
- **Adding a plugin?** → Check [`plugin-reference.md`](plugin-reference.md) for the specific permission strings you MUST add to your capabilities.
- **Shipping to production?** → See [`updater-distribution-reference.md`](updater-distribution-reference.md) for mandatory signing and update server requirements.
- **Tray icons, sidecars, or deep links?** → See [`advanced-runtime-reference.md`](advanced-runtime-reference.md) for v2-specific implementations.

*Last verified: 2026-04-02. Check [official Tauri changelog](https://github.com/tauri-apps/tauri/blob/dev/crates/tauri/CHANGELOG.md) for updates.*
