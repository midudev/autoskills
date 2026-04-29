# Full Restructure: Extracting All Platform Entry Points

This guide covers the complete extraction of platform-specific entry points from a monolithic `composeApp` module into dedicated per-platform application modules. This is the most thorough migration path and results in a clean architecture where `shared` contains only cross-platform code.

---

## Target Architecture

```
shared/                    # KMP library (all shared code)
  build.gradle.kts         # kotlin.multiplatform + com.android.kotlin.multiplatform.library
  src/
    commonMain/kotlin/     # Shared business logic + UI
    androidMain/kotlin/    # Android expect/actual implementations
    iosMain/kotlin/        # iOS expect/actual implementations

androidApp/                # Android application entry point
  build.gradle.kts         # com.android.application
  src/main/

desktopApp/                # Desktop (JVM) application entry point
  build.gradle.kts         # org.jetbrains.compose + application {}
  src/main/kotlin/

webApp/                    # Wasm/JS web application entry point
  build.gradle.kts         # kotlin.multiplatform + wasmJs target
  src/wasmJsMain/kotlin/

iosApp/                    # iOS application (Xcode project, usually already separate)
  iosApp.xcodeproj/
```

---

## Desktop Extraction

### Create desktopApp/build.gradle.kts

```kotlin
plugins {
    alias(libs.plugins.kotlinJvm)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
}

dependencies {
    implementation(project(":shared"))
    implementation(compose.desktop.currentOs)
    implementation(compose.runtime)
    implementation(compose.foundation)
    implementation(compose.material3)
}

compose.desktop {
    application {
        mainClass = "com.example.app.MainKt"

        nativeDistributions {
            targetFormats(
                org.jetbrains.compose.desktop.application.dsl.TargetFormat.Dmg,
                org.jetbrains.compose.desktop.application.dsl.TargetFormat.Msi,
                org.jetbrains.compose.desktop.application.dsl.TargetFormat.Deb
            )
            packageName = "com.example.app"
            packageVersion = "1.0.0"

            macOS {
                iconFile.set(project.file("icons/icon.icns"))
            }
            windows {
                iconFile.set(project.file("icons/icon.ico"))
            }
            linux {
                iconFile.set(project.file("icons/icon.png"))
            }
        }
    }
}
```

### Move Desktop Entry Point

```
composeApp/src/desktopMain/kotlin/com/example/app/main.kt
  --> desktopApp/src/main/kotlin/com/example/app/main.kt
```

Update to call shared code:

```kotlin
// desktopApp/src/main/kotlin/com/example/app/main.kt
package com.example.app

import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import com.example.shared.App

fun main() = application {
    Window(
        onCloseRequest = ::exitApplication,
        title = "My App"
    ) {
        App()
    }
}
```

### Remove Desktop from shared

In `shared/build.gradle.kts`, remove the `jvm("desktop")` target entirely. The desktop target only needs to exist in `desktopApp`.

**Before (in composeApp):**
```kotlin
kotlin {
    jvm("desktop")
    // ...
    sourceSets {
        val desktopMain by getting {
            dependencies {
                implementation(compose.desktop.currentOs)
            }
        }
    }
}
compose.desktop {
    application {
        mainClass = "com.example.app.MainKt"
        nativeDistributions { ... }
    }
}
```

**After (in shared):**
```kotlin
kotlin {
    // jvm("desktop") -- REMOVED
    // No desktop target in shared module
    // No compose.desktop block
}
```

If you have shared JVM code that both Android and Desktop use, you have two options:
1. Keep a `jvm()` target in shared (without the `application {}` block) and use intermediate source sets.
2. Put all shared code in `commonMain` and rely on the JVM dependency from `desktopApp`.

---

## Web/WasmJS Extraction

### Create webApp/build.gradle.kts

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
}

kotlin {
    wasmJs {
        browser {
            commonWebpackConfig {
                outputFileName = "app.js"
            }
        }
        binaries.executable()
    }

    sourceSets {
        wasmJsMain.dependencies {
            implementation(project(":shared"))
            implementation(compose.runtime)
            implementation(compose.foundation)
            implementation(compose.material3)
            implementation(compose.ui)
        }
    }
}
```

### Move Web Entry Point

```
composeApp/src/wasmJsMain/kotlin/com/example/app/main.kt
  --> webApp/src/wasmJsMain/kotlin/com/example/app/main.kt
```

Update to call shared code:

```kotlin
// webApp/src/wasmJsMain/kotlin/com/example/app/main.kt
package com.example.app

import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.window.CanvasBasedWindow
import com.example.shared.App

@OptIn(ExperimentalComposeUiApi::class)
fun main() {
    CanvasBasedWindow(canvasElementId = "ComposeTarget") {
        App()
    }
}
```

### Move Web Resources

```
composeApp/src/wasmJsMain/resources/index.html
  --> webApp/src/wasmJsMain/resources/index.html
