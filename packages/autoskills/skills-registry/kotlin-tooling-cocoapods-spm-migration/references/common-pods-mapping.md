# Common Pods to SwiftPM Mapping

Reference for migrating popular CocoaPods dependencies to SwiftPM.

## Firebase Suite

All Firebase products come from a single repository: `https://github.com/firebase/firebase-ios-sdk.git`

**Key facts:**
- SPM product names match CocoaPods pod names (e.g., pod `FirebaseAuth` → product `FirebaseAuth`)
- Exception: Beta products have a `-Beta` suffix in SPM (e.g., `FirebaseAppDistribution-Beta`)
- The CocoaPods umbrella pod `Firebase` does not exist in SPM — import specific products
- **Platform requirements**: iOS 15+, macOS 10.15+, tvOS 15+, watchOS 7+
- **Xcode**: 16.2+

> **WARNING: Do not mix Firebase across CocoaPods and SPM.** All Firebase products share a single repository and common transitive dependencies (gRPC, abseil, leveldb, BoringSSL, nanopb, etc.). If some Firebase pods remain in CocoaPods while others are added via SPM, the shared transitive dependencies get linked twice with conflicting symbols, causing **dyld crashes at runtime** (e.g., `Symbol not found: _OBJC_CLASS_$_FIRFirestore`). When migrating Firebase, move **all** Firebase pods to SPM at once — including Swift-only pods (FirebaseAI, FirebaseFunctions, FirebaseMLModelDownloader) that Kotlin cannot use directly. Add Swift-only pods as `products` entries without `importedClangModules`. After adding new products, re-run `integrateLinkagePackage` to regenerate the linkage Swift package.

### Firebase SPM Products Reference

| CocoaPods Pod | SPM Product | Platform | KMP Notes |
|---------------|-------------|----------|-----------|
| FirebaseAnalytics | FirebaseAnalytics | All | ObjC classes: `FIRAnalytics`, `FIRApp` |
| FirebaseAuth | FirebaseAuth | All (partial on macOS/tvOS/watchOS) | ObjC classes: `FIRAuth`, `FIRUser` |
| FirebaseCore | FirebaseCore | All | ObjC class: `FIRApp` |
| FirebaseCrashlytics | FirebaseCrashlytics | All | ObjC class: `FIRCrashlytics` |
| FirebaseDatabase | FirebaseDatabase | All | **importedClangModules: `FirebaseDatabaseInternal`** — ObjC classes: `FIRDatabase`, `FIRDatabaseReference` |
| FirebaseFirestore | FirebaseFirestore | All | **Special case** — see below |
| FirebaseFunctions | FirebaseFunctions | All | ObjC class: `FIRFunctions` |
| FirebaseMessaging | FirebaseMessaging | All | ObjC classes: `FIRMessaging` |
| FirebaseRemoteConfig | FirebaseRemoteConfig | All | **importedClangModules: `FirebaseRemoteConfigInternal`** — ObjC class: `FIRRemoteConfig` |
| FirebaseStorage | FirebaseStorage | All | ObjC class: `FIRStorage` |
| FirebaseAppCheck | FirebaseAppCheck | All (watchOS 9+) | ObjC class: `FIRAppCheck` |
| FirebasePerformance | FirebasePerformance | iOS/tvOS only | ObjC class: `FIRPerformance` |
| FirebaseInAppMessaging | FirebaseInAppMessaging-Beta | iOS/tvOS only | `-Beta` suffix in SPM, **importedClangModules: `FirebaseInAppMessagingInternal`** |
| FirebaseAppDistribution | FirebaseAppDistribution-Beta | iOS only | Note `-Beta` suffix in SPM |
| FirebaseInstallations | FirebaseInstallations | All | ObjC class: `FIRInstallations` |
| FirebaseABTesting | *(no SPM product)* | All | **Module-only**: pulled transitively by RemoteConfig. List in `importedClangModules` only |
| FirebaseAILogic | FirebaseAI | All | **Renamed in SPM**. Swift-only — no `importedClangModules` entry needed |
| FirebaseMLModelDownloader | FirebaseMLModelDownloader | All | Swift-only — no `importedClangModules` entry needed |

### FirebaseAnalytics

```kotlin
// CocoaPods
pod("FirebaseAnalytics") { version = "12.5.0" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseAnalytics")),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.FIRAnalytics
import swiftPMImport.<group>.<module>.FIRApp
```

### FirebaseAuth

```kotlin
// CocoaPods
pod("FirebaseAuth") { version = "12.5.0" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseAuth")),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.FIRAuth
import swiftPMImport.<group>.<module>.FIRUser
```

