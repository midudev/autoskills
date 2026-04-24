---
name: kotlin-tooling-cocoapods-spm-migration
description: Migrate KMP projects from CocoaPods (kotlin("native.cocoapods")) to Swift Package Manager (swiftPMDependencies DSL) — replaces pod() with swiftPackage(), transforms cocoapods.* imports to swiftPMImport.*, and reconfigures the Xcode project.
license: Apache-2.0
metadata:
  author: JetBrains
  version: "1.0.0"
---

# CocoaPods to SwiftPM Migration for KMP

Migrate Kotlin Multiplatform projects from `kotlin("native.cocoapods")` to `swiftPMDependencies {}` DSL.

## Requirements

- **Kotlin**: Version with Swift Import support (e.g., 2.4.0-Beta1 or later)
- **Xcode**: 16.4 or 26.0+
- **iOS Deployment Target**: 16.0+ recommended

## Migration Overview

**IMPORTANT**: Keep the `cocoapods {}` block and plugin active until Phase 6. The migration adds `swiftPMDependencies {}` alongside the existing CocoaPods setup first, reconfigures Xcode, and only then removes CocoaPods.

| Phase | Action |
|-------|--------|
| 1 | Analyze existing CocoaPods configuration |
| 2 | Update Gradle configuration (repos, Kotlin version) |
| 3 | Add `swiftPMDependencies {}` alongside existing `cocoapods {}` |
| 4 | Transform Kotlin imports |
| 5 | Reconfigure iOS project and deintegrate CocoaPods |
| 6 | Remove CocoaPods plugin from Gradle |
| 7 | Verify Gradle build and Xcode project build |
| 8 | Write MIGRATION_REPORT.md |

---

## Phase 1: Pre-Migration Analysis

### 1.0 Verify the project builds

Before starting migration, identify the module to migrate and confirm it compiles successfully.

1. **Find the module that uses CocoaPods** — look for `build.gradle.kts` files containing `cocoapods`:
   ```bash
   grep -rl "cocoapods" --include="build.gradle.kts" .
   ```
   Extract the module name from the path (e.g., `./shared/build.gradle.kts` → module name is `shared`). Note: multiple modules may use CocoaPods — record all of them. Typically only the module that produces the framework linked into the iOS app needs `swiftPMDependencies`; the others only need CocoaPods removed (Phase 6).

2. **Compile Kotlin code** — run the Kotlin compilation task for that module to verify the Kotlin source compiles:
   ```bash
   ./gradlew :moduleName:compileKotlinIosSimulatorArm64
   ```
   Replace `moduleName` with the directory name of the module (e.g., `:shared:compileKotlinIosSimulatorArm64`). This is faster than a full `build` (which also runs release linkage) and sufficient to verify Kotlin code correctness.

3. **Build the iOS app (optional)** — try to locate the Xcode project and build it to confirm the full app compiles:
   ```bash
   # Find the Xcode project
   find . -name "*.xcworkspace" -not -path "*/Pods/*" -maxdepth 2
   # Build (replace scheme name with the actual app scheme)
   cd /path/to/iosApp
   xcodebuild -workspace *.xcworkspace -scheme "<AppScheme>" -destination 'generic/platform=iOS Simulator' ARCHS=arm64
   ```
   If the user wants to skip the Xcode build or no Xcode project is found, proceed without it — the Kotlin compilation from step 2 is sufficient to continue.

4. **If the Kotlin compilation fails**, ask the user to either:
   - Provide the correct Gradle command to verify the module builds, or
   - Confirm the module is in a working state and it's safe to proceed

   If the user confirms without providing a build command, **record that the pre-migration build could not be verified** and warn about this at the end of migration (Phase 7).

### 1.0a Confirm Kotlin version with Swift Import support

Ask the user:

> Does your project already use a Kotlin version with Swift Import support (swiftPMDependencies DSL)?

