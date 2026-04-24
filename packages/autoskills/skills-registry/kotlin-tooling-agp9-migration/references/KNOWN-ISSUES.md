# Known Issues: KMP AGP 9.0 Library Migration

Comprehensive list of gotchas, limitations, and workarounds when migrating to `com.android.kotlin.multiplatform.library`. Based on official Android documentation and community experience.

---

## 1. BuildConfig Removed in Libraries

**Problem:** The `BuildConfig` class is not generated for KMP library modules. Code referencing `BuildConfig.DEBUG`, `BuildConfig.VERSION_NAME`, or custom `buildConfigField` entries will fail to compile.

**Impact:** High. Many libraries use `BuildConfig.DEBUG` for logging gates and `buildConfigField` for compile-time constants.

**Workaround -- AppConfiguration DI Pattern:**

```kotlin
// In commonMain
expect class AppConfiguration {
    val isDebug: Boolean
    val versionName: String
    val apiBaseUrl: String
}

// In androidMain
actual class AppConfiguration(private val context: Context) {
    actual val isDebug: Boolean = (context.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0
    actual val versionName: String = context.packageManager
        .getPackageInfo(context.packageName, 0).versionName ?: "unknown"
    actual val apiBaseUrl: String = if (isDebug) "https://dev.api.example.com" else "https://api.example.com"
}

// In iosMain
actual class AppConfiguration {
    actual val isDebug: Boolean = Platform.isDebugBinary
    actual val versionName: String = NSBundle.mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as? String ?: "unknown"
    actual val apiBaseUrl: String = if (isDebug) "https://dev.api.example.com" else "https://api.example.com"
}
```

Inject `AppConfiguration` via your DI framework (Koin, kotlin-inject, manual DI).

