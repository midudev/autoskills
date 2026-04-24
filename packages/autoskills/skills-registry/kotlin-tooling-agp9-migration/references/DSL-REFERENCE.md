# DSL Reference: AGP 8.x to AGP 9.x KMP Library Migration

Side-by-side mapping of every DSL element from the old `com.android.library` configuration to the new `com.android.kotlin.multiplatform.library` configuration.

---

## Plugin IDs

| Old (AGP 8.x)                        | New (AGP 9.x)                                                                                       |
|--------------------------------------|-----------------------------------------------------------------------------------------------------|
| `com.android.library`                | `com.android.kotlin.multiplatform.library`                                                          |
| `com.android.application`            | `com.android.application` (unchanged, but cannot combine with KMP)                                  |
| `org.jetbrains.kotlin.android`       | Built into `com.android.application` and `com.android.library` in AGP 9.0 (do not apply separately) |
| `org.jetbrains.kotlin.kapt`          | `com.android.legacy-kapt` (same version as AGP) or migrate to KSP                                   |
| `org.jetbrains.kotlin.multiplatform` | `org.jetbrains.kotlin.multiplatform` (unchanged)                                                    |

---

## Top-Level Block Migration

| Old                                       | New                                 |
|-------------------------------------------|-------------------------------------|
| `android { ... }`                         | `kotlin { android { ... } }`        |
| `androidTarget { ... }` (in kotlin block) | `android { ... }` (in kotlin block) |

---

## android {} Block Fields

### Namespace and SDK Versions

| Old (android {})                   | New (kotlin { android {} })                                             |
|------------------------------------|-------------------------------------------------------------------------|
| `namespace = "..."`                | `namespace = "..."`                                                     |
| `compileSdk = 35`                  | `compileSdk = 35` (same value, just moved into `kotlin { android {} }`) |
| `defaultConfig { minSdk = 24 }`    | `minSdk = 24`                                                           |
| `defaultConfig { targetSdk = 34 }` | N/A (application-only, not in library)                                  |

### defaultConfig Elements

| Old (android { defaultConfig {} })         | New (kotlin { android {} })               |
|--------------------------------------------|-------------------------------------------|
| `minSdk = 24`                              | `minSdk = 24` (direct property)           |
| `testInstrumentationRunner = "..."`        | Set in `withDeviceTest { }` configuration |
| `consumerProguardFiles("...")`             | `consumerProguardFiles.add(file("..."))`  |
| `multiDexEnabled = true`                   | N/A (handled automatically)               |
| `vectorDrawables.useSupportLibrary = true` | N/A                                       |
| `buildConfigField(...)`                    | Removed (see KNOWN-ISSUES.md)             |
| `manifestPlaceholders[...]`                | N/A (use merged manifest in app module)   |

---

## Compile Options and Compiler Options

| Old                                                                           | New                                                                          |
|-------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| `android { compileOptions { sourceCompatibility = JavaVersion.VERSION_11 } }` | `kotlin { android { compilerOptions { jvmTarget.set(JvmTarget.JVM_11) } } }` |
| `android { compileOptions { targetCompatibility = JavaVersion.VERSION_11 } }` | `kotlin { android { compilerOptions { jvmTarget.set(JvmTarget.JVM_11) } } }` |
| `kotlinOptions { jvmTarget = "11" }`                                          | `compilerOptions { jvmTarget.set(JvmTarget.JVM_11) }`                        |
| `kotlinOptions { freeCompilerArgs += listOf("-Xopt-in=...") }`                | `compilerOptions { optIn.add("...") }`                                       |
| `kotlinOptions { languageVersion = "1.9" }`                                   | `compilerOptions { languageVersion.set(KotlinVersion.KOTLIN_2_0) }`          |

Full JvmTarget import:
```kotlin
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
```

---

## Build Features

