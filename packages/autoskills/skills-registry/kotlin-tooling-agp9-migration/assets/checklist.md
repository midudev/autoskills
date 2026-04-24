# KMP AGP 9.0 Migration Verification Checklist

Use this checklist after migration to verify everything is configured correctly.

## Plugin Configuration
- [ ] `com.android.kotlin.multiplatform.library` plugin declared for KMP library modules
- [ ] No `com.android.library` or `com.android.application` in KMP modules' build.gradle.kts
- [ ] `org.jetbrains.kotlin.android` removed from all build files and version catalog (built-in Kotlin replaces it)
- [ ] No `org.jetbrains.kotlin.kapt` plugin — migrated to KSP or `com.android.legacy-kapt`
- [ ] `android.kotlinOptions {}` migrated to `kotlin { compilerOptions {} }` (non-KMP modules)
- [ ] `kotlin.sourceSets` migrated to `android.sourceSets` with `.kotlin` accessor (non-KMP modules)
- [ ] No `android.builtInKotlin=false` unless required by incompatible plugin (documented as temporary)
- [ ] Third-party plugins verified compatible

## KMP Library Modules
- [ ] Source sets renamed: `androidMain`, `androidHostTest`, `androidDeviceTest`
- [ ] No `android {}` top-level block — use `androidLibrary {}` inside `kotlin {}` instead
- [ ] `androidResources { enable = true }` present if module uses Android or Compose Multiplatform resources
- [ ] `withJava()` present if module has .java source files
- [ ] Tests configured: `withHostTest {}`, `withDeviceTest {}`
- [ ] No `debugImplementation` or analogs in library modules
  - use `androidRuntimeClasspath` for tooling deps
  - app modules can still use `debugImplementation`
- [ ] Unique `namespace` for each library module (different from app module; `android.uniquePackageNames=true` is default in AGP 9.0)

## Gradle Properties & DSL
- [ ] No removed properties in `gradle.properties` that cause errors:
  - `android.enableLegacyVariantApi`
  - `android.r8.integratedResourceShrinking`
  - `android.enableNewResourceShrinker.preciseShrinking`
- [ ] Any opt-out flags (`android.newDsl=false`, `android.builtInKotlin=false`) documented with reason
- [ ] `targetSdk` explicitly set in all app modules (defaults to `compileSdk` now, was `minSdk`)

## Build Logic / Convention Plugins
- [ ] No references to `BaseExtension`, `AppExtension`, `LibraryExtension` (removed in AGP 9.0)
- [ ] Using `CommonExtension` or specific new DSL types
- [ ] No use of removed APIs: `applicationVariants`, `libraryVariants`, `variantFilter`

## ProGuard / R8
- [ ] Consumer ProGuard rules migrated to `consumerProguardFiles.add(file(...))` in new DSL
- [ ] Using `proguard-android-optimize.txt` (not `proguard-android.txt`)
- [ ] No global options (`-dontobfuscate`, `-dontoptimize`) in library consumer rules
- [ ] Keep rules updated for R8 strict full mode (explicit default constructor rules if needed)

## Build & Test Verification
- [ ] `./gradlew build` succeeds
- [ ] `./gradlew :androidApp:assembleDebug` succeeds (if app module exists)
- [ ] `xcodebuild -project iosApp/*.xcodeproj -scheme <scheme> -sdk iphonesimulator build` succeeds (if iOS app exists)
- [ ] Desktop app compiles: `./gradlew :desktopApp:run` or equivalent (if desktop target exists)
- [ ] Web/Wasm target compiles: `./gradlew :wasmJsApp:wasmJsBrowserDistribution` or equivalent (if web target exists)
- [ ] `./gradlew :shared:allTests` succeeds (or equivalent for KMP test tasks)
- [ ] `./gradlew :androidApp:testDebugUnitTest` succeeds (if app module exists)
- [ ] No deprecation warnings about variant API or DSL
