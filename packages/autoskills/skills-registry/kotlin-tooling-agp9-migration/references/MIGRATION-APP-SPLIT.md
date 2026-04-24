# Splitting a KMP + Android Application Module for AGP 9.0

AGP 9.0 does not support `com.android.application` combined with `org.jetbrains.kotlin.multiplatform` in the same module. You must split the monolithic `composeApp` module into a pure Android application module and a KMP shared library module.

---

## Old Structure (AGP 8.x)

```
composeApp/
  build.gradle.kts          # com.android.application + kotlin.multiplatform
  src/
    commonMain/kotlin/       # Shared KMP code
    androidMain/kotlin/      # Android-specific code + MainActivity
    androidMain/res/         # Android resources
    androidMain/AndroidManifest.xml
    iosMain/kotlin/          # iOS-specific code
    desktopMain/kotlin/      # Desktop entry point (optional)
```

Single `composeApp/build.gradle.kts`:

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
}

kotlin {
    androidTarget {
        compilations.all {
            kotlinOptions { jvmTarget = "11" }
        }
    }
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
        it.binaries.framework {
            baseName = "ComposeApp"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation(compose.runtime)
            implementation(compose.foundation)
            implementation(compose.material3)
            implementation(compose.ui)
            implementation(libs.kotlinx.coroutines.core)
        }
        androidMain.dependencies {
            implementation(libs.androidx.activity.compose)
            implementation(libs.compose.ui.tooling.preview)
        }
    }
}

android {
    namespace = "com.example.app"
    compileSdk = 34
    defaultConfig {
        applicationId = "com.example.app"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    buildFeatures { compose = true }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    debugImplementation(libs.compose.ui.tooling)
}
```

---

## New Structure (AGP 9.x)

```
shared/
  build.gradle.kts           # kotlin.multiplatform + com.android.kotlin.multiplatform.library
  src/
    commonMain/kotlin/        # All shared KMP code
    androidMain/kotlin/       # Android-specific implementations (expect/actual)
    androidMain/res/          # Shared Android resources (if any)
    iosMain/kotlin/           # iOS-specific code

androidApp/
  build.gradle.kts           # com.android.application ONLY (no kotlin.multiplatform)
  src/
    main/kotlin/              # MainActivity, Application class
    main/res/                 # App-level resources (launcher icons, themes, etc.)
    main/AndroidManifest.xml  # Full manifest with <application> and <activity>

iosApp/                       # Unchanged
```

---

## androidApp/build.gradle.kts

**Important:** In AGP 9.0, the `com.android.application` plugin has Kotlin support built in. Do NOT apply `org.jetbrains.kotlin.android` separately -- it will conflict.

```kotlin
plugins {
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.composeCompiler)
}

android {
    namespace = "com.example.app"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.app"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    buildFeatures {
        compose = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    implementation(project(":shared"))
    implementation(libs.androidx.activity.compose)
    implementation(libs.compose.ui.tooling.preview)
    debugImplementation(libs.compose.ui.tooling)
}
```

### Key Points for androidApp

- **No `kotlin.multiplatform` plugin.** This is a pure Android application module.
- **No `kotlin-android` plugin.** AGP 9.0's `com.android.application` plugin bundles Kotlin compilation. Applying `org.jetbrains.kotlin.android` will cause a conflict error.
- **`buildTypes` and `productFlavors` work here.** The application plugin still supports full variant configuration.
- **Compose compiler plugin** is applied separately (`composeCompiler`), or it can come from KGP 2.0+ if you use the compose compiler Gradle plugin.
- **Depends on `:shared`** to access all shared KMP code.

---

## shared/build.gradle.kts

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidKmpLibrary)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
}

kotlin {
    android {
        namespace = "com.example.shared"
        compileSdk = 35
        minSdk = 24

        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }

        androidResources { enable = true }
    }

    iosX64()
    iosArm64()
    iosSimulatorArm64()

    listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
        it.binaries.framework {
            baseName = "Shared"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation(compose.runtime)
            implementation(compose.foundation)
            implementation(compose.material3)
            implementation(compose.ui)
            implementation(libs.kotlinx.coroutines.core)
        }
        androidMain.dependencies {
            // Android-specific shared dependencies only
        }
    }
}
```

