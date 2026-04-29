---
name: kotlin-tooling-agp9-migration
description: >
  Migrates Kotlin Multiplatform (KMP) projects to Android Gradle Plugin 9.0+.
  Handles plugin replacement (com.android.kotlin.multiplatform.library), module
  splitting, DSL migration, and the new default project structure. Use when
  upgrading AGP, when build fails due to KMP+AGP incompatibility, or when the
  user mentions AGP 9.0, android multiplatform plugin, KMP migration, or
  com.android.kotlin.multiplatform.library.
license: Apache-2.0
metadata:
  author: JetBrains
  version: "1.0.0"
---

# KMP AGP 9.0 Migration

Android Gradle Plugin 9.0 makes the Android application and library plugins incompatible
with the Kotlin Multiplatform plugin in the same module. This skill guides you through the
migration.

## Step 0: Analyze the Project

Before making any changes, understand the project structure:
1. Read `settings.gradle.kts` (or `.gradle`) to find all modules
2. For each module, read its `build.gradle.kts` to identify which plugins are applied
3. Check if the project uses a Gradle version catalog (`gradle/libs.versions.toml`). If it exists,
   read it for current AGP/Gradle/Kotlin versions. If not, find versions directly in `build.gradle.kts`
   files (typically in the root `buildscript {}` or `plugins {}` block). **Adapt all examples in this
   guide accordingly** — version catalog examples use `alias(libs.plugins.xxx)` while direct usage
   uses `id("plugin.id") version "x.y.z"`
4. Read `gradle/wrapper/gradle-wrapper.properties` for the Gradle version
5. Check `gradle.properties` for any existing workarounds (`android.enableLegacyVariantApi`)
6. Check for `org.jetbrains.kotlin.android` plugin usage — AGP 9.0 has built-in Kotlin and this plugin must be removed
7. Check for `org.jetbrains.kotlin.kapt` plugin usage — incompatible with built-in Kotlin, must migrate to KSP or `com.android.legacy-kapt`
8. Check for third-party plugins that may be incompatible with AGP 9.0 (see "Plugin Compatibility" section below)

If Bash is available, run `scripts/analyze-project.sh` from this skill's directory to get a structured summary.

### Classify Each Module

For each module, determine its type:

| Current plugins                                                          | Migration path                              |
|--------------------------------------------------------------------------|---------------------------------------------|
| `kotlin.multiplatform` + `com.android.library`                           | **Path A** — Library plugin swap            |
| `kotlin.multiplatform` + `com.android.application`                       | **Path B** — Mandatory Android split        |
| `kotlin.multiplatform` with multiple platform entry points in one module | **Path C** — Full restructure (recommended) |
| `com.android.application` or `com.android.library` (no KMP)              | See "Pure Android Tips" below               |

### Determine Scope

- **Path B is mandatory** for any module combining KMP + Android application plugin
- **Path C is recommended** when the project has a monolithic `composeApp` (or similar) module
  containing entry points for multiple platforms (Android, Desktop, Web). This aligns with the
  new JetBrains default project structure where each platform gets its own app module.
- **Ask the user** whether they want Path B only (minimum required) or Path C (recommended full restructure)

## Path A: Library Module Migration

Use this when a module applies `kotlin.multiplatform` + `com.android.library`.

See [references/MIGRATION-LIBRARY.md](references/MIGRATION-LIBRARY.md) for full before/after code.

Summary:

1. **Replace plugin**: `com.android.library` → `com.android.kotlin.multiplatform.library`
2. **Remove `org.jetbrains.kotlin.android`** plugin if present (AGP 9.0 has built-in Kotlin support)
3. **Migrate DSL**: Move config from top-level `android {}` block into `kotlin { android {} }`:
   ```kotlin
   kotlin {
       android {
           namespace = "com.example.lib"
           compileSdk = 35
           minSdk = 24
       }
   }
   ```
4. **Rename source directories** (only if the module uses classic Android layout instead of KMP layout):
   - `src/main` → `src/androidMain`
   - `src/test` → `src/androidHostTest`
   - `src/androidTest` → `src/androidDeviceTest`
   - If the module already uses `src/androidMain/`, no directory renames are needed
