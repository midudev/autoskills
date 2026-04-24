# Tauri v2+ IPC Patterns Reference

## Contents

- Overview
- IPC Decision Framework
- Commands (invoke)
- Events
- Typed Streaming Channels
- State Management
- Error Handling Across IPC
- Window Access and App Handles
- IPC Selection Guide

## Overview

Tauri v2+ provides three IPC primitives:
1. **Commands**: Request-response (most common)
2. **Events**: Fire-and-forget notifications
3. **Channels**: High-frequency streaming

**See also:** [Capabilities Reference](capabilities-reference.md) for permission setup | [Plugin Reference](plugin-reference.md) for plugin-specific IPC

*Last verified: 2026-04-02. Check the official Tauri changelog when IPC API timing matters.*

## IPC Decision Framework

### Commands: Request-Response
Use `invoke()` when:
- Frontend needs data from Rust (fetch, compute, query)
- Frontend triggers an action and needs a result
- Error handling is needed (returns `Result<T, E>`)
- **Direction: Frontend → Rust → Frontend** (request/response)

### Events: Fire-and-Forget Notifications
Use `emit()`/`listen()` when:
- Rust needs to notify frontend of a background event
- Multiple windows need to receive the same notification
- Broadcasting state changes that don't require acknowledgment
- **Direction: Bidirectional** (but one-way per emit)
- **Important:** Events are fire-and-forget — there is NO acknowledgment or response channel

### Channels: Typed Streaming
Use `Channel<T>` when:
- High-frequency progress updates from a long-running operation
- Streaming data from Rust to frontend
- Strongly typed discriminated message streams
- **Direction: Rust → Frontend** (streaming only)
- **Key difference from Events:** Channels are scoped to a single command invocation; events are global

## Commands (invoke)

### Basic Command

**Rust:**
```rust
#[tauri::command]
fn greet(name: String) -> String {
    format!("Hello, {}!", name)
}

// Register in builder
tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![greet])
```

**Frontend:**
```typescript
import { invoke } from '@tauri-apps/api/core';

const result = await invoke<string>('greet', { name: 'World' });
```

### Command with Multiple Arguments

**Rust:**
```rust
#[tauri::command]
fn calculate(a: i32, b: i32, operation: String) -> i32 {
    match operation.as_str() {
        "add" => a + b,
        "sub" => a - b,
        "mul" => a * b,
        "div" => a / b,
        _ => 0,
    }
}
```

**Frontend:**
```typescript
const result = await invoke<number>('calculate', {
    a: 10,
    b: 5,
    operation: 'add'
});
```

### Async Command

**Rust:**
```rust
#[tauri::command]
async fn fetch_data(url: String) -> Result<String, String> {
    // Use owned types (String, not &str) in async commands
    let response = reqwest::get(&url)
        .await
        .map_err(|e| e.to_string())?;

    response.text()
        .await
        .map_err(|e| e.to_string())
}
```

**Frontend:**
```typescript
try {
    const data = await invoke<string>('fetch_data', { url: 'https://api.example.com' });
} catch (error) {
    console.error('Failed:', error);
}
```

### Command with Result Error Handling

**Rust:**
```rust
use thiserror::Error;

#[derive(Debug, Error)]
enum AppError {
    #[error("File not found: {0}")]
    NotFound(String),
    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),
    #[error("Permission denied")]
    PermissionDenied,
}

impl serde::Serialize for AppError {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where S: serde::ser::Serializer {
        serializer.serialize_str(self.to_string().as_ref())
    }
}

#[tauri::command]
fn read_config(path: String) -> Result<Config, AppError> {
    if !std::path::Path::new(&path).exists() {
        return Err(AppError::NotFound(path));
    }
    // ...
}
```

**Frontend:**
```typescript
try {
    const config = await invoke<Config>('read_config', { path: '/config.json' });
} catch (error) {
    // error is the serialized error string
    console.error('Config error:', error);
}
```

### Command with State

