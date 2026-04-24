# Troubleshooting Guide

Common issues and solutions when migrating from CocoaPods to SwiftPM.

## Gradle Issues

### "swiftPMDependencies not found"

**Symptom:** Unresolved reference to `swiftPMDependencies` in build.gradle.kts

**Solution:** Add buildscript constraint to root build.gradle.kts:

```kotlin
buildscript {
    dependencies.constraints {
        "classpath"("org.jetbrains.kotlin:kotlin-gradle-plugin:<kotlin-version>!!")
    }
}
```

Also verify:
- Kotlin version matches the version recorded in Phase 1.0a in libs.versions.toml
- Custom Maven repo (if needed) is in settings.gradle.kts

---

### Import Not Found After Migration

**Symptom:** `Unresolved reference` errors for classes that worked with CocoaPods

**Solution:** The import namespace follows a specific pattern:

```
swiftPMImport.<group>.<module>.<ClassName>
```

**Steps to fix:**
1. Check `group` property in build.gradle.kts
2. Replace `-` with `.` in both group and module names
3. Run `./gradlew build` to see available classes in error messages

**Example:**
```kotlin
// If group = "org.jetbrains.kotlin.firebase-sample" and module = "kotlin-library"
// Import becomes:
import swiftPMImport.org.jetbrains.kotlin.firebase.sample.kotlin.library.FIRAnalytics
//                    ^                          ^      ^
//                    dashes become dots --------+------+
```

---

### Gradle Sync Fails

**Symptom:** IDE fails to sync project after adding swiftPMDependencies

**Solution:**
1. Invalidate caches: File > Invalidate Caches > Invalidate and Restart
2. Run `./gradlew --refresh-dependencies`
3. Check all repository declarations include JetBrains Maven

---

## Linker Issues

### Missing Symbols / Linker Errors

**Symptom:** `Undefined symbols for architecture` errors

**Solutions:**

1. **Run the linkage integration task** (one-time, not a build phase):
   ```bash
   ./gradlew :moduleName:integrateLinkagePackage
   ```

2. **Verify SPM package is linked in Xcode:**
   - Open project in Xcode
   - Check Package Dependencies section
   - Ensure `_internal_linkage_SwiftPMImport` is present

3. **Check framework configuration** — `isStatic = true` is recommended. While `isStatic = false` can work, dynamic frameworks have known edge cases with SwiftPM import (linker errors, dyld crashes, duplicate class warnings). It is required with `dev.gitlive:firebase-*` — see below.

---

### "No such module" in Xcode

**Symptom:** Xcode can't find the Kotlin module

**Solution:**
1. Clean Xcode build folder: Shift+Cmd+K
2. Re-run integration:
   ```bash
   ./gradlew :moduleName:integrateLinkagePackage
   ```
3. Restart Xcode completely
4. Re-open the correct Xcode project file (`.xcodeproj` if all CocoaPods were removed, `.xcworkspace` if non-KMP CocoaPods remain)

---

## Build Phase Issues

### Build Phase Order Problems

**Symptom:** Swift compilation fails because Kotlin framework isn't ready

**Solution:** Ensure "Compile Kotlin" runs BEFORE "Compile Sources":

1. Open Xcode project
2. Select app target > Build Phases
3. Drag "Compile Kotlin" phase above "Compile Sources"

---

### Script Sandboxing Errors

**Symptom:** Gradle task `checkSandboxAndWriteProtection` fails during Xcode build:

```
Execution failed for task ':moduleName:checkSandboxAndWriteProtection'.
> User Script Sandboxing Enabled in Xcode Project
```

Or build scripts can't access files or run Gradle.

**Cause:** Xcode 16+ enables User Script Sandboxing by default. The Gradle build phase needs to write to the project directory, which sandboxing prevents.

**Solution:**

1. Disable via command line:
   ```bash
   sed -i '' 's/ENABLE_USER_SCRIPT_SANDBOXING = YES/ENABLE_USER_SCRIPT_SANDBOXING = NO/g' /path/to/iosApp/*.xcodeproj/project.pbxproj
   ```
   If the setting is not present in the `.pbxproj` (Xcode defaults to YES without an explicit entry), open the project in Xcode instead.