5. **Move dependencies** from top-level `dependencies {}` into `sourceSets`:
   ```kotlin
   kotlin {
       sourceSets {
           androidMain.dependencies {
               implementation("androidx.appcompat:appcompat:1.7.0")
           }
       }
   }
   ```
6. **Enable resources** explicitly if the module uses Android or Compose Multiplatform resources:
   ```kotlin
   kotlin {
       android {
           androidResources { enable = true }
       }
   }
   ```
7. **Enable Java** compilation if module has `.java` source files:
   ```kotlin
   kotlin {
       android {
           withJava()
       }
   }
   ```
8. **Enable tests** explicitly if the module has unit or instrumented tests:
   ```kotlin
   kotlin {
       android {
           withHostTest { isIncludeAndroidResources = true }
           withDeviceTest {
               instrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
           }
       }
   }
   ```
9. **Update Compose tooling dependency**:
   ```kotlin
   // Old: 
   debugImplementation(libs.androidx.compose.ui.tooling)
   // New:
   androidRuntimeClasspath(libs.androidx.compose.ui.tooling)
   ```
10. **Publish consumer ProGuard rules** explicitly if applicable:
    ```kotlin
    kotlin {
        android {
            consumerProguardFiles.add(file("consumer-rules.pro"))
        }
    }
    ```
11. **Resolve Sub-dependency Variants (Product Flavors / Build Types)**:
    Because the new KMP Android library plugin enforces a single-variant architecture, it does not natively understand how to resolve dependencies that publish multiple variants (like `debug`/`release` build types, or product flavors like `free`/`paid`). Configure fallback behaviors using `localDependencySelection`:
    ```kotlin
    kotlin {
        android {
            localDependencySelection {
                // Determine which build type to consume from Android library dependencies, in order of preference
                selectBuildTypeFrom.set(listOf("debug", "release"))
                
                // If the dependency has a 'tier' dimension, select the 'free' flavor
                productFlavorDimension("tier") {
                    selectFrom.set(listOf("free"))
                }
            }
        }
    }
    ```

## Path B: Android App + Shared Module Split

Use this when a module applies `kotlin.multiplatform` + `com.android.application`. This is **mandatory** for AGP 9.0 compatibility.

See [references/MIGRATION-APP-SPLIT.md](references/MIGRATION-APP-SPLIT.md) for full guide.

Summary:

1. **Create `androidApp` module** with its own `build.gradle.kts`:
   ```kotlin
   plugins {
       alias(libs.plugins.androidApplication)
       // Do NOT apply kotlin-android — AGP 9.0 includes Kotlin support
       alias(libs.plugins.composeMultiplatform)  // if using Compose
       alias(libs.plugins.composeCompiler)       // if using Compose
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
       buildFeatures { compose = true }
   }

   dependencies {
       implementation(projects.shared)  // or whatever the shared module is named
       implementation(libs.androidx.activity.compose)
   }
   ```
2. **Move Android entry point code** from `src/androidMain/` to `androidApp/src/main/`:
   - `MainActivity.kt` (and any other Activities/Fragments)
   - `AndroidManifest.xml` (app-level manifest with `<application>` and launcher `<activity>`) — verify `android:name` on `<activity>` uses the fully qualified class name in its new location
   - Android Application class if present
   - App-level resources (launcher icons, theme, etc.)
3. **Add to `settings.gradle.kts`**: `include(":androidApp")`
4. **Add to root `build.gradle.kts`**: plugin declarations with `apply false`
5. **Convert original module** from application to library using Path A steps
6. **Ensure different namespaces**: app module and library module must have distinct namespaces
7. **Remove from shared module**: `applicationId`, `targetSdk`, `versionCode`, `versionName`
8. **Update IDE run configurations**: change the module from the old module to `androidApp`

## Path C: Full Restructure (Recommended)

Use this when the project has a monolithic module (typically `composeApp`) containing entry
points for multiple platforms. This is optional but aligns with the new JetBrains default.

See [references/MIGRATION-FULL-RESTRUCTURE.md](references/MIGRATION-FULL-RESTRUCTURE.md) for full guide.

### Target Structure