**If yes** → read their current Kotlin version from `gradle/libs.versions.toml` (or `build.gradle.kts`), record it, and skip Phase 2.2 (no version change needed).

**If no** → ask:

> Please provide the Kotlin version to use (e.g., "2.4.0", "2.4.0-Beta1", "2.4.0-dev-123").

Record the user-provided version. Then ask:

> Does this Kotlin version require a custom Maven repository (e.g., JetBrains dev repo)?

- **Yes** → ask for the repo URL (suggest `https://packages.jetbrains.team/maven/p/kt/dev` as default). Phase 2.1 will add it.
- **No** → Phase 2.1 is skipped (no custom repo needed).

Finally, check the project's current Kotlin version. Compare **major.minor** against the target. If it differs significantly (e.g., `2.1.0` → `2.4.0`), warn: "⚠️ Kotlin version jump — upgrading across minor versions can introduce breaking changes unrelated to this migration. Recommended: update first, verify it builds, then re-run." If the user confirms despite the mismatch, proceed.

### 1.1 Check for deprecated CocoaPods workaround property

Search `gradle.properties` for the deprecated property:

```properties
kotlin.apple.deprecated.allowUsingEmbedAndSignWithCocoaPodsDependencies=true
```

This property was a workaround (see [KT-64096](https://youtrack.jetbrains.com/issue/KT-64096)) for projects using `embedAndSign` alongside CocoaPods dependencies. It suppresses an error about unsupported configurations that can cause runtime crashes or symbol duplication. After migrating to SwiftPM import, this property is no longer needed and **must be removed** in Phase 6. Record its presence if found.

### 1.2 Check for EmbedAndSign disablers

Search all `build.gradle.kts` files for code that disables `EmbedAndSign` tasks (e.g., `TaskGraph.whenReady` filters, `tasks.matching` blocks). This is a CocoaPods-era workaround that **breaks the migration** because `integrateEmbedAndSign` (needed in Phase 5) gets disabled too. Record any such code — it **must be removed** in Phase 6, and may need to be removed earlier. See [troubleshooting.md](references/troubleshooting.md) § "`integrateEmbedAndSign` Skipped" for patterns.

### 1.3 Check for third-party KMP libraries with bundled cinterop klibs

Some KMP libraries ship pre-built cinterop klibs with `cocoapods.*` package namespaces. After migration, the swiftPMDependencies cinterop generator detects these existing bindings and **skips generating new bindings** for those Clang modules to avoid duplicates. This means `cocoapods.*` imports for those modules must be **kept as-is** — they resolve to the third-party library's bundled klib, not to actual CocoaPods.

**Known libraries with bundled `cocoapods.*` klibs:**

| Library | Maven artifact | Bundled klib namespace | Classes provided |
|---------|---------------|----------------------|-----------------|
| [KMPNotifier](https://github.com/mirzemehdi/KMPNotifier) | `io.github.mirzemehdi:kmpnotifier` | `cocoapods.FirebaseMessaging` | `FIRMessaging`, `FIRMessagingAPNSTokenType`, etc. |

**How to detect:** Search Gradle dependency declarations for known libraries, then cross-reference their bundled namespaces against the `import cocoapods.*` statements found in step 4. Mark any matches — these imports will NOT be transformed in Phase 4.

If unsure whether a third-party KMP library bundles cinterop klibs, check if it has a `linkOnly = true` pod dependency in the project — this is a strong indicator that the library provides its own klib for those classes.

To inspect klib contents and verify bundled bindings, see [troubleshooting.md](references/troubleshooting.md) § "Third-Party KMP Libraries with Bundled Klibs".

**Find and record:**

1. **CocoaPods configuration** - Search for `cocoapods` in `build.gradle.kts` files
2. **Pod dependencies** - Extract pod names, versions from `cocoapods {}` blocks
3. **Framework configuration** - Record `baseName`, `isStatic`, deployment target from `cocoapods.framework {}`
4. **linkOnly pods** - Record pods declared with `linkOnly = true`. These pods provide native linking only — cinterop bindings come from a KMP wrapper library (e.g., `dev.gitlive:firebase-*`). See [common-pods-mapping.md](references/common-pods-mapping.md) for implications.
5. **Kotlin imports** - Find all `import cocoapods.*` statements. Cross-reference with step 1.3 to identify which imports come from bundled klibs (and must be preserved) vs. which come from direct pod cinterop (and must be transformed).
6. **Map pods to SPM** - See [common-pods-mapping.md](references/common-pods-mapping.md)
7. **Locate iOS project directory** - Find the directory containing `Podfile` and `.xcworkspace`:
   ```bash
   find . -name "Podfile" -type f
   ```
   Record this path (e.g., `iosApp/`, `ios/`, or project root) - needed for Phase 5
8. **Check for non-KMP CocoaPods** - Determine if the project uses CocoaPods for dependencies other than KMP. This affects cleanup strategy in Phase 5.
9. **Cross-reference Podfile against `cocoapods {}` block** - Parse the `Podfile` and compare its pod entries with the pods declared in the Gradle `cocoapods {}` block. Record any dependencies that exist in the `Podfile` but are **not** listed in `cocoapods {}`. These Podfile-only dependencies still linked into the app via CocoaPods and must be migrated to `swiftPMDependencies` — dropping them silently causes obscure linkage errors at runtime.
10. **Check Xcode build phases** - Open the `.xcodeproj`'s `project.pbxproj` and search for the Gradle build phase script. Check if `embedAndSignAppleFrameworkForXcode` is present but **commented out** (prefixed with `#`). If commented out, it must be uncommented during Phase 5 — the `integrateEmbedAndSign` task may or may not handle this automatically.
11. **Check for existing Crashlytics dSYM upload script** - If using FirebaseCrashlytics, search `project.pbxproj` for a dSYM upload shell script phase. Record its current path (CocoaPods-era scripts reference `${PODS_ROOT}/FirebaseCrashlytics/upload-symbols`). This must be updated to the SPM path in Phase 5.
12. **Identify CocoaPods-related extras in build scripts** - Search all `build.gradle.kts` files for CocoaPods workarounds beyond the standard `cocoapods {}` block (custom tasks hooking into `podInstall`, `Pods.xcodeproj` patching, podspec metadata, `extraSpecAttributes`, `noPodspec()`, etc.). See [cocoapods-extras-patterns.md](references/cocoapods-extras-patterns.md) for the full pattern list. Record all findings — these will be handled in Phase 6.

---

## Phase 2: Gradle Configuration

**Important scope note:** Do NOT upgrade the Gradle wrapper version, update KSP, or update any other dependencies during this migration. Those are separate concerns and out of scope. Only change what is listed below.

### 2.1 Add custom Maven repository (if needed)

**Skip this step** if the user indicated in Phase 1.0a that their Kotlin version does not require a custom Maven repository (i.e., it is an official release, Beta, or RC available from Maven Central).

For dev/custom builds, add the custom Maven repository (URL from Phase 1.0a) to `settings.gradle.kts`:

```kotlin
pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
        maven("<custom-repo-url>")  // ADD
    }
}

dependencyResolutionManagement {
    repositories {
        mavenCentral()
        maven("<custom-repo-url>")  // ADD
    }
}
```

### 2.2 Update Kotlin version

**Skip this step** if the user's project already uses a Kotlin version with Swift Import support (recorded in Phase 1.0a).

Update to the version recorded in Phase 1.0a:

```toml
# gradle/libs.versions.toml
[versions]
kotlin = "<kotlin-version>"
```

### 2.3 Add buildscript constraint (if swiftPMDependencies not recognized)

```kotlin
// root build.gradle.kts
buildscript {
    dependencies.constraints {
        "classpath"("org.jetbrains.kotlin:kotlin-gradle-plugin:<kotlin-version>!!")
    }
}
```

Replace `<kotlin-version>` with the version recorded in Phase 1.0a. The `!!` suffix forces strict version resolution, ensuring no other dependency pulls in a different Kotlin Gradle plugin version.

---

## Phase 3: Add swiftPMDependencies (Keep CocoaPods)

**Do NOT remove the `cocoapods {}` block or `kotlin("native.cocoapods")` plugin yet.** Add `swiftPMDependencies {}` alongside the existing CocoaPods configuration.

### 3.1 Add group property

```kotlin
group = "org.example.myproject"  // Required for import namespace
```

**Compose Resources warning:** If the project uses Compose Multiplatform resources (`org.jetbrains.compose` plugin or `compose.resources`), the `group` property is also used as the namespace for generated resource accessors (e.g., `Res.string.*`, `Res.drawable.*`). If `group` already exists in `build.gradle.kts`, do **not** change it. If you are adding `group` for the first time, warn the user that existing Compose resource accessor call sites throughout the project will change namespace and may need updating.

### 3.2 Add swiftPMDependencies block alongside cocoapods

For each pod dependency, add the equivalent SwiftPM package declaration. Use [common-pods-mapping.md](references/common-pods-mapping.md) to map each pod to its SPM package URL, product name, and `importedClangModules`.

**Version preservation:** Match the version constraint semantics from the `cocoapods {}` block. Using `from()` for an exact CocoaPods version can resolve to a newer version that breaks cinterop APIs (removed symbols, changed signatures).

| CocoaPods version spec | SPM equivalent | Example |
|------------------------|---------------|---------|
| `version = "1.2.3"` (exact) | `exact("1.2.3")` | `pod("GoogleMaps") { version = "10.3.0" }` → `exact("10.3.0")` |
| `version = "~> 1.2"` (optimistic) | `from("1.2.0")` | `pod("FirebaseAuth") { version = "~> 12.5" }` → `from("12.5.0")` |
| No version specified | `exact()` with latest, or ask user | Ask the user which version to pin |

**Key concepts:** `products` = SPM product names (controls linking). `importedClangModules` = Clang module names for cinterop bindings (only when `discoverModulesImplicitly = false`). `discoverModulesImplicitly` defaults to `true` (bindings for all Clang modules); set `false` when transitive C/C++ modules fail cinterop (Firebase, gRPC), then list needed modules explicitly.

**Important:** SPM product names and Clang module names don't always match. Always consult [common-pods-mapping.md](references/common-pods-mapping.md) for correct values.

**Podfile-only dependencies:** If Phase 1 step 9 identified dependencies that exist in the `Podfile` but not in the Gradle `cocoapods {}` block, these must also be added to `swiftPMDependencies` as `products` entries. Even though the KMP module didn't declare them, they were linked into the app by CocoaPods and may be required for the app to build. Look up each Podfile-only pod's SPM package URL and add it as a `swiftPackage()` with at least its `products`. If any of these pods were used via cinterop (check for `import cocoapods.*` statements referencing them), also add `importedClangModules`.

**Do not mix the same library suite across CocoaPods and SPM.** Libraries that share a common repository (e.g., all Firebase products) share transitive dependencies. Having some products linked via CocoaPods and others via SPM causes duplicate/conflicting symbols and dyld crashes at runtime. When migrating such a suite, move **all** pods from that suite to SPM at once — including Swift-only pods that Kotlin doesn't use directly. Add Swift-only pods as `products` entries (no `importedClangModules` needed). After adding new products, re-run `integrateLinkagePackage` to regenerate the linkage Swift package.

```kotlin
kotlin {
    // Keep existing targets
    iosArm64()
    iosSimulatorArm64()
    iosX64()

    swiftPMDependencies {
        iosDeploymentVersion.set("16.0")

        // If using KMP IntelliJ plugin, specify the .xcodeproj path:
        // xcodeProjectPathForKmpIJPlugin.set(
        //     layout.projectDirectory.file("../iosApp/iosApp.xcodeproj")
        // )

        swiftPackage(
            url = url("https://github.com/owner/repo.git"),
            version = from("1.0.0"),
            products = listOf(product("ProductName")),
        )
    }

    cocoapods {
        // ... keep existing cocoapods block for now
    }
}
```

### 3.3 Move framework configuration out of cocoapods block

If the `cocoapods` block contains a `framework {}` configuration, move it to the `binaries` API on each target. **`isStatic = true` is recommended** — dynamic frameworks have known edge cases with SwiftPM import that can cause linker errors, dyld crashes, or duplicate class warnings:

```kotlin
listOf(iosArm64(), iosSimulatorArm64(), iosX64()).forEach { iosTarget ->
    iosTarget.binaries.framework { baseName = "Shared"; isStatic = true }
}
```

If the `cocoapods.framework {}` block contained `export(project(...))` or `transitiveExport = true`, preserve these in the new `binaries.framework {}` block — they are essential for multi-module projects where the framework exports child modules.

### 3.4 Handle dev.gitlive/firebase-kotlin-sdk and similar CocoaPods-era KMP wrappers

If the project uses `dev.gitlive:firebase-*` or similar KMP wrapper libraries, two additional steps are required:

**A. Switch to `isStatic = true`** — dynamic frameworks + Firebase SPM = runtime `dyld` crash. After switching: re-run `integrateLinkagePackage`, remove any "Embed Frameworks" copy phase, move linker flags to `OTHER_LDFLAGS`.

**B. Add framework search paths** — add conditional `-F` linkerOpts in `build.gradle.kts` and matching `FRAMEWORK_SEARCH_PATHS` in the Xcode project.

See [common-pods-mapping.md](references/common-pods-mapping.md) § dev.gitlive and [troubleshooting.md](references/troubleshooting.md) for code snippets and the full product list.

### 3.5 Add opt-in for cinterop API

```kotlin
kotlin.compilerOptions {
    optIn.add("kotlinx.cinterop.ExperimentalForeignApi")
}
```

For full DSL reference, see [dsl-reference.md](references/dsl-reference.md).

---

## Phase 4: Kotlin Source Updates

### Import Namespace Formula

```
swiftPMImport.<group>.<module>.<ClassName>

Where:
- group: build.gradle.kts `group` property, dashes (-) → dots (.)
- module: Gradle module name, dashes (-) → dots (.), underscores (_) preserved as-is
- ClassName: Objective-C class name (FIR* for Firebase, GMS* for Google Maps)
```

### Example Transformation

```kotlin
// group = "org.jetbrains.kotlin.firebase.sample", module = "kotlin-library"

// BEFORE:
import cocoapods.FirebaseAnalytics.FIRAnalytics

// AFTER:
import swiftPMImport.org.jetbrains.kotlin.firebase.sample.kotlin.library.FIRAnalytics
```

**Import flattening:** The Clang module name (e.g., `FirebaseFirestoreInternal`, `FirebaseAuth`) disappears from the import path — all classes are flattened under the same `swiftPMImport.<group>.<module>` prefix regardless of which library they come from. For example, both `cocoapods.FirebaseAuth.FIRAuth` and `cocoapods.FirebaseFirestoreInternal.FIRFirestore` become `swiftPMImport.<group>.<module>.FIRAuth` and `swiftPMImport.<group>.<module>.FIRFirestore`.

### Preserving Bundled Klib Imports

> **CRITICAL:** Do NOT replace `cocoapods.*` imports that resolve to third-party KMP libraries' bundled cinterop klibs (identified in Phase 1 step 1.3). These imports must remain as-is — the `cocoapods` prefix is the package namespace in the library's published klib, not an actual CocoaPods dependency. The swiftPMDependencies cinterop generator skips modules already provided by a dependency's klib, so `swiftPMImport.*` for those classes will fail with "Unresolved reference".

**Example** (project using [KMPNotifier](https://github.com/mirzemehdi/KMPNotifier)):
```kotlin
// KEEP — resolves to kmpnotifier's bundled cinterop klib
import cocoapods.FirebaseMessaging.FIRMessaging
```

### Bulk Replacement

Use a regex find-and-replace across all Kotlin source files, **excluding imports identified in Phase 1 step 1.3**:

```
Find:    cocoapods\.\w+\.
Replace: swiftPMImport.<your.group>.<your.module>.
```

After bulk replacement, **manually restore** any `cocoapods.*` imports that should be preserved (from bundled klibs).

**Finding correct import path:** Run `./gradlew :moduleName:compileKotlinIosSimulatorArm64` - errors show available classes.

---

## Phase 5: iOS Project Reconfiguration

### 5.1 Get migration command

Build the CocoaPods workspace to obtain the migration command:

```bash
cd /path/to/iosApp

xcodebuild -scheme "$(echo -n *.xcworkspace | python3 -c 'import sys, json; from subprocess import check_output; print(list(set(json.loads(check_output(["xcodebuild", "-workspace", sys.stdin.readline(), "-list", "-json"]))["workspace"]["schemes"]) - set(json.loads(check_output(["xcodebuild", "-project", "Pods/Pods.xcodeproj", "-list", "-json"]))["project"]["schemes"]))[0])')" -workspace *.xcworkspace -destination 'generic/platform=iOS Simulator' ARCHS=arm64 | grep -A5 'What went wrong'
```

The build output will contain a command like:
```bash
XCODEPROJ_PATH='/path/to/project/iosApp.xcodeproj' GRADLE_PROJECT_PATH=':shared' '/path/to/project/gradlew' -p '/path/to/project' ':shared:integrateEmbedAndSign' ':shared:integrateLinkagePackage'
```

Run this command. It modifies the `.xcodeproj` to trigger `embedAndSignAppleFrameworkForXcode` during the build. `integrateLinkagePackage` is a one-time setup — it does not need to be added as a build phase. If `integrateEmbedAndSign` is skipped, check for EmbedAndSign disablers (Phase 1 step 1.2) — remove them first, then re-run.

**Verify `embedAndSignAppleFrameworkForXcode` is active:** After running integration, check the build phase script in `project.pbxproj`. If `embedAndSignAppleFrameworkForXcode` is commented out (prefixed with `#`), uncomment it.

The `integrateLinkagePackage` task generates `_internal_linkage_SwiftPMImport/` at `<iosDir>/` — a local Swift package that mirrors your `products` list and ensures SPM libraries are linked into the final binary.

After running the integration tasks, **disable User Script Sandboxing** (`ENABLE_USER_SCRIPT_SANDBOXING = NO`) in the `.xcodeproj`. Xcode 16+ enables it by default, which prevents the Gradle build phase from writing to the project directory:

```bash
sed -i '' 's/ENABLE_USER_SCRIPT_SANDBOXING = YES/ENABLE_USER_SCRIPT_SANDBOXING = NO/g' "$XCODEPROJ_PATH/project.pbxproj"
```

If the setting is absent (Xcode defaults to YES), add `ENABLE_USER_SCRIPT_SANDBOXING = NO;` to the app target's `buildSettings` sections. Then restart the Gradle daemon: `./gradlew --stop`

**Alternative (if xcodebuild approach fails):** See [troubleshooting.md](references/troubleshooting.md) § "Manual Integration Command Discovery" for a fallback script to discover paths and run integration tasks directly.

### 5.2 Update Crashlytics dSYM upload script (if applicable)

If the project uses FirebaseCrashlytics and has a dSYM upload run script phase (identified in Phase 1 step 11), update the script path from `${PODS_ROOT}/FirebaseCrashlytics/upload-symbols` to `"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"`. See [troubleshooting.md](references/troubleshooting.md) § "Firebase Crashlytics: dSYM Upload Script" and [common-pods-mapping.md](references/common-pods-mapping.md) for the full script and input files list.

### 5.3 Deintegrate CocoaPods

**Option A: Full deintegration** (if CocoaPods was used ONLY for KMP dependencies):

Before deleting files, run `git status --short` and verify the paths. If unsure, move files to a backup location instead of deleting immediately.

```bash
cd /path/to/iosApp
pod deintegrate
rm -rf Podfile Podfile.lock Pods/
# Remove the workspace that matches your app xcodeproj name
XCODEPROJ_NAME=$(basename "$(find . -maxdepth 1 -name "*.xcodeproj" -type d | grep -v Pods | head -1)" .xcodeproj)
rm -rf "${XCODEPROJ_NAME}.xcworkspace"
# Return to project root
cd ..
# Remove the migrated module podspec only (for example, shared.podspec)
# If unknown, list candidates and remove the matching one explicitly:
ls -1 *.podspec
# rm -f shared.podspec
```

This cleanup snippet is self-contained and does not assume `XCODEPROJ_PATH` or `GRADLE_PROJECT_PATH` from the earlier one-off migration command are still available in your shell.

If `pod deintegrate` is not available, see [troubleshooting.md](references/troubleshooting.md) § "Manual CocoaPods Deintegration from pbxproj" for the full list of references to remove. Also remove `Pods/` from `.gitignore` and delete the `.xcworkspace` directory.

**Option B: Partial removal** (if other non-KMP CocoaPods dependencies remain):

Remove only the KMP pod line from the `Podfile` and re-run pod install:

```ruby
target 'iosApp' do
  # Remove this line:
  pod 'shared', :path => '../shared'
  # Keep other non-KMP pods
end
```

```bash
cd /path/to/iosApp && pod install
```

> **Tip:** Consider migrating remaining pods to SPM too — most popular iOS libraries support it natively. Add them in Xcode via File → Add Package Dependencies, then fully deintegrate CocoaPods once all pods are replaced.

### 5.4 Manual integration (if automatic fails)

See [troubleshooting.md](references/troubleshooting.md) § "Manual Xcode Integration Steps" for the 5-step manual setup (build phase, sandboxing, linkage package).

---

## Phase 6: Remove CocoaPods from Gradle

Now that the iOS project is reconfigured, remove the CocoaPods plugin and block from **all** modules that used it (not just the primary one):

### 6.1 Remove CocoaPods plugin

```kotlin
plugins {
    // REMOVE: kotlin("native.cocoapods")
    alias(libs.plugins.kotlinMultiplatform)  // Keep
}
```

### 6.2 Remove cocoapods block

Delete the entire `cocoapods { ... }` block from `build.gradle.kts`. The `swiftPMDependencies {}` block and `binaries.framework {}` configuration added in Phase 3 replace it. Also delete any generated `.podspec` files from the module directory (e.g., `shared/shared.podspec`) — these were generated by the CocoaPods plugin and are no longer needed.

### 6.3 Remove deprecated gradle.properties entries

If found in Phase 1.1, remove from `gradle.properties`:

```properties
# REMOVE — no longer needed after migrating away from CocoaPods (KT-64096)
kotlin.apple.deprecated.allowUsingEmbedAndSignWithCocoaPodsDependencies=true
```

### 6.4 Clean up CocoaPods-related extras

Review the extras identified in Phase 1 step 12. Podspec metadata, `noPodspec()`, CocoaPods task hooks, and `Pods.xcodeproj` patching code are **safe to remove** without user consultation. Non-standard pod configurations (`extraOpts`, `moduleName`), custom cinterop `defFile` setups, and CocoaPods-specific compiler/linker flags **require analysis** — consult the user if unsure whether SPM handles them automatically.

See [cocoapods-extras-patterns.md](references/cocoapods-extras-patterns.md) for the full categorized list with examples.

---

## Phase 7: Verification

**Do NOT stop until the application builds successfully.** This phase is iterative — if any step fails, diagnose the error, fix it (consulting [troubleshooting.md](references/troubleshooting.md) and re-checking Phases 2–6), and re-run the failing step. Repeat until the build succeeds or the issue is clearly outside the migration scope (pre-existing bug, unrelated tooling problem). Do NOT write the migration report (Phase 8) until the build succeeds.

### 7.1 Compile Kotlin code

Compile the migrated module to verify Kotlin sources are correct:

```bash
./gradlew :moduleName:compileKotlinIosSimulatorArm64
```

If compilation fails with unresolved references, check import transformations (Phase 4) and SwiftPM dependency declarations (Phase 3.2). Common causes: missing `importedClangModules`, wrong Clang module names, preserved bundled klib imports that should have been transformed (or vice versa).

### 7.2 Link framework

```bash
./gradlew :moduleName:linkDebugFrameworkIosSimulatorArm64
```

If linking fails, check that all required SPM products are declared and that version constraints resolve correctly. Linking errors about missing symbols often indicate a product was omitted from `swiftPMDependencies` or a version mismatch caused API removal.

### 7.3 Build iOS/macOS Xcode project

After the Gradle steps succeed, build the Xcode project to verify the full application compiles. Use `-project *.xcodeproj` if all CocoaPods were removed (Option A), or `-workspace *.xcworkspace` if non-KMP CocoaPods remain (Option B):

```bash
cd /path/to/iosApp
# Discover schemes and build (replace -project/-workspace as needed; for macOS use -destination 'platform=macOS'):
xcodebuild -project *.xcodeproj -list -json 2>/dev/null | python3 -c "import sys,json; schemes=json.load(sys.stdin)['project']['schemes']; [print(s) for s in schemes]"
xcodebuild -project *.xcodeproj -scheme "<AppScheme>" -destination 'generic/platform=iOS Simulator' ARCHS=arm64 build
```

**If `checkSandboxAndWriteProtection` fails** — sandboxing was not disabled in Phase 5.1. Go back and apply the sandboxing fix from Phase 5.1, then retry.

**If the pre-migration build was not verified** (Phase 1.0 fallback was used), warn the user:
> Note: The pre-migration build could not be fully verified. If build errors appear now, some may be pre-existing issues unrelated to the migration. Compare errors against the pre-migration build output to distinguish migration issues from prior problems.

### If the build fails

**Do NOT revert the migration.** Read the error log, re-check Phases 2-6, and consult [troubleshooting.md](references/troubleshooting.md). If unsure, present options to the user — do not silently undo migration work. Fix the issue and re-run the failing verification step. Keep iterating until the build succeeds.

---

## Phase 8: Migration Report

After the build succeeds, write a comprehensive `MIGRATION_REPORT.md` in the project root. Use the template in [migration-report-template.md](references/migration-report-template.md).

The report must include:
1. **Pre-Migration State** — CocoaPods dependencies (name, version, `linkOnly`), framework config, `cocoapods.*` imports, non-KMP pods, atypical configuration
2. **Migration Steps** — exact changes per phase with before/after snippets for non-trivial changes
3. **Import Transformations** — table of every import change, clearly marking preserved `cocoapods.*` imports and which bundled klib provides them
4. **Errors Encountered** — structured `Error #N` entries: phase, exact symptom, root cause, fix, generalizable flag
5. **Non-Trivial Decisions** — `isStatic` changes, preserved imports, framework search paths, trade-offs
6. **Files Changed** — complete list grouped by type (Gradle, Kotlin, Xcode, created, deleted)

---

## Additional Resources

- [DSL Reference](references/dsl-reference.md) - Full swiftPMDependencies syntax
- [Common Pods Mapping](references/common-pods-mapping.md) - Pod to SPM mapping table
- [CocoaPods Extras Patterns](references/cocoapods-extras-patterns.md) - Detection and cleanup patterns for CocoaPods workarounds
- [Troubleshooting](references/troubleshooting.md) - Issues, solutions, rollback
- [Migration Report Template](references/migration-report-template.md) - Post-migration report template
