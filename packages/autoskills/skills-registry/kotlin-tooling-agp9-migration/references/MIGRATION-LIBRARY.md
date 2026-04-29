# Migrating a KMP Library Module to AGP 9.0

This reference covers the full migration of a Kotlin Multiplatform library module from `com.android.library` (AGP 8.x) to `com.android.kotlin.multiplatform.library` (AGP 9.x).

---

## build.gradle.kts -- Before (AGP 8.x)

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
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

    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines.core)
        }
        androidMain.dependencies {
            implementation(libs.androidx.appcompat)
        }
    }
}

android {
    namespace = "com.example.shared"
    compileSdk = 34
    defaultConfig { minSdk = 24 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    debugImplementation(libs.compose.ui.tooling)
}
```

## build.gradle.kts -- After (AGP 9.x)

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidKmpLibrary)
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

    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines.core)
        }
        androidMain.dependencies {
            implementation(libs.androidx.appcompat)
        }
    }
}

dependencies {
    androidRuntimeClasspath(libs.compose.ui.tooling)
}
```

---

## Version and Plugin Changes

### With Version Catalog (`gradle/libs.versions.toml`)

**Before:**
```toml
[versions]
agp = "8.7.3"
kotlin = "2.1.0"

[plugins]
androidLibrary = { id = "com.android.library", version.ref = "agp" }
kotlinMultiplatform = { id = "org.jetbrains.kotlin.multiplatform", version.ref = "kotlin" }
```

**After:**
```toml
[versions]
agp = "9.0.1"
kotlin = "2.3.20"

[plugins]
androidKmpLibrary = { id = "com.android.kotlin.multiplatform.library", version.ref = "agp" }
kotlinMultiplatform = { id = "org.jetbrains.kotlin.multiplatform", version.ref = "kotlin" }
```

### Without Version Catalog

If versions are declared directly in build files, update the plugin IDs and versions in place:

**Before (root build.gradle.kts):**
```kotlin
plugins {
    id("com.android.library") version "8.7.3" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.1.0" apply false
}
```

**After (root build.gradle.kts):**
```kotlin
plugins {
    id("com.android.kotlin.multiplatform.library") version "9.0.1" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.3.20" apply false
}
```

**Before (module build.gradle.kts):**
```kotlin
plugins {
    id("org.jetbrains.kotlin.multiplatform")
    id("com.android.library")
}
```

**After (module build.gradle.kts):**
```kotlin
plugins {
    id("org.jetbrains.kotlin.multiplatform")
    id("com.android.kotlin.multiplatform.library")
}
```

Key changes:
- The plugin ID changes from `com.android.library` to `com.android.kotlin.multiplatform.library`.
- AGP version must be 9.0.0+, Gradle 9.1.0+, KGP 2.0.0+ (2.3.0+ recommended).

---

## Root build.gradle.kts Changes

### With Version Catalog

**Before:**
```kotlin
plugins {
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
}
```

**After:**
```kotlin
plugins {
    alias(libs.plugins.androidKmpLibrary) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
}
```

### Without Version Catalog

**Before:**
```kotlin
plugins {
    id("com.android.library") version "8.7.3" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.1.0" apply false
}
```

**After:**
```kotlin
plugins {
    id("com.android.kotlin.multiplatform.library") version "9.0.1" apply false
    id("org.jetbrains.kotlin.multiplatform") version "2.3.20" apply false
}
```

No other root-level changes are required unless you have convention plugins that reference the old plugin ID (see convention plugin section below).

---

## Source Directory Renames

The new KMP-integrated plugin does NOT change the expected source directory layout. The standard KMP source sets still apply:

| Source Set              | Directory                 |
|-------------------------|---------------------------|
| `commonMain`            | `src/commonMain/kotlin/`  |
| `androidMain`           | `src/androidMain/kotlin/` |
| `androidMain` resources | `src/androidMain/res/`    |
| `iosMain`               | `src/iosMain/kotlin/`     |

**No renames are required** if you already use the standard KMP layout. If your module previously used the classic Android layout (`src/main/java/`, `src/main/res/`), you must migrate to the KMP layout:

| Old (Android layout)           | New (KMP layout)                      |
|--------------------------------|---------------------------------------|
| `src/main/java/`               | `src/androidMain/kotlin/`             |
| `src/main/res/`                | `src/androidMain/res/`                |
| `src/main/AndroidManifest.xml` | `src/androidMain/AndroidManifest.xml` |
| `src/test/java/`               | `src/androidHostTest/kotlin/`         |
| `src/androidTest/java/`        | `src/androidDeviceTest/kotlin/`       |

---

## Test Configuration

The new plugin uses explicit opt-in for test source sets.

### Host Tests (Unit Tests)

```kotlin
kotlin {
    android {
        // Enable unit tests (JVM-based, run on host machine)
        withHostTest {
            // Optional: configure the host test compilation
        }
    }
}
```

This creates the `androidHostTest` source set. The previous name `androidUnitTest` still works as an alias but `androidHostTest` is preferred.

### Device Tests (Instrumented Tests)

```kotlin
kotlin {
    android {
        // Enable instrumented tests (run on device/emulator)
        withDeviceTest {
            // Optional: configure the device test compilation
        }
    }
}
```

This creates the `androidDeviceTest` source set. The previous name `androidInstrumentedTest` still works as an alias but `androidDeviceTest` is preferred.

### Full Test Example

```kotlin
kotlin {
    android {
        namespace = "com.example.shared"
        compileSdk = 35
        minSdk = 24

        withHostTest {}
        withDeviceTest {}
    }

    sourceSets {
        getByName("androidHostTest").dependencies {
            implementation(libs.junit)
            implementation(libs.robolectric)
        }
        getByName("androidDeviceTest").dependencies {
            implementation(libs.androidx.test.runner)
            implementation(libs.androidx.test.espresso.core)
        }
    }
}
```

---

## Java Compilation (withJava)

If your module contains Java source files in `androidMain`, you must explicitly enable Java compilation:

```kotlin
kotlin {
    android {
        withJava()
    }
}
```

Without this call, `.java` files in `src/androidMain/java/` will be ignored. Kotlin files are compiled by default.

---

## Consumer ProGuard Rules

### Before (AGP 8.x)

```kotlin
android {
    defaultConfig {
        consumerProguardFiles("consumer-rules.pro")
    }
}
```

### After (AGP 9.x)

```kotlin
kotlin {
    android {
        consumerProguardFiles.add(file("consumer-rules.pro"))
    }
}
```

**Warning:** Consumer ProGuard rules can be silently dropped during migration if you forget this step. The old `android {}` block is gone, so the `consumerProguardFiles` call in `defaultConfig` has no equivalent location unless you explicitly add it in `kotlin { android {} }`.

---

## JVM Target Configuration Hierarchy

There are three levels at which you can configure the JVM target. They are listed from most specific (highest priority) to least specific (lowest priority):

### Level 1: Android-Specific Compiler Options (Recommended)

```kotlin
kotlin {
    android {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }
}
```

This sets the JVM target only for the Android compilation.

### Level 2: Top-Level Kotlin Compiler Options

```kotlin
kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
    }
}
```

This sets the JVM target for ALL JVM-based compilations in the project (Android, JVM desktop, etc.).

### Level 3: Gradle Toolchain

```kotlin
kotlin {
    jvmToolchain(11)
}
```

This sets both the JDK used for compilation and the JVM target. It is the broadest setting and affects all JVM compilations.

### Priority Order

If multiple levels are set, the most specific wins:
1. `kotlin { android { compilerOptions { } } }` -- highest priority
2. `kotlin { compilerOptions { } }` -- medium priority
3. `kotlin { jvmToolchain() }` -- lowest priority

### Migration from kotlinOptions

The old `kotlinOptions` DSL is removed:

```kotlin
// REMOVED in AGP 9.0 -- do not use
androidTarget {
    compilations.all {
        kotlinOptions { jvmTarget = "11" }
    }
}
```

Replace with one of the three levels above.

---

## Dependencies Configuration Changes

The top-level `dependencies {}` block configurations change because build variants (debug/release) are removed from the KMP library plugin.

### Before

```kotlin
dependencies {
    debugImplementation(libs.compose.ui.tooling)
    releaseImplementation(libs.some.lib)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.test.runner)
}
```

### After

```kotlin
dependencies {
    // Use string-based configuration names
    "androidRuntimeClasspath"(libs.compose.ui.tooling)

    // Or use sourceSets for most dependencies
}

kotlin {
    sourceSets {
        androidMain.dependencies {
            implementation(libs.some.lib)
        }
        getByName("androidHostTest").dependencies {
            implementation(libs.junit)
        }
        getByName("androidDeviceTest").dependencies {
            implementation(libs.androidx.test.runner)
        }
    }
}
```

**Prefer putting dependencies inside `sourceSets` blocks** rather than the top-level `dependencies {}` block. The top-level block is only needed for special configurations like `androidRuntimeClasspath` that have no source set equivalent.

---

## Dependency Resolution Details

When your KMP module depends on a legacy Android library that exposes multiple variants (e.g., `debug`/`release` build types or custom flavor dimensions like `free`/`paid`), you must explicitly define how to resolve them using the `localDependencySelection` DSL.

### Before

```kotlin
android {
    defaultConfig {
        // The consuming module doesn't have a 'tier' dimension,
        // so it tells Gradle to use the 'free' flavor of dependencies
        missingDimensionStrategy("tier", "free")
    }
    buildTypes {
        getByName("debug") {
            // If the dependency doesn't have a 'debug' build type, fallback to 'release'
            matchingFallbacks.add("release")
        }
    }
}
```

### After

```kotlin
kotlin {
    android {
        localDependencySelection {
            // Determine which build type to consume from Android library dependencies, in order of preference
            selectBuildTypeFrom.set(listOf("debug", "release"))
            
            // Map the missing custom flavor dimensions directly
            productFlavorDimension("tier") {
                selectFrom.set(listOf("free"))
            }
        }
    }
}
```

---

## Android Resources

Android resources (`res/`) are not processed by default with the new plugin. You must explicitly enable them:

```kotlin
kotlin {
    android {
        androidResources { enable = true }
    }
}
```

Without this, files in `src/androidMain/res/` will be ignored and `R` class generation will not happen.

---

## Convention Plugin Refactoring

If you use convention plugins (build-logic), update them:

### Before

```kotlin
// build-logic/convention/src/main/kotlin/KmpLibraryConventionPlugin.kt
class KmpLibraryConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        with(target) {
            pluginManager.apply("com.android.library")
            pluginManager.apply("org.jetbrains.kotlin.multiplatform")

            extensions.configure<LibraryExtension> {
                compileSdk = 34
                defaultConfig.minSdk = 24
            }
        }
    }
}
```

### After

```kotlin
// build-logic/convention/src/main/kotlin/KmpLibraryConventionPlugin.kt
class KmpLibraryConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        with(target) {
            pluginManager.apply("org.jetbrains.kotlin.multiplatform")
            pluginManager.apply("com.android.kotlin.multiplatform.library")

            extensions.configure<KotlinMultiplatformExtension> {
                android {
                    namespace = // set per-module or pass as parameter
                    compileSdk = 35
                    minSdk = 24
                }
            }
        }
    }
}
```

The `LibraryExtension` class from AGP is no longer used. All Android configuration goes through `KotlinMultiplatformExtension.android {}`.

---

## Quick Checklist

- [ ] Update plugin IDs and versions (in `libs.versions.toml` if using version catalog, or directly in build files)
- [ ] Replace plugin alias in `build.gradle.kts`
- [ ] Move `android {}` block contents into `kotlin { android {} }`
- [ ] Replace `androidTarget {}` with `android {}`
- [ ] Replace `kotlinOptions` with `compilerOptions`
- [ ] Enable `androidResources` if using Android resources
- [ ] Enable `withHostTest {}` if there are any android host tests or common tests
- [ ] Enable `withDeviceTest {}` if there are any android device tests
- [ ] Add `withJava()` if module contains Java source files
- [ ] Move consumer ProGuard rules to new DSL
- [ ] Migrate top-level `dependencies` to source set dependencies
- [ ] Update convention plugins if applicable
- [ ] Rename test source dirs: `androidUnitTest` to `androidHostTest`, `androidInstrumentedTest` to `androidDeviceTest`
- [ ] Update root `build.gradle.kts` plugin declarations
- [ ] Run `./gradlew :module:assemble` to verify
- [ ] Run `./gradlew :module:testAndroidHostTest` if there are any android host tests or common tests
- [ ] Run `./gradlew :module:assembleAndroidDeviceTest` if there are any android device tests