```
project/
├── shared/              ← KMP library (was composeApp), pure shared code
├── androidApp/          ← Android entry point only
├── desktopApp/          ← Desktop entry point only (if desktop target exists)
├── webApp/              ← Wasm/JS entry point only (if web target exists)
├── iosApp/              ← iOS Xcode project (usually already separate)
└── ...
```

### Steps

1. **Apply Path B first** — extract `androidApp` (mandatory for AGP 9.0)
2. **Extract `desktopApp`** (if desktop target exists):
   - Create module with `org.jetbrains.compose` and `application {}` plugin
   - Move `main()` function from `desktopMain` to `desktopApp/src/main/kotlin/`
   - Move `compose.desktop { application { ... } }` config to `desktopApp/build.gradle.kts`
   - Add dependency on `shared` module
3. **Extract `webApp`** (if wasmJs/js target exists):
   - Create module with appropriate Kotlin/JS or Kotlin/Wasm configuration
   - Move web entry point from `wasmJsMain`/`jsMain` to `webApp/src/wasmJsMain/kotlin/`
   - Move browser/distribution config to `webApp/build.gradle.kts`
   - Add dependency on `shared` module
4. **iOS** — typically already in a separate `iosApp` directory. Verify:
   - Framework export config (`binaries.framework`) stays in `shared` module
   - Xcode project references the correct framework path
5. **Rename module** from `composeApp` to `shared`:
   - Rename directory
   - Update `settings.gradle.kts` include
   - Update all dependency references across modules
6. **Clean up shared module**: remove all platform entry point code and app-specific config
   that was moved to the platform app modules

### Variant: Native UI

If some platforms use native UI (e.g., SwiftUI for iOS), split `shared` into:
- `sharedLogic` — business logic consumed by ALL platforms
- `sharedUI` — Compose Multiplatform UI consumed only by platforms using shared UI

### Variant: Server

If the project includes a server target:
- Add `server` module at the root
- Move all client modules under an `app/` directory
- Add `core` module for code shared between server and client (models, validation)

## Version Updates

These are required regardless of migration path:

1. **Gradle wrapper** — update to 9.1.0+:
   ```properties
   # gradle/wrapper/gradle-wrapper.properties
   distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-bin.zip
   ```
2. **AGP version** — update to 9.0.0+ and add the KMP library plugin.

   With version catalog (`gradle/libs.versions.toml`):
   ```toml
   [versions]
   agp = "9.0.1"

   [plugins]
   android-kotlin-multiplatform-library = { id = "com.android.kotlin.multiplatform.library", version.ref = "agp" }
   ```

   Without version catalog — update `com.android.*` plugin versions and add in root `build.gradle.kts`:
   ```kotlin
   plugins {
       id("com.android.application") version "9.0.1" apply false
       id("com.android.kotlin.multiplatform.library") version "9.0.1" apply false
   }
   ```
3. **JDK** — ensure JDK 17+ is used (required by AGP 9.0)
4. **SDK Build Tools** — update to 36.0.0:
   ```
   Install via SDK Manager or configure in android { buildToolsVersion = "36.0.0" }
   ```
5. **Review gradle.properties** — remove error-causing properties and review changed defaults (see "Gradle Properties Default Changes" section)

## Built-in Kotlin Migration

AGP 9.0 enables built-in Kotlin support by default for all `com.android.application` and `com.android.library`
modules. The `org.jetbrains.kotlin.android` plugin is no longer needed and will conflict if applied.

**Important:** Built-in Kotlin does NOT replace KMP support. KMP library modules still need
`org.jetbrains.kotlin.multiplatform` + `com.android.kotlin.multiplatform.library`.

### Step 1: Remove kotlin-android Plugin

Remove from **all** module-level and root-level build files:

```kotlin
// Remove from module build.gradle.kts
plugins {
    // REMOVE: alias(libs.plugins.kotlin.android)
    // REMOVE: id("org.jetbrains.kotlin.android")
}

// Remove from root build.gradle.kts
plugins {
    // REMOVE: alias(libs.plugins.kotlin.android) apply false
}
```

Remove from version catalog (`gradle/libs.versions.toml`):
```toml
[plugins]
# REMOVE: kotlin-android = { id = "org.jetbrains.kotlin.android", version.ref = "kotlin" }
```