### Key Points for shared

- **Plugin is `com.android.kotlin.multiplatform.library`**, not `com.android.library`.
- **Namespace must differ from androidApp.** Use `com.example.shared` vs `com.example.app`.
- **No `applicationId`, `versionCode`, `versionName`, `targetSdk`.** These are application-only concepts.
- **No `buildTypes` or `productFlavors`.** The KMP library plugin produces a single variant.
- **Framework exports** (`binaries.framework`) stay here since iOS depends on the shared module.
- **`androidTarget {}`** is replaced with **`android {}`**.

---

## settings.gradle.kts Changes

### Before

```kotlin
rootProject.name = "MyProject"
include(":composeApp")
include(":iosApp") // if present as a Gradle module
```

### After

```kotlin
rootProject.name = "MyProject"
include(":shared")
include(":androidApp")
include(":iosApp")
```

---

## Root build.gradle.kts Changes

### With Version Catalog

**Before:**
```kotlin
plugins {
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
    alias(libs.plugins.composeMultiplatform) apply false
    alias(libs.plugins.composeCompiler) apply false
}
```

**After:**
```kotlin
plugins {
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidKmpLibrary) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
    alias(libs.plugins.composeMultiplatform) apply false
    alias(libs.plugins.composeCompiler) apply false
}
```

### Without Version Catalog

**Before:**
```kotlin
plugins {
    id("com.android.application") version "8.7.3" apply false
    id("com.android.library") version "8.7.3" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.1.0" apply false
    id("org.jetbrains.compose") version "1.7.0" apply false
    id("org.jetbrains.kotlin.plugin.compose") version "2.1.0" apply false
}
```

**After:**
```kotlin
plugins {
    id("com.android.application") version "9.0.1" apply false
    id("com.android.kotlin.multiplatform.library") version "9.0.1" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.3.20" apply false
    id("org.jetbrains.compose") version "1.10.3" apply false
    id("org.jetbrains.kotlin.plugin.compose") version "2.3.20" apply false
}
```

Note: `com.android.library` is replaced with `com.android.kotlin.multiplatform.library`. If you still have pure Android library modules (non-KMP), you can keep `com.android.library` as well.

---

## What to Move to androidApp

These items are Android application concerns and must move out of the shared KMP module:

### 1. MainActivity (and any other Activities)

```
composeApp/src/androidMain/kotlin/com/example/app/MainActivity.kt
  --> androidApp/src/main/kotlin/com/example/app/MainActivity.kt
```

Update `MainActivity` to call into shared code:

```kotlin
// androidApp/src/main/kotlin/com/example/app/MainActivity.kt
package com.example.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.example.shared.App  // Import from shared module

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            App()  // Shared composable
        }
    }
}
```

### 2. AndroidManifest.xml

The full application manifest with `<application>`, `<activity>`, `<intent-filter>` moves to androidApp:

```
composeApp/src/androidMain/AndroidManifest.xml
  --> androidApp/src/main/AndroidManifest.xml
```

**Important:** After moving the manifest, verify the `android:name` attribute on `<activity>` points to the correct Activity class in its new location. If the old manifest relied on a default or short class name, you may need to use the fully qualified name:

```xml
<activity
    android:name="com.example.app.MainActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
```

The shared module may still have a minimal manifest (auto-generated or containing just `<manifest>` with no `<application>`).

### 3. Application Class (if any)

```
composeApp/src/androidMain/kotlin/.../MyApplication.kt
  --> androidApp/src/main/kotlin/.../MyApplication.kt
```