2. Or disable in Xcode: select app target → Build Settings → Build Options → set "User Script Sandboxing" to NO

3. **Important:** After changing the setting, stop the Gradle daemon:
   ```bash
   ./gradlew --stop
   ```

---

## Integration Task Issues

### `integrateEmbedAndSign` Skipped or Does Nothing

**Symptom:** Running `integrateEmbedAndSign` completes without errors but the Xcode project is not modified. The `embedAndSignAppleFrameworkForXcode` build phase is not added or remains commented out.

**Cause:** The project has code that disables `EmbedAndSign` tasks. Common patterns:

```kotlin
// In root or module build.gradle.kts
project.gradle.taskGraph.whenReady {
    allTasks.filter { it::class.simpleName?.contains("EmbedAndSign") == true }.forEach {
        it.enabled = false
    }
}
```

This was a CocoaPods-era workaround that inadvertently disables `integrateEmbedAndSign`.

**Solution:** Remove the disabler code from `build.gradle.kts`, then re-run the integration command.

---

### `embedAndSignAppleFrameworkForXcode` Commented Out in Build Phase

**Symptom:** Xcode build succeeds but produces no Kotlin framework. The app crashes at runtime with missing module errors.

**Cause:** The Gradle invocation in the Xcode build phase script was commented out (prefixed with `#`) — possibly a pre-existing state from before migration.

**Solution:** Open `project.pbxproj` and uncomment the Gradle invocation:

```diff
-#./gradlew :moduleName:embedAndSignAppleFrameworkForXcode
+./gradlew :moduleName:embedAndSignAppleFrameworkForXcode
```

---

## Third-Party KMP Libraries with Bundled Klibs

### `cocoapods.*` Class Not Found After Converting to `swiftPMImport.*`

**Symptom:** After replacing `import cocoapods.FirebaseMessaging.FIRMessaging` with `import swiftPMImport.<group>.<module>.FIRMessaging`, the build fails with `Unresolved reference 'FIRMessaging'`. Other swiftPMImport classes (e.g., `GIDSignIn`) resolve fine.