| Old (android { buildFeatures {} })      | New (kotlin { android {} })                                                  |
|-----------------------------------------|------------------------------------------------------------------------------|
| `buildFeatures { compose = true }`      | Applied via compose compiler plugin (no explicit flag needed in KMP library) |
| `buildFeatures { buildConfig = true }`  | Removed in KMP library (see KNOWN-ISSUES.md)                                 |
| `buildFeatures { viewBinding = true }`  | Not supported in KMP library                                                 |
| `buildFeatures { dataBinding = true }`  | Not supported in KMP library                                                 |
| `buildFeatures { aidl = true }`         | Not supported in KMP library                                                 |
| `buildFeatures { renderScript = true }` | Not supported                                                                |
| `buildFeatures { resValues = true }`    | Not supported in KMP library                                                 |

---

## Android Resources

| Old                                         | New                                                         |
|---------------------------------------------|-------------------------------------------------------------|
| Resources processed by default              | Must explicitly enable                                      |
| `android { ... }` (resources auto-included) | `kotlin { android { androidResources { enable = true } } }` |

---

## Test Options

| Old                                                                  | New                                                                            |
|----------------------------------------------------------------------|--------------------------------------------------------------------------------|
| `android { testOptions { unitTests.isReturnDefaultValues = true } }` | `kotlin { android { withHostTest { } } }`                                      |
| `android { testOptions { animationsDisabled = true } }`              | `kotlin { android { withDeviceTest { } } }`                                    |
| Source set: `androidUnitTest`                                        | Source set: `androidHostTest` (alias: `androidUnitTest` still works)           |
| Source set: `androidInstrumentedTest`                                | Source set: `androidDeviceTest` (alias: `androidInstrumentedTest` still works) |
| `testImplementation(...)`                                            | `getByName("androidHostTest").dependencies { implementation(...) }`            |
| `androidTestImplementation(...)`                                     | `getByName("androidDeviceTest").dependencies { implementation(...) }`          |
| Source dir: `src/test/`                                              | Source dir: `src/androidHostTest/kotlin/`                                      |
| Source dir: `src/androidTest/`                                       | Source dir: `src/androidDeviceTest/kotlin/`                                    |

### Test Configuration Details

```kotlin
// Old
android {
    testOptions {
        unitTests {
            isReturnDefaultValues = true
            isIncludeAndroidResources = true
        }
    }
}

// New
kotlin {
    android {
        withHostTest {
            // Host test specific configuration
            // returnDefaultValues and includeAndroidResources
            // are configured via gradle.properties or test runner
        }
        withDeviceTest {
            // Device test specific configuration
            instrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        }
    }
}
```

---

## Lint Configuration

| Old                                                         | New                                                                    |
|-------------------------------------------------------------|------------------------------------------------------------------------|
| `android { lint { abortOnError = false } }`                 | `kotlin { android { lint { abortOnError = false } } }`                 |
| `android { lint { checkReleaseBuilds = true } }`            | `kotlin { android { lint { checkReleaseBuilds = true } } }`            |
| `android { lint { disable += "SomeCheck" } }`               | `kotlin { android { lint { disable += "SomeCheck" } } }`               |
| `android { lint { baseline = file("lint-baseline.xml") } }` | `kotlin { android { lint { baseline = file("lint-baseline.xml") } } }` |

The lint DSL is largely unchanged, it just moves inside `kotlin { android {} }`.

**Note:** `useK2Uast` is deprecated. Remove it if present.

---

## Packaging / Resources Excludes

| Old                                                                               | New                                                                                          |
|-----------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| `android { packaging { resources { excludes += "/META-INF/{AL2.0,LGPL2.1}" } } }` | `kotlin { android { packaging { resources { excludes += "/META-INF/{AL2.0,LGPL2.1}" } } } }` |

The DSL is the same, just nested under `kotlin { android {} }`.

**Syntax note for AGP 9.0:**
```kotlin
// Old syntax (still works but deprecated)
resources.excludes += "/META-INF/{AL2.0,LGPL2.1}"

// Preferred AGP 9.0 syntax
resources {
    excludes.add("/META-INF/AL2.0")
    excludes.add("/META-INF/LGPL2.1")
}
```

---

## Dependencies Configurations