**Alternative A — BuildKonfig plugin** ([github.com/yshrsmz/BuildKonfig](https://github.com/yshrsmz/BuildKonfig)):

Generates `expect`/`actual` BuildConfig objects across all KMP targets. Supports typed fields
(String, Int, Long, Float, Boolean), target-specific overrides, and a flavor system via Gradle properties.

```kotlin
// build.gradle.kts
plugins {
    id("com.codingfeline.buildkonfig")
}

buildkonfig {
    packageName = "com.example.shared"

    defaultConfigs {
        buildConfigField(STRING, "API_BASE_URL", "https://api.example.com")
        buildConfigField(BOOLEAN, "IS_DEBUG", "false")
        buildConfigField(STRING, "VERSION_NAME", "1.0.0")
    }

    // Optional: target-specific overrides
    targetConfigs {
        create("android") {
            buildConfigField(STRING, "PLATFORM", "android")
        }
        create("ios") {
            buildConfigField(STRING, "PLATFORM", "ios")
        }
    }
}
```

Use flavors for debug/release by setting `buildkonfig.flavor=dev` in `gradle.properties`
or passing `-Pbuildkonfig.flavor=release` on CLI:

```kotlin
defaultConfigs("dev") {
    buildConfigField(STRING, "API_BASE_URL", "https://dev.api.example.com")
    buildConfigField(BOOLEAN, "IS_DEBUG", "true")
}
defaultConfigs("release") {
    buildConfigField(STRING, "API_BASE_URL", "https://api.example.com")
    buildConfigField(BOOLEAN, "IS_DEBUG", "false")
}
```

**Alternative B — gradle-buildconfig-plugin** ([github.com/gmazzo/gradle-buildconfig-plugin](https://github.com/gmazzo/gradle-buildconfig-plugin)):

More general-purpose; supports Java, Kotlin, Groovy, and KMP. Richer type support (arrays, maps,
Files, URIs). Uses `expect`/`actual` for KMP via explicit `expect()` calls.

```kotlin
// build.gradle.kts
plugins {
    id("com.github.gmazzo.buildconfig")
}

buildConfig {
    packageName("com.example.shared")

    buildConfigField("APP_NAME", project.name)
    buildConfigField("VERSION", "1.0.0")
    buildConfigField("IS_DEBUG", false)

    // Platform-specific fields using expect/actual
    buildConfigField("PLATFORM", expect<String>())
}

// In source set configurations:
sourceSets.named("androidMain") {
    buildConfigField("PLATFORM", "android")
}
sourceSets.named("iosMain") {
    buildConfigField("PLATFORM", "ios")
}
```

**Important limitation:** Neither plugin replaces Android build variants fully. They provide
compile-time constants only. Build type-specific dependencies, resources, source sets, signing
configs, and minification settings must be handled in the application module (which still supports
variants) or via runtime configuration.

---

## 2. NDK / JNI Unsupported

**Problem:** The KMP library plugin does not support `externalNativeBuild`, `ndkVersion`, or JNI source compilation. Modules that use C/C++ native code via NDK cannot be migrated directly.

**Impact:** Medium. Affects modules with native image processing, crypto, or media libraries.

**Workaround -- Proxy Interface Pattern:**

Keep the JNI module as a classic `com.android.library` module and have the KMP module depend on it:

```
jni-bridge/                 # com.android.library (AGP 8.x compatible in AGP 9.0)
  build.gradle.kts
  src/main/jni/             # C/C++ sources
  src/main/kotlin/          # JNI bindings

shared/                     # com.android.kotlin.multiplatform.library
  build.gradle.kts
```

```kotlin
// shared/build.gradle.kts
kotlin {
    sourceSets {
        androidMain.dependencies {
            implementation(project(":jni-bridge"))
        }
    }
}
```

Define an interface in `commonMain` and implement it in `androidMain` by delegating to the JNI bridge.

---

## 3. No Build Variants

**Problem:** The KMP library plugin produces a single build variant. There are no `debug`/`release` build types and no product flavors. Code that depends on variant-specific behavior, resources, or dependencies must be restructured.

**Impact:** High. Affects projects using flavor-specific dependencies, resources, or source sets.

**Workaround -- Single Variant Architecture:**

- Move all variant-dependent logic to the application module (which still supports variants).
- Use runtime configuration instead of compile-time variants.
- Use `expect`/`actual` with different actual implementations selected by DI based on runtime config.
- For library-specific debug/release behavior, use the `AppConfiguration` pattern from issue 1.
- For compile-time constants that vary by build flavor, use **BuildKonfig** or **gradle-buildconfig-plugin** (see issue 1 alternatives). These provide a flavor-like system for KMP but do NOT replace variant-specific dependencies, resources, signing, or minification.

---

## 4. Compose Resources Require Explicit Enable

**Problem:** Android resources (`res/` directory) are not processed by default with the KMP library plugin. If you forget to enable them, resource references (`R.string.*`, `R.drawable.*`) will fail to resolve. This is tracked as CMP-9547.

**Impact:** High. Silent failure -- resources are simply ignored without an error until you try to reference them.

**Fix:**

```kotlin
kotlin {
    android {
        androidResources { enable = true }
    }
}
```

**Note:** This is separate from Compose Multiplatform resources (`composeResources/`), which are handled by the compose resources plugin and do not need this flag.

---

## 5. Consumer ProGuard Rules Silently Dropped

**Problem:** If you had `consumerProguardFiles` in the old `android { defaultConfig {} }` block and did not migrate it to the new DSL location, the rules are silently ignored. No warning is emitted.

**Impact:** Medium. Can cause runtime crashes in release builds of consuming applications.

**Fix:**

```kotlin
// Old (silently ignored)
android {
    defaultConfig {
        consumerProguardFiles("consumer-rules.pro")
    }
}

// New
kotlin {
    android {
        consumerProguardFiles.add(file("consumer-rules.pro"))
    }
}
```

---

## 6. Convention Plugin Refactoring Needed

**Problem:** Build-logic convention plugins that apply `com.android.library` and configure the `LibraryExtension` must be rewritten to use the KMP library plugin and `KotlinMultiplatformExtension`.

**Impact:** Medium to High for projects with extensive build-logic modules.

**Key Changes:**

```kotlin
// Old
import com.android.build.gradle.LibraryExtension

class MyConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        target.pluginManager.apply("com.android.library")
        target.extensions.configure<LibraryExtension> {
            compileSdk = 34
            defaultConfig.minSdk = 24
        }
    }
}

// New
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension

class MyConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        target.pluginManager.apply("org.jetbrains.kotlin.multiplatform")
        target.pluginManager.apply("com.android.kotlin.multiplatform.library")
        target.extensions.configure<KotlinMultiplatformExtension> {
            android {
                compileSdk = 35
                minSdk = 24
            }
        }
    }
}
```

---

## 7. Renamed test source sets

**Problem:** The source set `androidUnitTest` is renamed to `androidHostTest`. The source set `androidInstrumentedTest` is renamed to `androidDeviceTest`. The old names still work as aliases but are deprecated.

**Impact:** Low. Aliases provide backward compatibility, but you should rename for clarity.

**Action Items:**
- Rename `src/androidUnitTest/` to `src/androidHostTest/`
- Rename `src/androidInstrumentedTest/` to `src/androidDeviceTest/`
- Update `sourceSets` references in `build.gradle.kts`
- Update CI scripts that reference the old directory names

---

## 8. Lint useK2Uast Deprecated

**Problem:** The `lint { useK2Uast = true }` option is deprecated. With KGP 2.0+ and AGP 9.0, K2 UAST is the default and only implementation.

**Impact:** Low. Build warning only.

**Fix:** Remove the line:

```kotlin
// Remove this
lint {
    useK2Uast = true  // DELETE
}
```

---

## 9. Packaging Exclusions Syntax Change

**Problem:** The packaging exclusions DSL has a subtle syntax difference. The old brace-expansion syntax may not work correctly.

**Impact:** Low. Build may fail or produce unexpected results.

**Fix:**

```kotlin
// Old (may not work correctly in AGP 9.0)
packaging {
    resources {
        excludes += "/META-INF/{AL2.0,LGPL2.1}"
    }
}

// New (explicit entries)
packaging {
    resources {
        excludes.add("/META-INF/AL2.0")
        excludes.add("/META-INF/LGPL2.1")
    }
}
```

---

## 10. Static BuildConfig.DEBUG for Tree-Shaking No Longer Available

**Problem:** In classic Android libraries, `BuildConfig.DEBUG` was a `static final boolean` that the compiler could use for dead-code elimination (tree-shaking). Without BuildConfig in KMP libraries, this optimization path is lost.

**Impact:** Low to Medium. Debug-only code paths may be included in release builds.

**Workaround:**

Use R8 rules in the application module to remove debug code:

```proguard
# In the app module's proguard-rules.pro
-assumenosideeffects class com.example.shared.AppConfiguration {
    boolean isDebug() return false;
}
```

Or use compile-time constants from the application module passed via DI.

---

## 11. android.builtInKotlin=false (Temporary Opt-Out)

**Problem:** AGP 9.0 bundles Kotlin compilation for `com.android.application` modules, meaning you should NOT apply the `kotlin-android` plugin separately. If you have tooling or plugins that conflict with the built-in Kotlin support, you can temporarily disable it.

**Temporary Workaround:**

```properties
# gradle.properties
android.builtInKotlin=false
```

**Warning:** This flag is temporary and will be removed in a future AGP version. Use it only to unblock migration while you fix plugin conflicts.

**When you need this:**
- You have custom Kotlin compiler plugin configurations that conflict with AGP's built-in setup
- A third-party Gradle plugin explicitly applies `kotlin-android` and conflicts

---

## 12. IDE Support Matrix

| IDE | KMP Library Plugin Support | Notes                                                     |
|---|---|-----------------------------------------------------------|
| Android Studio Otter 3 (2025.2.3) | Full | First version with full AGP 9.0 support                   |
| Android Studio Narwhal (2025.1) | Partial | Can build but limited code insight for new DSL            |
| Android Studio Meerkat (2024.3) | None | Does not recognize the KMP library plugin                 |
| IntelliJ IDEA | Not supported | Does not support AGP 9.0 as of 2025.3, use Android Studio |

### Recommended IDE Setup

- **Use Android Studio Otter 3 or later.** This is currently the only IDE with full AGP 9.0 + KMP library plugin support.
- **IntelliJ IDEA does not support AGP 9.0** — even with the Android plugin installed, project sync and build integration will not work correctly. If the project uses IntelliJ IDEA, recommend switching to Android Studio for Android/KMP development.
- Ensure the Kotlin plugin in your IDE matches the KGP version in your project.

---

## 13. kapt Incompatible with Built-in Kotlin

**Problem:** The `org.jetbrains.kotlin.kapt` plugin is incompatible with AGP 9.0's built-in Kotlin support. Applying both causes a build failure.

**Impact:** High. Many projects still use kapt for annotation processing

**Workaround:**

**Preferred:** Migrate to KSP (Kotlin Symbol Processing). Most annotation processors now support KSP.

**Fallback:** Replace with `com.android.legacy-kapt` (versioned with AGP):

```toml
# gradle/libs.versions.toml
[plugins]
legacy-kapt = { id = "com.android.legacy-kapt", version.ref = "agp" }
```

```kotlin
// Module build.gradle.kts
plugins {
    // REMOVE: alias(libs.plugins.kotlin.kapt)
    alias(libs.plugins.legacy.kapt)
}
```

---

## 14. New DSL Interfaces (BaseExtension Removed)

**Problem:** AGP 9.0 exclusively uses new public DSL interfaces. The old `BaseExtension`, `AppExtension`, `LibraryExtension` types from `com.android.build.gradle` are removed. Build logic or convention plugins casting to these types will fail with `ClassCastException`.

**Impact:** High for projects with custom build logic or convention plugins.

**Error message:**
```
java.lang.ClassCastException: class com.android.build.gradle.internal.dsl.ApplicationExtensionImpl$AgpDecorated_Decorated
    cannot be cast to class com.android.build.gradle.BaseExtension
```

**Fix:**

```kotlin
// Old
import com.android.build.gradle.BaseExtension
val ext = extensions.getByType(BaseExtension::class)

// New
import com.android.build.api.dsl.CommonExtension
val ext = extensions.getByType(CommonExtension::class)
```

**Temporary opt-out:** `android.newDsl=false` in `gradle.properties` (removed in AGP 10.0).

---

## 15. Deprecated Variant APIs Removed

**Problem:** The following APIs are removed in AGP 9.0: `applicationVariants`, `libraryVariants`, `testVariants`, `unitTestVariants`, `variantFilter`. Build scripts or plugins using these will fail.

**Impact:** Medium-High. Affects custom build logic and many third-party plugins.

**Fix:**

```kotlin
// Old
android {
    applicationVariants.all { variant ->
        variant.signingConfig.enableV1Signing = false
    }
}

// New
androidComponents {
    onVariants { variant ->
        variant.signingConfig.enableV1Signing.set(false)
    }
}
```

Replace `variantFilter` with `androidComponents.beforeVariants()`.

---

## 16. R8 and ProGuard Rule Changes

**Problem:** AGP 9.0 changes several R8 defaults:

- `android.r8.strictFullModeForKeepRules=true` — keep rules no longer implicitly keep default constructors
- `android.r8.proguardAndroidTxt.disallowed=true` — only `proguard-android-optimize.txt` is supported
- `android.r8.globalOptionsInConsumerRules.disallowed=true` — library consumer rules cannot contain global options (like `-dontobfuscate`)
- Keep rules no longer propagate to synthesized companion methods

**Impact:** Medium. Release builds may crash or behave differently without rule updates.

**Fix:**
- Review all ProGuard/R8 keep rules; add explicit rules for default constructors if needed
- Switch to `proguard-android-optimize.txt` in `getDefaultProguardFile()`
- Remove global options (`-dontobfuscate`, `-dontoptimize`) from library consumer rules
- New option: `-processkotlinnullchecks keep|remove_message|remove` to control Kotlin null checks

---

## 17. Removed Features

**Problem:** Several features are removed in AGP 9.0 with no replacement:

- **Embedded Wear OS app support** — `wearApp` configurations removed
- **Density split APK** — use app bundles instead
- **`androidDependencies` and `sourceSets` report tasks** — removed
- **`dexOptions` DSL** — removed (d8 handles this automatically)
- **RenderScript** — disabled by default, enable per-module if needed: `buildFeatures { renderScript = true }`
- **AIDL** — disabled by default, enable per-module if needed: `buildFeatures { aidl = true }`

**Impact:** Low-Medium. Only affects projects using these specific features.

---

## 18. R Class Non-Final in Application Modules

**Problem:** AGP 9.0 makes R class fields compile-time non-final in application modules (`android.enableAppCompileTimeRClass=true` is now default). Code using `switch` statements on R class fields (like `R.id.some_view`) will fail to compile because `switch` requires compile-time constants.

**Impact:** Medium. Common in older Java codebases using `switch(view.getId())`.

**Fix:** Refactor `switch` statements to `if/else`:

```java
// Old (fails with AGP 9.0)
switch (view.getId()) {
    case R.id.button1: // ...
    case R.id.button2: // ...
}

// New
int id = view.getId();
if (id == R.id.button1) { /* ... */ }
else if (id == R.id.button2) { /* ... */ }
```

---

## 19. targetSdk Defaults to compileSdk

**Problem:** AGP 9.0 changes `targetSdk` to default to `compileSdk` when not explicitly set (previously defaulted to `minSdk`). This can silently change app behavior if `targetSdk` was intentionally unset.

**Impact:** Medium. May trigger new runtime behavior changes associated with higher API levels.

**Fix:** Explicitly set `targetSdk` in all application modules:

```kotlin
android {
    defaultConfig {
        targetSdk = 35  // Set explicitly
    }
}
```

---

## 20. Third-Party Plugin Compatibility

**Problem:** Many third-party Gradle plugins are incompatible with AGP 9.0 due to removed variant APIs, new DSL interfaces, or built-in Kotlin conflicts. See the main SKILL.md "Plugin Compatibility" section for the full compatibility table.

**Impact:** High. Can completely block migration.

**Key plugins requiring opt-out flags:**
- detekt < 2.0.0, ktlint, SQLDelight, Paparazzi, protobuf — see SKILL.md for specific flags

---