**Cause:** A third-party KMP library (e.g., [KMPNotifier](https://github.com/mirzemehdi/KMPNotifier) — `io.github.mirzemehdi:kmpnotifier`) bundles its own pre-built cinterop klib with the `cocoapods.FirebaseMessaging` namespace. The swiftPMDependencies cinterop generator detects these existing bindings and **deliberately skips** generating new bindings for that Clang module to avoid duplicate symbols. The `swiftPMImport.*` bindings for that module simply don't exist.

**Solution:** Revert the affected imports back to `cocoapods.*`:

```kotlin
// These resolve to the third-party library's bundled klib, NOT actual CocoaPods
import cocoapods.FirebaseMessaging.FIRMessaging
import cocoapods.FirebaseMessaging.FIRMessagingAPNSTokenType
```

The `cocoapods` prefix here is just a package namespace embedded in the library's published artifact — no CocoaPods infrastructure is needed at runtime.

**How to identify bundled klibs in advance:** Check if the project depends on KMP libraries that wrap iOS SDKs. Known libraries: [KMPNotifier](https://github.com/mirzemehdi/KMPNotifier) (bundles `cocoapods.FirebaseMessaging`). Also check for `linkOnly = true` pod declarations — this indicates the pod was only needed for linking while a KMP library provided the actual bindings.

**Inspecting klib contents:** Use `klib dump-metadata-signatures` to verify which classes a klib provides ([docs](https://kotlinlang.org/docs/native-libraries.html#using-kotlin-native-compiler)):

```bash
# Find the klib
find ~/.gradle/caches -name "*.klib" -path "*kmpnotifier*" | head -1

# Dump and search for the class in question
klib dump-metadata-signatures /path/to/cinterop.klib | grep "FIRMessaging"
# Output shows: cocoapods.FirebaseMessaging.FIRMessaging → confirms bundled klib
```

You can also compare before/after migration by dumping the swiftPMImport klib:
```bash
# After build, find the swiftPMImport klib
find . -name "*.klib" -path "*swiftPMImport*" | head -1

# Verify which classes are available
klib dump-metadata-signatures /path/to/swiftPMImport.klib | grep "FIRMessaging"
# Empty output = class NOT in swiftPMImport (must use cocoapods.* import)
```

---

## dev.gitlive/firebase-kotlin-sdk Issues

### `framework 'FirebaseCore' not found` (K/N Linker)

**Symptom:** Kotlin/Native linker fails with:
```
ld: framework 'FirebaseCore' not found
```
or similar errors for `FirebaseAuth`, `FirebaseFirestore`, etc. The Gradle compilation succeeds but the link step fails.

**Cause:** [firebase-kotlin-sdk](https://github.com/GitLiveApp/firebase-kotlin-sdk) (`dev.gitlive:firebase-*`) was published with CocoaPods-era cinterop klibs. These klibs have `-framework FirebaseCore`, `-framework FirebaseAuth`, etc. baked into their linker metadata. With CocoaPods, those frameworks were in `Pods/` on the search path. With SPM, they land in per-product subdirectories (`$BUILT_PRODUCTS_DIR/FirebaseCore/FirebaseCore.framework`) that the K/N linker doesn't search.

**Solution (two-part):**

**Part A — Gradle linkerOpts:**
```kotlin
iosTarget.binaries.framework {
    val builtProductsDir = System.getenv("BUILT_PRODUCTS_DIR")
    if (builtProductsDir != null) {
        listOf(
            "FirebaseCore", "FirebaseAuth", "FirebaseCoreExtension",
            "FirebaseCoreInternal", "FirebaseCrashlytics", "FirebaseFirestore",
            "FirebaseFirestoreInternal", "FirebaseInstallations", "FirebaseMessaging",
            "FirebaseStorage", "GoogleDataTransport", "GoogleUtilities",
            "GTMSessionFetcher", "AppCheckCore", "AppAuth", "GTMAppAuth",
        ).forEach { product ->
            linkerOpts("-F", "$builtProductsDir/$product")
        }
    }
}
```

The `if (builtProductsDir != null)` guard ensures `./gradlew :moduleName:compileKotlinIosSimulatorArm64` works without Xcode (compilation doesn't link).

**Part B — Xcode FRAMEWORK_SEARCH_PATHS:**

Add matching entries in `project.pbxproj` for both Debug and Release `buildSettings`:
```
FRAMEWORK_SEARCH_PATHS = (
    "$(inherited)",
    "$(BUILT_PRODUCTS_DIR)/FirebaseCore",
    "$(BUILT_PRODUCTS_DIR)/FirebaseAuth",
    "$(BUILT_PRODUCTS_DIR)/FirebaseCoreExtension",
    // ... same list as Part A ...
);
```

---

### `dyld: Library not loaded: @rpath/FirebaseCore.framework/FirebaseCore` (Runtime Crash)

**Symptom:** The Gradle build and Xcode compilation both succeed, but the app crashes at launch with:
```
dyld: Library not loaded: @rpath/FirebaseCore.framework/FirebaseCore
  Referenced from: .../ComposeApp.framework/ComposeApp
```

**Cause:** The KMP framework is **dynamic** (`isStatic = false` or default). The K/N linker creates `LC_LOAD_DYLIB` entries (`@rpath/FirebaseCore.framework/FirebaseCore`). Firebase SPM products are **static** libraries — their `.framework` bundles exist in `$BUILT_PRODUCTS_DIR` during build but are NOT embedded in the app bundle. At runtime, `dyld` searches `@rpath` and finds nothing.

**Solution:** Switch to a static framework:

```kotlin
iosTarget.binaries.framework {
    baseName = "Shared"
    isStatic = true  // Required when using dev.gitlive:firebase-* with SPM
}
```

With a static framework, all symbols are embedded in the `.a` archive. No `LC_LOAD_DYLIB` entries are created. Unresolved `-framework` flags from dev.gitlive klibs are deferred to the final Xcode app link, where `_internal_linkage_SwiftPMImport` provides them.

**After switching to static, also:**
1. Re-run `integrateLinkagePackage` — regenerates `Package.swift` with `type: .none` (static)
2. Remove any "Embed Frameworks" copy phase for the KMP framework — static frameworks must NOT be embedded
3. Add linker flags previously resolved by the K/N linker (e.g., `-framework Accelerate`, `-weak_framework CoreML`) to `OTHER_LDFLAGS` in the Xcode project

---

## Firebase-Specific Issues

### cinterop Failures on C++ Modules (gRPC, abseil, leveldb, BoringSSL)

**Symptom:** Build fails with cinterop errors on modules like `grpc`, `absl`, `leveldb`, `openssl_grpc`, or other C++ transitive dependencies of Firebase.

**Cause:** `discoverModulesImplicitly = true` (the default) makes Kotlin attempt cinterop on every Clang module in the dependency graph, including C++ modules that are not compatible.

**Solution:** Set `discoverModulesImplicitly = false` and explicitly list only the Firebase Clang modules you need:

```kotlin
swiftPMDependencies {
    discoverModulesImplicitly = false

    swiftPackage(
        url = url("https://github.com/firebase/firebase-ios-sdk.git"),
        version = from("12.6.0"),
        products = listOf(product("FirebaseAnalytics"), /* ... */),
        importedClangModules = listOf("FirebaseAnalytics", "FirebaseCore", /* ... */),
    )
}
```

See [common-pods-mapping.md](common-pods-mapping.md) for the full importedClangModules reference.

---

### Firebase Classes Not Found (Wrong Clang Module Name)

**Symptom:** `Unresolved reference` for Firebase classes like `FIRDatabase`, `FIRRemoteConfig`, `FIRFirestore`, `FIRInAppMessaging` even though the product is listed.

**Cause:** Several Firebase products expose ObjC headers through Clang modules whose names differ from the SPM product name. Using the product name in `importedClangModules` won't find the headers.

**Solution:** Use the correct internal Clang module names:

| SPM Product | Correct importedClangModules entry |
|---|---|
| FirebaseDatabase | `FirebaseDatabaseInternal` |
| FirebaseFirestore | `FirebaseFirestoreInternal` |
| FirebaseInAppMessaging-Beta | `FirebaseInAppMessagingInternal` |
| FirebaseRemoteConfig | `FirebaseRemoteConfigInternal` |

---

### FirebaseFirestore Import Errors

**Symptom:** Can't import FIRFirestore classes

**Cause:** Firestore's Clang module name differs from product name. The internal Clang module exposed to Objective-C is `FirebaseFirestoreInternal`, not `FirebaseFirestore`.

**Solution:** Add explicit importedClangModules:

```kotlin
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseFirestore")),
    importedClangModules = listOf("FirebaseFirestoreInternal"),  // Required
)
```

---

### Firebase Crashlytics: dSYM Upload Script Broken After Migration

**Symptom:** Crash reports don't appear in Firebase Console after migrating to SPM. Or the build phase fails with "No such file" errors referencing `${PODS_ROOT}/FirebaseCrashlytics/upload-symbols`.

**Cause:** The CocoaPods-era dSYM upload script references `${PODS_ROOT}` which no longer exists. The SPM equivalent is at a different path.

**Solution:** Update the existing "Run Script" build phase (or add one at the END if none exists):

```bash
"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
```

With input files:
```
${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}
${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist
$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist
$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)
```

Also set **Debug Information Format** to `DWARF with dSYM File` for all build configurations in Build Settings.

---

### Firebase Beta Products: SPM Name Differs

**Symptom:** `FirebaseInAppMessaging` or `FirebaseAppDistribution` not found as SPM product

**Cause:** Beta products have a `-Beta` suffix in SPM.

**Solution:** Use the correct SPM product name:
- `FirebaseInAppMessaging` → `FirebaseInAppMessaging-Beta`
- `FirebaseAppDistribution` → `FirebaseAppDistribution-Beta`

---

### dyld Crash When Mixing Firebase Across CocoaPods and SPM

**Symptom:** App crashes at launch with a dyld error like:
```
Symbol not found: _OBJC_CLASS_$_FIRFirestore
```
or similar `_OBJC_CLASS_$_FIR*` symbol-not-found errors. The Gradle build and Xcode compilation both succeed, but the app crashes at runtime.

**Cause:** Some Firebase pods were migrated to SPM while others remained in CocoaPods. All Firebase products share transitive dependencies (gRPC, abseil, leveldb, BoringSSL, nanopb). Having both package managers link these transitive dependencies causes duplicate/conflicting symbols that the dynamic linker cannot resolve.

**Solution:** Migrate **all** Firebase pods to SPM at once. This includes Swift-only pods (FirebaseAI, FirebaseFunctions, FirebaseMLModelDownloader) that Kotlin cannot use directly — add them as `products` entries without `importedClangModules`:

```kotlin
products = listOf(
    // ObjC pods used by Kotlin:
    product("FirebaseAnalytics"),
    product("FirebaseAuth"),
    // ...
    // Swift-only pods (no importedClangModules needed):
    product("FirebaseAI"),
    product("FirebaseFunctions"),
),
```

After adding new products, re-run `integrateLinkagePackage` to regenerate the linkage Swift package.

---

### Firebase Initialization Fails at Runtime

**Symptom:** App crashes on Firebase initialization

**Solution:**
1. Ensure `GoogleService-Info.plist` is in iOS app target
2. Call `FIRApp.configure()` before using any Firebase service
3. Check Firebase console for configuration issues

---

## Google Maps Issues

### GoogleMaps Version Not Found

**Symptom:** SPM can't resolve GoogleMaps package

**Solution:** GoogleMaps requires exact version matching:

```kotlin
swiftPackage(
    url = url("https://github.com/googlemaps/ios-maps-sdk.git"),
    version = exact("10.6.0"),  // Must use exact(), not from()
    products = listOf(
        product("GoogleMaps", platforms = setOf(iOS()))
    ),
)
```

Check [releases page](https://github.com/googlemaps/ios-maps-sdk/releases) for valid versions.

---

## KSP (Kotlin Symbol Processing) Compatibility

### KSP after updating Kotlin version

KSP should generally work with the target Kotlin version without any changes. Do NOT update KSP as part of the migration — it is out of scope.

If KSP does fail (unlikely), the issue is unrelated to the CocoaPods-to-SwiftPM migration itself. Present the error to the user and let them decide how to handle it separately.

---

## Manual Integration Command Discovery

If the xcodebuild approach in Phase 5.1 fails, discover paths manually and run integration tasks directly:

```bash
# Find iOS project directory (contains Podfile)
IOS_DIR=$(dirname "$(find . -name "Podfile" -type f | head -1)")

# Find .xcodeproj (exclude Pods.xcodeproj) - use realpath for absolute path
XCODEPROJ=$(realpath "$(find "$IOS_DIR" -maxdepth 1 -name "*.xcodeproj" -type d | grep -v Pods | head -1)")

# Find KMP module with swiftPMDependencies (module directory name)
KMP_MODULE=$(grep -rl "swiftPMDependencies" --include="build.gradle.kts" . | head -1 | xargs dirname | xargs basename)

XCODEPROJ_PATH="$XCODEPROJ" \
GRADLE_PROJECT_PATH=":$KMP_MODULE" \
./gradlew ":$KMP_MODULE:integrateEmbedAndSign" ":$KMP_MODULE:integrateLinkagePackage"
```

---

## Manual CocoaPods Deintegration from pbxproj

If `pod deintegrate` is not available, manually remove these CocoaPods references from `project.pbxproj`:

- `Pods_<target>.framework` build file and file reference
- `Pods-<target>.debug.xcconfig` / `Pods-<target>.release.xcconfig` file references
- `Pods` group and `Frameworks` group (if it only contained the Pods framework)
- `[CP] Check Pods Manifest.lock` shell script build phase
- `[CP] Embed Pods Frameworks` shell script build phase
- `baseConfigurationReference` lines pointing to Pods xcconfig files

---

## Manual Xcode Integration Steps

If the automatic `integrateEmbedAndSign` / `integrateLinkagePackage` tasks fail, set up the Xcode project manually:

1. Open `.xcodeproj` (or `.xcworkspace` if non-KMP CocoaPods remain)
2. Add "Compile Kotlin" run script phase BEFORE "Compile Sources":
   ```bash
   cd "$SRCROOT/.."
   ./gradlew :moduleName:embedAndSignAppleFrameworkForXcode
   ```
3. Set `ENABLE_USER_SCRIPT_SANDBOXING = NO` (Build Settings → Build Options → User Script Sandboxing)
4. Run `./gradlew --stop` to restart the Gradle daemon after changing sandboxing
5. Add local package: `../moduleName/_internal_linkage_SwiftPMImport`

---

## When Build Fails After Migration

**Do NOT revert the migration as a first response.** Instead:

1. **Read the full error log** — identify the actual failure type (Gradle resolution, import not found, linker error, Xcode build phase)
2. **Re-check each migration phase** — walk through Phases 2-6 and verify each step was applied. Common mistakes:
   - Missing JetBrains Maven repo in `settings.gradle.kts`
   - Wrong `group` or module name in import namespace (dashes not converted to dots)
   - `cocoapods {}` block or plugin not fully removed (Phase 6)
   - Wrong Xcode project file opened (`.xcodeproj` when non-KMP CocoaPods remain and `.xcworkspace` is needed, or vice versa)
   - `isStatic = true` missing from framework config (required with dev.gitlive or similar CocoaPods-era wrapper klibs)
   - `integrateLinkagePackage` not run
   - EmbedAndSign disabler code not removed (prevents `integrateEmbedAndSign`)
   - `embedAndSignAppleFrameworkForXcode` commented out in Xcode build phase
   - `cocoapods.*` imports replaced that should have been preserved (bundled klib from third-party library)
3. **Consult the sections above** for specific error patterns
4. **If unsure, present options to the user** — describe what the logs show, list possible causes, and let the user decide

---

## Rollback Instructions (Last Resort)

Only revert if analysis above does not resolve the issue:

### Step 1: Restore Git Files

```bash
# Restore CocoaPods files (adjust path if iOS project is not in iosApp/)
git checkout -- "**/Podfile" "**/Podfile.lock"
git checkout -- *.podspec
git checkout -- **/build.gradle.kts
git checkout -- **/src/**/*.kt
```

### Step 2: Restore CocoaPods in build.gradle.kts

```kotlin
plugins {
    kotlin("native.cocoapods")  // Re-add
}

kotlin {
    cocoapods {
        // Restore original configuration
    }
    // Remove swiftPMDependencies block
}
```

### Step 3: Restore Kotlin Imports

Change all imports back:
```kotlin
// FROM:
import swiftPMImport.group.module.ClassName

// TO:
import cocoapods.PodName.ClassName
```

### Step 4: Reinstall CocoaPods

```bash
# Navigate to directory containing Podfile (adjust path as needed)
cd <ios-project-directory>  # e.g., iosApp/, ios/, or project root
pod install
```

### Step 5: Open Workspace

Open `*.xcworkspace` (not .xcodeproj) from the iOS project directory in Xcode.

---

## Getting Help

If issues persist:

1. **Check sample projects:**
   - [kmp-with-cocoapods-compose-sample (spm_import branch)](https://github.com/Kotlin/kmp-with-cocoapods-compose-sample/tree/spm_import)
   - [kmp-with-cocoapods-firebase-sample (spm_import branch)](https://github.com/Kotlin/kmp-with-cocoapods-firebase-sample/tree/spm_import)

2. **Run verbose build:**
   ```bash
   ./gradlew build --info
   ```

3. **Check generated files:**
   - Look in `moduleName/_internal_linkage_SwiftPMImport/` for Package.swift

4. **Inspect klib contents** using the `klib` tool ([docs](https://kotlinlang.org/docs/native-libraries.html#using-kotlin-native-compiler)):
   ```bash
   # Dump all API signatures from a klib
   klib dump-metadata-signatures /path/to/library.klib

   # Search for specific classes
   klib dump-metadata-signatures /path/to/library.klib | grep "ClassName"

   # Compare before/after — find klibs in build output
   find . -name "*.klib" -path "*swiftPMImport*"     # new swiftPMImport klibs
   find ~/.gradle/caches -name "*.klib" -path "*libraryName*"  # third-party klibs
   ```
   This is particularly useful for verifying which classes are available in the swiftPMImport klib vs. bundled in third-party dependency klibs.