| Old Configuration                | New Configuration                                                     | Notes                       |
|----------------------------------|-----------------------------------------------------------------------|-----------------------------|
| `implementation(...)`            | `androidMain.dependencies { implementation(...) }`                    | Move to source set          |
| `api(...)`                       | `androidMain.dependencies { api(...) }`                               | Move to source set          |
| `compileOnly(...)`               | `androidMain.dependencies { compileOnly(...) }`                       | Move to source set          |
| `debugImplementation(...)`       | `"androidRuntimeClasspath"(...)`                                      | No variant-specific configs |
| `releaseImplementation(...)`     | `androidMain.dependencies { implementation(...) }`                    | Single variant              |
| `testImplementation(...)`        | `getByName("androidHostTest").dependencies { implementation(...) }`   |                             |
| `androidTestImplementation(...)` | `getByName("androidDeviceTest").dependencies { implementation(...) }` |                             |
| `ksp(...)`                       | `add("ksp", ...)` or KSP Gradle plugin DSL                            | Check KSP compatibility     |
| `kapt(...)`                      | Migrate to KSP; kapt not supported                                    |                             |

---

## Dependency Resolution
Because the new KMP Android library plugin is strictly single-variant, you can no longer define fallback logic inside `buildTypes` or `defaultConfig`.
| Old | New | Notes |
|---|---|---|
| `android { defaultConfig { missingDimensionStrategy("tier", "free") } }` | `kotlin { android { localDependencySelection { productFlavorDimension("tier") { selectFrom.set(listOf("free")) } } } }` | Configure dependency flavor fallbacks |
| `android { buildTypes { getByName("debug") { matchingFallbacks.add("release") } } }` | `kotlin { android { localDependencySelection { selectBuildTypeFrom.set(listOf("debug", "release")) } } }` | Configure dependency build type mapping |

---

## Build Types and Product Flavors

**Removed in KMP library plugin.** The `com.android.kotlin.multiplatform.library` plugin produces a single build variant.

| Old                                               | New     | Notes                                               |
|---------------------------------------------------|---------|-----------------------------------------------------|
| `buildTypes { debug { ... } }`                    | Removed | Single variant only                                 |
| `buildTypes { release { minifyEnabled = true } }` | Removed | Minification is app-module concern                  |
| `productFlavors { ... }`                          | Removed | Use Gradle properties or expect/actual for variants |
| `flavorDimensions(...)`                           | Removed |                                                     |

### Workarounds for Variant-Dependent Logic

1. **Compile-time constants:** Use `expect`/`actual` or dependency injection instead of `BuildConfig`.
2. **Environment-specific behavior:** Use Gradle properties or runtime configuration.
3. **Different dependencies per build type:** Not possible in KMP library. Move to app module.
4. **Minification/ProGuard:** Only relevant in the application module.

---

## androidComponents Block

| Old                                            | New                                              |
|------------------------------------------------|--------------------------------------------------|
| `androidComponents { onVariants { ... } }`     | Limited support; most variant API is unavailable |
| `androidComponents { beforeVariants { ... } }` | Not available in KMP library                     |
| `androidComponents { finalizeDsl { ... } }`    | Not available in KMP library                     |

The `androidComponents` extension is significantly reduced in scope for KMP libraries because there is only a single variant. Most customization that relied on variant-aware APIs must be reworked.

**Note:** `android.enableLegacyVariantApi` is **removed** in AGP 9.0 and will cause an error if set. Code depending on legacy variant APIs must be migrated to `androidComponents` APIs.

---

## Java Source Compilation

| Old                                                     | New                                 |
|---------------------------------------------------------|-------------------------------------|
| Java sources in `src/main/java/` compiled automatically | Must call `withJava()`              |
| `android { compileOptions { ... } }`                    | `kotlin { android { withJava() } }` |

```kotlin
kotlin {
    android {
        withJava()  // Required to compile .java files in androidMain
    }
}
```

---

## Quick Reference: Minimal Migration Template

```kotlin
// OLD
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
}
kotlin {
    androidTarget { compilations.all { kotlinOptions { jvmTarget = "11" } } }
}
android {
    namespace = "com.example.lib"
    compileSdk = 35
    defaultConfig { minSdk = 24 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

// NEW
plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidKmpLibrary)
}
kotlin {
    android {
        namespace = "com.example.lib"
        compileSdk = 35
        minSdk = 24
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }
}
```