**Rust:**
```rust
use std::sync::Mutex;
use tauri::State;

struct AppState {
    counter: u32,
    items: Vec<String>,
}

#[tauri::command]
fn get_count(state: State<'_, Mutex<AppState>>) -> u32 {
    state.lock().unwrap().counter
}

#[tauri::command]
fn increment(state: State<'_, Mutex<AppState>>) -> u32 {
    let mut s = state.lock().unwrap();
    s.counter += 1;
    s.counter
}

#[tauri::command]
fn add_item(item: String, state: State<'_, Mutex<AppState>>) {
    state.lock().unwrap().items.push(item);
}

// In builder:
tauri::Builder::default()
    .manage(Mutex::new(AppState { counter: 0, items: vec![] }))
    .invoke_handler(tauri::generate_handler![get_count, increment, add_item])
```

### Command with Window Access

**Rust:**
```rust
use tauri::{WebviewWindow, AppHandle};

#[tauri::command]
fn get_window_info(window: WebviewWindow) -> String {
    format!("Window label: {}", window.label())
}

#[tauri::command]
fn create_window(app: AppHandle) -> Result<(), String> {
    tauri::WebviewWindowBuilder::new(
        &app,
        "new-window",
        tauri::WebviewUrl::App("index.html".into())
    )
    .title("New Window")
    .build()
    .map_err(|e| e.to_string())?;
    Ok(())
}
```

### Command with Raw Binary Data

**Rust:**
```rust
use tauri::ipc::Response;

#[tauri::command]
fn read_binary_file(path: String) -> Result<Response, String> {
    let data = std::fs::read(&path).map_err(|e| e.to_string())?;
    Ok(Response::new(data)) // Avoids JSON serialization overhead
}

#[tauri::command]
fn upload_file(request: tauri::ipc::Request) -> Result<(), String> {
    let tauri::ipc::InvokeBody::Raw(data) = request.body() else {
        return Err("Expected raw body".into());
    };
    std::fs::write("upload.bin", data).map_err(|e| e.to_string())
}
```

**Frontend:**
```typescript
// Reading binary
const data = await invoke<ArrayBuffer>('read_binary_file', { path: '/file.bin' });

// Uploading binary
const fileData = new Uint8Array([1, 2, 3, 4]);
await invoke('upload_file', fileData);
```

---

## Events

> **Trait imports required:** `use tauri::Emitter;` to call `.emit()` on `AppHandle`/`WebviewWindow`. `use tauri::Listener;` to call `.listen()` on `App`/`AppHandle`. These traits must be in scope.

### Emit from Rust to Frontend

**Rust:**
```rust
use tauri::Emitter;

#[tauri::command]
fn start_background_task(app: tauri::AppHandle) {
    std::thread::spawn(move || {
        for i in 0..100 {
            std::thread::sleep(std::time::Duration::from_millis(100));
            app.emit("progress", i).unwrap();
        }
        app.emit("complete", "Task finished").unwrap();
    });
}

// Emit to specific window
#[tauri::command]
fn notify_window(app: tauri::AppHandle, window_label: String, message: String) {
    app.emit_to(&window_label, "notification", message).unwrap();
}
```

**Frontend:**
```typescript
import { listen, once } from '@tauri-apps/api/event';

// Listen continuously
const unlisten = await listen<number>('progress', (event) => {
    console.log(`Progress: ${event.payload}%`);
});

// Listen once
await once<string>('complete', (event) => {
    console.log(event.payload);
});

// Clean up when done
unlisten();
```

### Emit from Frontend to Rust

**Frontend:**
```typescript
import { emit } from '@tauri-apps/api/event';

await emit('user-action', { action: 'click', target: 'button' });
```

**Rust (in setup or command):**
```rust
use tauri::Listener;

fn setup_listeners(app: &tauri::App) {
    app.listen("user-action", |event| {
        println!("User action: {:?}", event.payload());
    });
}
```

### Window-Specific Events

**Rust:**
```rust
use tauri::{Emitter, WebviewWindow};

#[tauri::command]
fn emit_to_window(window: WebviewWindow, message: String) {
    window.emit("window-message", message).unwrap();
}
```

---

## Typed Streaming Channels

`Channel<TSend>` is a typed streaming primitive. The type parameter `TSend` defines what messages can be sent. Both Rust and TypeScript must agree on the shape:
- Rust: `Channel<MyEvent>` where `MyEvent: serde::Serialize + Clone`
- Frontend: `new Channel<MyEvent>()` with matching TypeScript type
- Use `#[serde(tag = "event", content = "data")]` on enums for discriminated union patterns.