### FirebaseDatabase

Database's Clang module name differs from its SPM product name. You **must** specify `importedClangModules`.

```kotlin
// CocoaPods
pod("FirebaseDatabase") { version = "12.5.0" }

// SwiftPM - Note the importedClangModules parameter
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseDatabase")),
    importedClangModules = listOf("FirebaseDatabaseInternal"),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.FIRDatabase
import swiftPMImport.<group>.<module>.FIRDatabaseReference
```

### FirebaseFirestore (Special Case)

Firestore's Clang module name differs from its SPM product name. You **must** specify `importedClangModules`.

```kotlin
// CocoaPods
pod("FirebaseFirestore") { version = "12.5.0" }

// SwiftPM - Note the importedClangModules parameter
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseFirestore")),
    importedClangModules = listOf("FirebaseFirestoreInternal"),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.FIRFirestore
import swiftPMImport.<group>.<module>.FIRDocumentReference
```

**Why is this needed?** Firestore distributes as a binary xcframework. The internal Clang module exposed to Objective-C is named `FirebaseFirestoreInternal`, not `FirebaseFirestore`. Without `importedClangModules`, the KMP compiler cannot discover the Objective-C headers.

### FirebaseCrashlytics

```kotlin
// CocoaPods
pod("FirebaseCrashlytics") { version = "12.5.0" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/firebase/firebase-ios-sdk.git"),
    version = from("12.6.0"),
    products = listOf(product("FirebaseCrashlytics")),
)
```

**iOS project requirement:** Crashlytics needs a dSYM upload run script in the Xcode build phases. After migration, add a "Run Script" phase at the END of build phases:

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

Also set **Debug Information Format** to `DWARF with dSYM File` for all build configurations.

### Combined Firebase Example

When using multiple Firebase products, declare them in a single package. **Set `discoverModulesImplicitly = false`** — Firebase's transitive C++ dependencies (gRPC, abseil, leveldb, BoringSSL) contain Clang modules that fail cinterop. Explicitly list only the modules you need.

```kotlin
swiftPMDependencies {
    discoverModulesImplicitly = false

    swiftPackage(
        url = url("https://github.com/firebase/firebase-ios-sdk.git"),
        version = from("12.6.0"),
        products = listOf(
            product("FirebaseAnalytics"),
            product("FirebaseAuth"),
            product("FirebaseDatabase"),
            product("FirebaseFirestore"),
            product("FirebaseCrashlytics"),
            product("FirebaseMessaging"),
            product("FirebaseRemoteConfig"),
            // Swift-only pods (products only, no importedClangModules):
            product("FirebaseAI"),
            product("FirebaseFunctions"),
        ),
        importedClangModules = listOf(
            "FirebaseAnalytics",
            "FirebaseAuth",
            "FirebaseCore",
            "FirebaseCrashlytics",
            "FirebaseDatabaseInternal",      // Not "FirebaseDatabase"
            "FirebaseFirestoreInternal",     // Not "FirebaseFirestore"
            "FirebaseMessaging",
            "FirebaseRemoteConfigInternal",  // Not "FirebaseRemoteConfig"
            "FirebaseABTesting",             // Module-only, no product
        ),
    )
}
```

### Firebase importedClangModules Reference

Several Firebase products expose ObjC headers through Clang modules whose names differ from the SPM product name:

| SPM Product | Clang Module (importedClangModules) | Notes |
|---|---|---|
| FirebaseAnalytics | FirebaseAnalytics | Same name |
| FirebaseAuth | FirebaseAuth | Same name |
| FirebaseCore | FirebaseCore | Same name |
| FirebaseCrashlytics | FirebaseCrashlytics | Same name |
| FirebaseDatabase | **FirebaseDatabaseInternal** | Different |
| FirebaseFirestore | **FirebaseFirestoreInternal** | Different |
| FirebaseInAppMessaging-Beta | **FirebaseInAppMessagingInternal** | Different |
| FirebaseRemoteConfig | **FirebaseRemoteConfigInternal** | Different |
| FirebaseInstallations | FirebaseInstallations | Same name |
| FirebaseMessaging | FirebaseMessaging | Same name |
| FirebasePerformance | FirebasePerformance | Same name |
| FirebaseStorage | FirebaseStorage | Same name |
| FirebaseAppCheck | FirebaseAppCheck | Same name |
| FirebaseAppDistribution-Beta | FirebaseAppDistribution | Same name (no `-Beta`) |
| *(transitive)* | **FirebaseABTesting** | Module-only, no product |
| FirebaseAI | *(none)* | Swift-only, no cinterop |
| FirebaseFunctions | *(none)* | Swift-only, no cinterop |
| FirebaseMLModelDownloader | *(none)* | Swift-only, no cinterop |