### Step 2: Migrate kapt to KSP or legacy-kapt

The `org.jetbrains.kotlin.kapt` plugin is **incompatible** with built-in Kotlin.

**Preferred: Migrate to KSP** — see the KSP migration guide for each annotation processor.

**Fallback: Use `com.android.legacy-kapt`** (same version as AGP):
```toml
# gradle/libs.versions.toml
[plugins]
legacy-kapt = { id = "com.android.legacy-kapt", version.ref = "agp" }
```
```kotlin
// Module build.gradle.kts — replace kotlin-kapt with legacy-kapt
plugins {
    // REMOVE: alias(libs.plugins.kotlin.kapt)
    alias(libs.plugins.legacy.kapt)
}
```

### Step 3: Migrate kotlinOptions to compilerOptions

For pure Android modules (non-KMP), migrate `android.kotlinOptions {}` to the top-level
`kotlin.compilerOptions {}`:
```kotlin
// Old
android {
    kotlinOptions {
        jvmTarget = "11"
        languageVersion = "2.0"
        freeCompilerArgs += listOf("-Xopt-in=kotlin.RequiresOptIn")
    }
}

// New
kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        languageVersion.set(org.jetbrains.kotlin.gradle.dsl.KotlinVersion.KOTLIN_2_0)
        optIn.add("kotlin.RequiresOptIn")
    }
}
```

**Note:** With built-in Kotlin, `jvmTarget` defaults to `android.compileOptions.targetCompatibility`, so it may be optional if you already set `compileOptions`.

### Step 4: Migrate kotlin.sourceSets to android.sourceSets

With built-in Kotlin, only `android.sourceSets {}` with the `kotlin` set is supported:
```kotlin
// NOT SUPPORTED with built-in Kotlin:
kotlin.sourceSets.named("main") {
    kotlin.srcDir("additionalSourceDirectory/kotlin")
}

// Correct:
android.sourceSets.named("main") {
    kotlin.directories += "additionalSourceDirectory/kotlin"
}
```

For generated sources, use the Variant API:
```kotlin
androidComponents.onVariants { variant ->
    variant.sources.kotlin!!.addStaticSourceDirectory("additionalSourceDirectory/kotlin")
}
```

### Per-Module Migration Strategy

For large projects, migrate module-by-module:

1. Disable globally: `android.builtInKotlin=false` in `gradle.properties`
2. Enable per migrated module by applying the opt-in plugin:
   ```kotlin
   plugins {
       id("com.android.built-in-kotlin") version "AGP_VERSION"
   }
   ```
3. Follow Steps 1-4 for that module
4. Once all modules are migrated, remove `android.builtInKotlin=false` and all `com.android.built-in-kotlin` plugins

### Optional: Disable Kotlin for Non-Kotlin Modules

For modules that contain **no Kotlin sources**, disable built-in Kotlin to save build time:
```kotlin
android {
    enableKotlin = false
}
```

### Opt-Out (Temporary)

If blocked by plugin incompatibilities, opt out temporarily:
```properties
# gradle.properties
android.builtInKotlin=false
android.newDsl=false  # also required if using new DSL opt-out
```

**Warning:** Ask the user if they want to opt out, and if so, remind them this is a temporary measure.

## Plugin Compatibility

See [references/PLUGIN-COMPATIBILITY.md](references/PLUGIN-COMPATIBILITY.md) for the full compatibility table with known compatible versions, opt-out flag workarounds, and broken plugins.

**Before migrating**, inventory all plugins in the project and check each against that table. If any plugin is broken without workaround, inform the user. If plugins need opt-out flags, add them to`gradle.properties` and note them as temporary workarounds.

## Gradle Properties Default Changes

AGP 9.0 changes the defaults for many Gradle properties. Check `gradle.properties` for any explicitly set values that may now conflict. 
Key changes:

| Property                                             | Old Default | New Default | Action                                            |
|------------------------------------------------------|-------------|-------------|---------------------------------------------------|
| `android.uniquePackageNames`                         | `false`     | `true`      | Ensure each library has a unique namespace        |
| `android.enableAppCompileTimeRClass`                 | `false`     | `true`      | Refactor `switch` on R fields to `if/else`        |
| `android.defaults.buildfeatures.resvalues`           | `true`      | `false`     | Enable `resValues = true` where needed            |
| `android.defaults.buildfeatures.shaders`             | `true`      | `false`     | Enable shaders where needed                       |
| `android.r8.optimizedResourceShrinking`              | `false`     | `true`      | Review R8 keep rules                              |
| `android.r8.strictFullModeForKeepRules`              | `false`     | `true`      | Update keep rules to be explicit                  |
| `android.proguard.failOnMissingFiles`                | `false`     | `true`      | Remove invalid ProGuard file references           |
| `android.r8.proguardAndroidTxt.disallowed`           | `false`     | `true`      | Use `proguard-android-optimize.txt` only          |
| `android.r8.globalOptionsInConsumerRules.disallowed` | `false`     | `true`      | Remove global options from library consumer rules |
| `android.sourceset.disallowProvider`                 | `false`     | `true`      | Use `Sources` API on androidComponents            |
| `android.sdk.defaultTargetSdkToCompileSdkIfUnset`    | `false`     | `true`      | Specify `targetSdk` explicitly                    |
| `android.onlyEnableUnitTestForTheTestedBuildType`    | `false`     | `true`      | Only if testing non-default build types           |

Check for and remove properties that now cause errors:
- `android.r8.integratedResourceShrinking` — removed, always on
- `android.enableNewResourceShrinker.preciseShrinking` — removed, always on

## Pure Android Tips

For non-KMP Android modules upgrading to AGP 9.0, follow the "Built-in Kotlin Migration" steps above,
then review the "Gradle Properties Default Changes" table. Additional changes:

- **Review new DSL interfaces** — `BaseExtension` is removed; use `CommonExtension` or specific extension types
- **Java default changed** from Java 8 to Java 11 — ensure `compileOptions` reflects this

## Verification

After migration, verify with the [checklist](assets/checklist.md). Key checks:

1. `./gradlew build` succeeds with no errors
2. All platform targets build successfully (Android, iOS via `xcodebuild`, Desktop, JS/Wasm)
3. `./gradlew :shared:allTests` and Android unit tests pass
4. No `com.android.library` or `com.android.application` in KMP modules
5. No `org.jetbrains.kotlin.android` in AGP 9.0 modules
6. Source sets use correct names (`androidMain`, `androidHostTest`, `androidDeviceTest`)
7. No deprecation warnings about variant API or DSL

## Common Issues

See [references/KNOWN-ISSUES.md](references/KNOWN-ISSUES.md) for details. Key gotchas:

### KMP Library Plugin Issues
- **BuildConfig unavailable** in library modules — use DI/`AppConfiguration` interface, or use [BuildKonfig](https://github.com/yshrsmz/BuildKonfig) or [gradle-buildconfig-plugin](https://github.com/gmazzo/gradle-buildconfig-plugin) for compile-time constants
- **No build variants** — single variant architecture; compile-time constants can use BuildKonfig/gradle-buildconfig-plugin flavors, but variant-specific dependencies/resources/signing must move to app module
- **NDK/JNI unsupported** in new plugin — extract to separate `com.android.library` module
- **Compose resources crash** without `androidResources { enable = true }`
- **Consumer ProGuard rules silently dropped** if not migrated to `consumerProguardFiles.add(file(...))` in new DSL
- **KSP** requires version 2.3.1+ for AGP 9.0 compatibility

### AGP 9.0 General Issues
- **BaseExtension removed** — convention plugins using old DSL types need rewriting to use `CommonExtension`
- **Variant APIs removed** — `applicationVariants`, `libraryVariants`, `variantFilter` replaced by `androidComponents`
- **Convention plugins** need refactoring — old `android {}` extension helpers are obsolete

## Reference Files

- [DSL Reference](references/DSL-REFERENCE.md) — side-by-side old→new DSL mapping
- [Version Matrix](references/VERSION-MATRIX.md) — AGP/Gradle/KGP/Compose/IDE compatibility
- [Plugin Compatibility](references/PLUGIN-COMPATIBILITY.md) — third-party plugin status and workarounds