### 4. App-Level Resources

- Launcher icons (`mipmap-*`)
- App theme definitions that reference `applicationId`
- Splash screen resources
- Navigation graphs (if not shared)

```
composeApp/src/androidMain/res/mipmap-*/
composeApp/src/androidMain/res/values/themes.xml  (app-level theme)
  --> androidApp/src/main/res/
```

### 5. ProGuard Rules

```
composeApp/proguard-rules.pro
  --> androidApp/proguard-rules.pro
```

---

## What Stays in shared

- All `commonMain` code (ViewModels, repositories, models, shared composables)
- All `expect`/`actual` declarations
- All `iosMain`, `desktopMain`, `wasmJsMain` code
- Framework export configuration (`binaries.framework`)
- Shared Android resources (strings, drawables used by shared composables)
- Shared Android-specific implementations (`actual` functions)

---

## Namespace Requirements

The `namespace` for each module must be unique:

```kotlin
// shared/build.gradle.kts
kotlin {
    android {
        namespace = "com.example.shared"
    }
}

// androidApp/build.gradle.kts
android {
    namespace = "com.example.app"
}
```

If they collide, you will get duplicate R class errors at compile time. The `applicationId` (in androidApp only) can be different from both namespaces.

---

## Run Configuration Updates

### Android Studio

After the split, the run configuration for the Android app must point to `:androidApp` instead of `:composeApp`:

1. Edit Run Configurations
2. Change Module to `androidApp`
3. Ensure the launch activity is `com.example.app.MainActivity`

### Xcode (iOS)

If the shared module was renamed from `composeApp` to `shared`:

1. **Update `baseName` in `shared/build.gradle.kts`** to match the new module name:
   ```kotlin
   listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
       it.binaries.framework {
           baseName = "Shared"  // was "ComposeApp"
           isStatic = true
       }
   }
   ```

2. **Update the Run Script build phase** in `project.pbxproj` (or via Xcode > Build Phases > Run Script) to reference the new module:
   ```bash
   # Old
   cd "$SRCROOT/.."
   ./gradlew :composeApp:embedAndSignAppleFrameworkForXcode

   # New
   cd "$SRCROOT/.."
   ./gradlew :shared:embedAndSignAppleFrameworkForXcode
   ```

3. **Update Swift imports** — in all `.swift` files, change the framework import to match `baseName`:
   ```swift
   // Old
   import ComposeApp

   // New
   import Shared
   ```

4. **Update the app struct name** if it was tied to the old module name. The `@main` struct name in your SwiftUI app entry point is independent of the framework name, but if it referenced the old name, rename it:
   ```swift
   // Example: rename if it was called ComposeAppApp or similar
   @main
   struct MyApp: App {
       var body: some Scene {
           WindowGroup {
               ContentView()
           }
       }
   }
   ```

5. **Update framework search paths** in Xcode Build Settings if they reference the old module directory path.

---

## Quick Checklist

- [ ] Create `androidApp/` directory with `build.gradle.kts`
- [ ] Move `MainActivity` and `Application` class to `androidApp`
- [ ] Move `AndroidManifest.xml` (full manifest) to `androidApp`
- [ ] Move app-level resources (launcher icons, app theme) to `androidApp`
- [ ] Move ProGuard rules to `androidApp`
- [ ] Convert `composeApp` to `shared` with KMP library plugin
- [ ] Remove application-only config (`applicationId`, `versionCode`, `buildTypes`) from shared
- [ ] Add `implementation(project(":shared"))` to androidApp dependencies
- [ ] Update `settings.gradle.kts` includes
- [ ] Update root `build.gradle.kts` plugin declarations
- [ ] Ensure namespaces are different between modules
- [ ] Update Android Studio run configuration
- [ ] Update Xcode project if iOS target exists
- [ ] Run `./gradlew :androidApp:assembleDebug` and `./gradlew :shared:assemble` to verify