```

Update `index.html` if the output JS filename changed.

### Remove WasmJS from shared

In `shared/build.gradle.kts`, remove the `wasmJs {}` target:

```kotlin
kotlin {
    // wasmJs { ... } -- REMOVED
}
```

If you need shared Wasm-compatible code, keep `wasmJs()` in shared as a library target (no `binaries.executable()`, no `browser {}` config).

---

## iOS Handling

iOS is typically already a separate Xcode project. The main considerations during restructure:

### Framework Export Stays in shared

```kotlin
// shared/build.gradle.kts
kotlin {
    listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
        it.binaries.framework {
            baseName = "Shared"  // Update if renamed from "ComposeApp"
            isStatic = true
        }
    }
}
```

### Update Xcode Project

If the module was renamed from `composeApp` to `shared`:

1. **Framework import:** Change `import ComposeApp` to `import Shared` in all `.swift` files (must match `baseName` in the framework config).

2. **Gradle task path:** Update the Run Script build phase in `project.pbxproj` (or via Xcode > Build Phases):
   ```bash
   # In Xcode Build Phases > Run Script
   cd "$SRCROOT/.."
   ./gradlew :shared:embedAndSignAppleFrameworkForXcode
   ```

3. **App struct name:** If the SwiftUI `@main` struct was named after the old module (e.g., `ComposeAppApp`), rename it to something appropriate for your project.

4. **Framework search paths:** Update Build Settings if they reference the old module directory path.

5. **Cocoapods (if used):** Update the pod spec name:
   ```kotlin
   // shared/build.gradle.kts
   kotlin {
       cocoapods {
           name = "Shared"
           summary = "Shared KMP module"
           // ...
       }
   }
   ```

---

## Module Rename: composeApp to shared

### 1. Rename the Directory

```bash
mv composeApp shared
```

### 2. Update settings.gradle.kts

```kotlin
// Before
include(":composeApp")

// After
include(":shared")
include(":androidApp")
include(":desktopApp")
include(":webApp")
```

### 3. Update Cross-Module Dependencies

Search all `build.gradle.kts` files for references to `:composeApp`:

```kotlin
// Before
implementation(project(":composeApp"))

// After
implementation(project(":shared"))
```

### 4. Update .idea / Workspace Files

If using IntelliJ/Android Studio, the IDE may cache the old module name. Either:
- Delete `.idea/` and re-import
- Or manually update `.idea/modules.xml` and related files

---

## Variant: Native UI (sharedLogic + sharedUI Split)

For projects where each platform has its own native UI and only business logic is shared:

```
sharedLogic/                # Pure KMP library (no Compose)
  build.gradle.kts          # kotlin.multiplatform + com.android.kotlin.multiplatform.library
  src/
    commonMain/kotlin/      # ViewModels, repositories, models, networking
    androidMain/kotlin/     # Android-specific implementations
    iosMain/kotlin/         # iOS-specific implementations

sharedUI/                   # Optional: Compose Multiplatform UI
  build.gradle.kts          # kotlin.multiplatform + com.android.kotlin.multiplatform.library + compose
  src/
    commonMain/kotlin/      # Shared composables
    androidMain/kotlin/     # Android-specific composables

androidApp/                 # Native Android app
  build.gradle.kts
  src/main/                 # Android UI (Compose or XML), depends on sharedLogic (and optionally sharedUI)

iosApp/                     # Native iOS app (SwiftUI/UIKit)
  # Depends on sharedLogic framework
```

### sharedLogic/build.gradle.kts

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidKmpLibrary)
}

kotlin {
    android {
        namespace = "com.example.shared.logic"
        compileSdk = 35
        minSdk = 24
    }

    iosX64()
    iosArm64()
    iosSimulatorArm64()

    listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
        it.binaries.framework {
            baseName = "SharedLogic"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines.core)
            implementation(libs.ktor.client.core)
            implementation(libs.kotlinx.serialization.json)
        }
    }
}
```

This variant is useful when:
- iOS uses SwiftUI and does not want Compose Multiplatform
- Desktop is not a target
- You want to minimize the shared surface area

---

## Variant: Server (Backend Module)

For projects that include a Ktor/Spring server:

```
shared/                     # KMP library (shared models, API contracts)
androidApp/
iosApp/
server/                     # JVM server application
  build.gradle.kts          # kotlin("jvm") + ktor/spring plugin
  src/main/kotlin/
```

### server/build.gradle.kts

```kotlin
plugins {
    alias(libs.plugins.kotlinJvm)
    alias(libs.plugins.ktor)         // or spring boot
    application
}

application {
    mainClass.set("com.example.server.ApplicationKt")
}

dependencies {
    implementation(project(":shared"))
    implementation(libs.ktor.server.core)
    implementation(libs.ktor.server.netty)
    implementation(libs.logback.classic)
}
```

The server module is a plain JVM module. It depends on `:shared` for common models and API contracts. It is unaffected by the AGP 9.0 migration except that:
- If shared previously had a `jvm()` target that the server depended on, verify it still exists after restructuring.
- If shared was renamed, update the dependency path.

---

## settings.gradle.kts -- Final State

```kotlin
rootProject.name = "MyProject"

pluginManagement {
    repositories {
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }
}

include(":shared")
include(":androidApp")
include(":desktopApp")
include(":webApp")
// include(":server")    // if applicable
```

---

## Quick Checklist

- [ ] Create `androidApp/` with pure Android application plugin (see MIGRATION-APP-SPLIT.md)
- [ ] Create `desktopApp/` with compose desktop plugin and `application {}` block
- [ ] Create `webApp/` with wasmJs target and `binaries.executable()`
- [ ] Move `main()` functions from `composeApp/src/{platform}Main/` to respective app modules
- [ ] Move `compose.desktop.application {}` config to `desktopApp`
- [ ] Move `wasmJs { browser {} }` config to `webApp`
- [ ] Rename `composeApp` to `shared`
- [ ] Convert shared to KMP library plugin (`com.android.kotlin.multiplatform.library`)
- [ ] Remove platform app targets from shared (keep only library targets)
- [ ] Update all `settings.gradle.kts` includes
- [ ] Update all `project(":composeApp")` references to `project(":shared")`
- [ ] Update Xcode project (framework name, Gradle task path, Swift imports)
- [ ] Verify each app module builds independently
- [ ] Run all platform targets to confirm functionality