**Note:** When `discoverModulesImplicitly = false` (recommended for Firebase), you must list every Clang module you import in `importedClangModules`. When `true` (default), `importedClangModules` is ignored — but this will fail for Firebase due to C++ transitive dependencies.

### Firebase Initialization

Ensure `GoogleService-Info.plist` is included in the iOS app target. In the app's entry point:

```swift
import Firebase
FirebaseApp.configure()  // Must be called before using any Firebase service
```

---

## Google Maps

Repository: `https://github.com/googlemaps/ios-maps-sdk.git`

**Key facts:**
- **iOS 16+ only** — no macOS, tvOS, or watchOS support
- **Xcode 16.0+** required
- Must use `exact()` version — `from()` will fail to resolve
- Single SPM product: `GoogleMaps`
- Requires a Google Maps Platform API key configured in the iOS app
- Uses semantic versioning; check [releases](https://github.com/googlemaps/ios-maps-sdk/releases) for available versions (latest: 10.8.0)

```kotlin
// CocoaPods
pod("GoogleMaps") { version = "10.3.0" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/googlemaps/ios-maps-sdk.git"),
    version = exact("10.6.0"),  // Must use exact(), not from()
    products = listOf(
        product("GoogleMaps", platforms = setOf(iOS()))  // iOS-only platform constraint required
    ),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.GMSMapView
import swiftPMImport.<group>.<module>.GMSCameraPosition
import swiftPMImport.<group>.<module>.GMSMarker
import swiftPMImport.<group>.<module>.GMSServices
```

**iOS project requirement:** The API key must be set in the app delegate or SwiftUI app entry point:

```swift
import GoogleMaps
GMSServices.provideAPIKey("YOUR_API_KEY")
```

---

## Google Sign-In

Repository: `https://github.com/google/GoogleSignIn-iOS.git`

**Key facts:**
- **iOS 12+, macOS 10.15+** — broad platform support
- Two SPM products: `GoogleSignIn` (core) and `GoogleSignInSwift` (SwiftUI support)
- CocoaPods pods: `GoogleSignIn` and `GoogleSignInSwiftSupport`
- Uses `from()` versioning (latest: 9.1.0)

```kotlin
// CocoaPods
pod("GoogleSignIn") { version = "8.0.0" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/google/GoogleSignIn-iOS.git"),
    version = from("8.0.0"),
    products = listOf(product("GoogleSignIn")),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.GIDSignIn
import swiftPMImport.<group>.<module>.GIDSignInButton
```

**iOS project requirement:** Add `GIDClientID` to `Info.plist` and configure the URL scheme for OAuth redirect. See [Google Sign-In iOS docs](https://developers.google.com/identity/sign-in/ios/start-integrating).

---

## LoremIpsum

Simple text generation library with direct mapping.

```kotlin
// CocoaPods
pod("LoremIpsum") { version = "2.0.1" }

// SwiftPM
swiftPackage(
    url = url("https://github.com/lukaskubanek/LoremIpsum.git"),
    version = from("2.0.1"),
    products = listOf(product("LoremIpsum")),
)
```

**Kotlin import:**
```kotlin
import swiftPMImport.<group>.<module>.LoremIpsum
```

---

## Quick Reference Table

| Pod Name | SPM Product | SPM Repository | Version Type | Platform | Notes |
|----------|-------------|----------------|--------------|----------|-------|
| FirebaseAnalytics | FirebaseAnalytics | firebase/firebase-ios-sdk.git | from() | All | |
| FirebaseAuth | FirebaseAuth | firebase/firebase-ios-sdk.git | from() | All | |
| FirebaseCore | FirebaseCore | firebase/firebase-ios-sdk.git | from() | All | |
| FirebaseCrashlytics | FirebaseCrashlytics | firebase/firebase-ios-sdk.git | from() | All | Needs dSYM upload script |
| FirebaseDatabase | FirebaseDatabase | firebase/firebase-ios-sdk.git | from() | All | importedClangModules: FirebaseDatabaseInternal |
| FirebaseFirestore | FirebaseFirestore | firebase/firebase-ios-sdk.git | from() | All | importedClangModules: FirebaseFirestoreInternal |
| FirebaseFunctions | FirebaseFunctions | firebase/firebase-ios-sdk.git | from() | All | |
| FirebaseMessaging | FirebaseMessaging | firebase/firebase-ios-sdk.git | from() | All | |
| FirebaseRemoteConfig | FirebaseRemoteConfig | firebase/firebase-ios-sdk.git | from() | All | importedClangModules: FirebaseRemoteConfigInternal |
| FirebaseStorage | FirebaseStorage | firebase/firebase-ios-sdk.git | from() | All | |
| FirebasePerformance | FirebasePerformance | firebase/firebase-ios-sdk.git | from() | iOS/tvOS | |
| FirebaseInAppMessaging | FirebaseInAppMessaging-Beta | firebase/firebase-ios-sdk.git | from() | iOS/tvOS | `-Beta` suffix, importedClangModules: FirebaseInAppMessagingInternal |
| FirebaseAppDistribution | FirebaseAppDistribution-Beta | firebase/firebase-ios-sdk.git | from() | iOS only | `-Beta` suffix |
| FirebaseABTesting | *(none)* | firebase/firebase-ios-sdk.git | — | All | Module-only, importedClangModules only |
| FirebaseAILogic | FirebaseAI | firebase/firebase-ios-sdk.git | from() | All | Renamed, Swift-only |
| GoogleMaps | GoogleMaps | googlemaps/ios-maps-sdk.git | exact() | iOS 16+ only | Requires platform constraint |
| GoogleSignIn | GoogleSignIn | google/GoogleSignIn-iOS.git | from() | iOS 12+, macOS 10.15+ | |
| GoogleSignInSwiftSupport | GoogleSignInSwift | google/GoogleSignIn-iOS.git | from() | iOS 12+, macOS 10.15+ | SwiftUI support |
| LoremIpsum | LoremIpsum | lukaskubanek/LoremIpsum.git | from() | All | |

---

## KMP Wrapper Libraries with Bundled Cinterop Klibs

Some KMP libraries that wrap iOS SDKs ship pre-built cinterop klibs using the `cocoapods.*` package namespace. After migrating to SwiftPM, these `cocoapods.*` imports **must be preserved** — they resolve to the library's bundled klib, not to actual CocoaPods infrastructure.

### KMPNotifier

Repository: [https://github.com/mirzemehdi/KMPNotifier](https://github.com/mirzemehdi/KMPNotifier)
Maven: `io.github.mirzemehdi:kmpnotifier`

**What it provides:** A KMP push notification library that wraps Firebase Cloud Messaging on iOS. The library bundles its own cinterop klib with namespace `cocoapods.FirebaseMessaging`, providing Kotlin bindings for `FIRMessaging`, `FIRMessagingAPNSTokenType`, and related classes.

**Impact on migration:**
- When `swiftPMDependencies` generates cinterop bindings, it detects that `FirebaseMessaging` bindings already exist in KMPNotifier's klib and **skips generating new bindings** for that Clang module
- `import cocoapods.FirebaseMessaging.FIRMessaging` must remain unchanged — do NOT replace with `swiftPMImport.*`
- `FirebaseMessaging` should still be listed in `products` and `importedClangModules` for SPM linking, even though cinterop bindings won't be generated for it

**Verifying bundled klib contents:** Use `klib dump-metadata-signatures` to inspect what a library's klib provides ([docs](https://kotlinlang.org/docs/native-libraries.html#using-kotlin-native-compiler)):

```bash
find ~/.gradle/caches -name "*.klib" -path "*kmpnotifier*" | head -1
klib dump-metadata-signatures /path/to/cinterop.klib | grep "FIRMessaging"
# Shows: cocoapods.FirebaseMessaging/FIRMessaging → confirms bundled klib
```

**Example — project using both KMPNotifier and GoogleSignIn:**
```kotlin
// IOSDelegate.kt — after migration
import cocoapods.FirebaseMessaging.FIRMessaging           // KEEP — from kmpnotifier klib
import cocoapods.FirebaseMessaging.FIRMessagingAPNSTokenType  // KEEP — from kmpnotifier klib
import swiftPMImport.com.example.app.GIDSignIn            // REPLACE — direct cinterop
```

### dev.gitlive/firebase-kotlin-sdk

Repository: [https://github.com/GitLiveApp/firebase-kotlin-sdk](https://github.com/GitLiveApp/firebase-kotlin-sdk)
Maven: `dev.gitlive:firebase-auth`, `dev.gitlive:firebase-firestore`, `dev.gitlive:firebase-storage`, etc.

**What it provides:** Kotlin-first Firebase APIs for KMP. Unlike KMPNotifier, dev.gitlive libraries provide **high-level Kotlin APIs** — you typically don't use `cocoapods.*` imports directly. Instead, the Firebase pods were declared with `linkOnly = true` in CocoaPods to provide native linking only.

**Impact on migration:**

1. **Linker flags baked into published klibs.** The dev.gitlive klibs contain `-framework FirebaseCore`, `-framework FirebaseAuth`, etc. from the CocoaPods era. These persist when the consuming project switches to SPM. With SPM, Firebase frameworks land in per-product subdirectories (`$BUILT_PRODUCTS_DIR/FirebaseCore/FirebaseCore.framework`) that the K/N linker doesn't search automatically.

   **Fix:** Add per-product `-F` linkerOpts to `build.gradle.kts`:
   ```kotlin
   val builtProductsDir = System.getenv("BUILT_PRODUCTS_DIR")
   if (builtProductsDir != null) {
       listOf("FirebaseCore", "FirebaseAuth", "FirebaseCoreExtension",
              "FirebaseCoreInternal", "FirebaseCrashlytics", "FirebaseFirestore",
              "FirebaseFirestoreInternal", "FirebaseInstallations", "FirebaseMessaging",
              "FirebaseStorage", "GoogleDataTransport", "GoogleUtilities",
              "GTMSessionFetcher", "AppCheckCore", /* ... */).forEach { product ->
           linkerOpts("-F", "$builtProductsDir/$product")
       }
   }
   ```
   Also add matching `FRAMEWORK_SEARCH_PATHS` in the Xcode project for both Debug and Release.

2. **Must use `isStatic = true`.** With a dynamic framework, the K/N linker creates `@rpath/FirebaseCore.framework/FirebaseCore` load instructions. Firebase SPM products are static libraries — their `.framework` bundles are not embedded in the app bundle. At runtime, `dyld` crashes with `Library not loaded`. Switching to `isStatic = true` embeds all symbols and defers unresolved framework flags to the final Xcode link.

3. **iOS test tasks may fail.** The K/N test runner cannot find Firebase frameworks outside of Xcode context. You may need to disable iOS test tasks:
   ```kotlin
   tasks.matching {
       (it.name.contains("Ios") || it.name.contains("ios")) &&
           (it.name.contains("Test") || it.name.contains("test"))
   }.configureEach { enabled = false }
   ```

---

## Researching Other Pods

For pods not listed here:

1. **Check GitHub repository** - Look for a `Package.swift` file in the repo
2. **Check CocoaPods spec** - The `source` field often points to the Git URL
3. **Search Swift Package Index** - https://swiftpackageindex.com/
4. **Check library documentation** - Many libraries document SPM installation

### Finding the Clang Module Name

If you're unsure of the correct Clang module name:

1. Keep `discoverModulesImplicitly = true` (default)
2. Run `./gradlew build`
3. Check build errors for available class names
4. Or check the library's `module.modulemap` file in its source

### Identifying Bundled Cinterop Klibs in Unknown Libraries

If you suspect a KMP library bundles its own cinterop klibs (common for libraries wrapping iOS SDKs), use the `klib` tool to inspect them ([docs](https://kotlinlang.org/docs/native-libraries.html#using-kotlin-native-compiler)):

```bash
# Find klibs from a specific library in Gradle caches
find ~/.gradle/caches -name "*.klib" -path "*libraryName*"

# Dump API signatures to see what namespaces and classes are provided
klib dump-metadata-signatures /path/to/library.klib | grep "cocoapods\."

# If output shows cocoapods.* entries, the library bundles cinterop klibs
# Those cocoapods.* imports must be preserved after migration
```

Indicators that a library may bundle cinterop klibs:
- The project has `linkOnly = true` pod declarations for the same native SDK
- The library's documentation mentions CocoaPods integration or cinterop
- The library provides Kotlin APIs for an iOS SDK (Firebase, Maps, etc.)

### Version Compatibility

SPM versions may differ from CocoaPods versions. Always:
1. Check the GitHub releases page for SPM-compatible versions
2. **Preserve version constraint semantics from the `cocoapods {}` block.** CocoaPods `version = "X.Y.Z"` (without `~>`) is an exact pin — use `exact("X.Y.Z")` in SPM, not `from()`. Using `from()` for an exact version can resolve to a newer version that breaks cinterop APIs if symbols were removed or renamed. Only use `from()` when the CocoaPods spec used optimistic versioning (`~>`).
3. Test thoroughly after migration