**Rust:**
```rust
use tauri::ipc::Channel;

#[derive(Clone, serde::Serialize)]
struct ProgressUpdate {
    current: u32,
    total: u32,
    message: String,
}

#[tauri::command]
async fn process_files(
    files: Vec<String>,
    on_progress: Channel<ProgressUpdate>
) -> Result<(), String> {
    let total = files.len() as u32;

    for (i, file) in files.iter().enumerate() {
        // Process file...
        on_progress.send(ProgressUpdate {
            current: i as u32 + 1,
            total,
            message: format!("Processing {}", file),
        }).unwrap();
    }

    Ok(())
}
```

**Frontend:**
```typescript
import { invoke, Channel } from '@tauri-apps/api/core';

interface ProgressUpdate {
    current: number;
    total: number;
    message: string;
}

const channel = new Channel<ProgressUpdate>();
channel.onmessage = (update) => {
    const percent = (update.current / update.total) * 100;
    console.log(`${percent}% - ${update.message}`);
};

await invoke('process_files', {
    files: ['file1.txt', 'file2.txt'],
    onProgress: channel
});
```

### Tagged Union Events (Discriminated)

**Rust:**
```rust
use tauri::ipc::Channel;

#[derive(Clone, serde::Serialize)]
#[serde(tag = "event", content = "data")]
enum DownloadEvent {
    Started { url: String, size: u64 },
    Progress { downloaded: u64, total: u64 },
    Complete { path: String },
    Error { message: String },
}

#[tauri::command]
async fn download_file(
    url: String,
    on_event: Channel<DownloadEvent>
) -> Result<String, String> {
    on_event.send(DownloadEvent::Started {
        url: url.clone(),
        size: 1000,
    }).unwrap();

    for i in 0..=100 {
        on_event.send(DownloadEvent::Progress {
            downloaded: i * 10,
            total: 1000,
        }).unwrap();
        tokio::time::sleep(std::time::Duration::from_millis(10)).await;
    }

    let path = "/downloads/file.zip".to_string();
    on_event.send(DownloadEvent::Complete {
        path: path.clone(),
    }).unwrap();

    Ok(path)
}
```

**Frontend:**
```typescript
import { invoke, Channel } from '@tauri-apps/api/core';

type DownloadEvent =
    | { event: 'Started'; data: { url: string; size: number } }
    | { event: 'Progress'; data: { downloaded: number; total: number } }
    | { event: 'Complete'; data: { path: string } }
    | { event: 'Error'; data: { message: string } };

const channel = new Channel<DownloadEvent>();
channel.onmessage = (msg) => {
    switch (msg.event) {
        case 'Started':
            console.log(`Starting download: ${msg.data.url} (${msg.data.size} bytes)`);
            break;
        case 'Progress':
            const percent = (msg.data.downloaded / msg.data.total) * 100;
            console.log(`Download: ${percent.toFixed(1)}%`);
            break;
        case 'Complete':
            console.log(`Downloaded to: ${msg.data.path}`);
            break;
        case 'Error':
            console.error(`Download failed: ${msg.data.message}`);
            break;
    }
};

const path = await invoke<string>('download_file', {
    url: 'https://example.com/file.zip',
    onEvent: channel
});
```

---

## IPC Selection Guide

| Pattern | Use Case | Direction | Frequency |
|---------|----------|-----------|-----------|
| **Commands** | Request-response, data fetching | Frontend → Rust | One-time |
| **Events** | Notifications, state changes | Bidirectional | Low-medium |
| **Channels** | Progress updates, streaming data | Rust → Frontend | High |

### When to Use Each

**Commands (invoke)**
- Fetching data from Rust
- Performing actions that return results
- CRUD operations
- Most common pattern

**Events (emit/listen)**
- Notifying UI of background changes
- Broadcasting to multiple windows
- Fire-and-forget notifications
- System events (window close, minimize)

**Channels**
- File download/upload progress
- Long-running operations with updates
- Streaming log output
- Real-time data feeds
