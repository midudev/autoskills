# SwiftPM Import DSL Reference

Complete reference for the `swiftPMDependencies {}` DSL in Kotlin Multiplatform.

## Basic Structure

`swiftPackage()` and `localSwiftPackage()` are annotated with `@ExperimentalKotlinGradlePluginApi` (warning level). Add the opt-in at the top of `build.gradle.kts`:

```kotlin
@file:OptIn(org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi::class)
```

```kotlin
kotlin {
    iosArm64()
    iosSimulatorArm64()

    swiftPMDependencies {
        // Deployment versions
        iosMinimumDeploymentTarget = "16.0"
        macosMinimumDeploymentTarget = "13.0"
        tvosMinimumDeploymentTarget = "16.0"
        watchosMinimumDeploymentTarget = "9.0"

        // Module discovery (default: true)
        discoverClangModulesImplicitly = true

        // Package declarations
        swiftPackage(...)
        localSwiftPackage(...)
    }
}
```

---

## Package Declaration

The DSL has two API forms. **Use the simple string API** for most packages. Use the typed API only when you need `exact()`, `branch()`, `revision()`, or platform constraints.

### Simple API (Preferred)

Plain strings for URL, version, and products. The `version` parameter maps to a **minimum version** (`from()`) internally. The `importedClangModules` defaults to the `products` list automatically.

```kotlin
swiftPackage(
    url = "https://github.com/owner/repo.git",
    version = "1.0.0",   // Equivalent to from("1.0.0") — minimum version
    products = listOf("ProductName", "AnotherProduct"),
)
```

### Typed API (Advanced)

Use when you need exact version pinning, branch tracking, platform constraints, or explicit Clang module control:

```kotlin
swiftPackage(
    url = url("https://github.com/owner/repo.git"),
    version = exact("1.0.0"),
    products = listOf(
        product("ProductName"),
        product("PlatformSpecific", platforms = setOf(iOS()))
    ),
    importedClangModules = listOf("CustomClangModuleName"),
)
```

### Remote Package (Swift Package Registry)

```kotlin
swiftPackage(
    repository = id("scope.package-name"),
    version = from("1.0.0"),
    products = listOf(product("ProductName")),
    packageName = "package-name",
)
```

### Local Package

```kotlin
localSwiftPackage(
    directory = layout.projectDirectory.dir("../LocalPackage"),
    products = listOf("LocalPackage"),
)
```

To create a new local package (e.g., a Swift/ObjC wrapper around a Swift-only library):

```shell
cd /path/to/shared
mkdir LocalPackage && cd LocalPackage
swift package init --type library --name LocalPackage
```

Then use it in Kotlin:
```kotlin
// src/appleMain/kotlin/useLocalPackage.kt
import swiftPMImport.<group>.<module>.HelloFromLocalPackage

@OptIn(kotlinx.cinterop.ExperimentalForeignApi::class)
fun useLocalPackage() {
    HelloFromLocalPackage().hello()
}
```

---

## Version Specification

| Syntax | Description | Use Case |
|--------|-------------|----------|
| `version = "1.0.0"` (simple API) | Minimum version — equivalent to `from("1.0.0")` | Most packages |
| `version = exact("1.0")` | Exact version pin | Strict dependencies, migration |
| `version = from("1.0")` | Minimum version (explicit) | Same as simple string |
| `version = branch("name")` | Git branch | Development, testing |
| `version = revision("hash")` | Git commit hash | Pinning specific commits |
| `version = range("1.0", "2.0")` | Version range | Constraining upper bound |

**Important for migration:** The simple string `version = "X.Y.Z"` resolves to a minimum version (`from()`), which may pull a newer version than what was in CocoaPods. For exact version preservation during migration, use the typed API: `version = exact("X.Y.Z")`.

---

## Product Configuration

### Simple API

```kotlin
products = listOf("FirebaseAnalytics", "FirebaseAuth")
```

With the simple API, `importedClangModules` defaults to the same list as `products`. This works when product names match Clang module names.

### Typed API — Platform Constraints

For packages that only support certain platforms, use the typed `product()` function:

```kotlin
products = listOf(
    product("GoogleMaps", platforms = setOf(iOS()))  // iOS only
)
```

Available platforms: `iOS()`, `macOS()`, `tvOS()`, `watchOS()`

### Typed API — Per-Product Clang Module Override

```kotlin
products = listOf(
    product("FirebaseDatabase", importedClangModules = setOf("FirebaseDatabaseInternal"))
)
```

---

## Module Import Configuration

### Automatic Discovery (Default)

By default, `discoverClangModulesImplicitly = true`. SwiftPM import automatically discovers and imports all accessible Clang modules.

**IMPORTANT:** When `discoverClangModulesImplicitly = true`, the `importedClangModules` parameter is ignored. Only set `importedClangModules` when `discoverClangModulesImplicitly = false`.

**IMPORTANT for Firebase:** Set `discoverClangModulesImplicitly = false` when using Firebase. Firebase's transitive C++ dependencies (gRPC, abseil, leveldb, BoringSSL) contain Clang modules that fail cinterop generation. Disable implicit discovery and explicitly list only the Firebase modules you need in `importedClangModules`.

### Explicit Module Import

When automatic discovery is disabled and the Clang module name differs from the product name, use the typed API:

```kotlin
swiftPMDependencies {
    discoverClangModulesImplicitly = false  // Disable auto-discovery

    swiftPackage(
        url = url("https://github.com/firebase/firebase-ios-sdk.git"),
        version = from("12.6.0"),
        products = listOf(
            product("FirebaseAnalytics"),
            product("FirebaseFirestore")
        ),
        importedClangModules = listOf(
            "FirebaseAnalytics",
            "FirebaseCore",
            "FirebaseFirestoreInternal"  // Note: different from product name
        ),
    )
}
```

### When to Use importedClangModules

| Scenario | Use importedClangModules? |
|----------|---------------------|
| Simple API, product name = Clang module name | No (auto-defaulted from products) |
| Product name != Clang module name | Yes (typed API) |
| Multiple modules per product | Yes (typed API) |
| Using discoverClangModulesImplicitly = false | Yes (typed API) |

---

## Deployment Versions

Set minimum deployment targets for each platform:

```kotlin
swiftPMDependencies {
    iosMinimumDeploymentTarget = "16.0"
    macosMinimumDeploymentTarget = "13.0"
    tvosMinimumDeploymentTarget = "16.0"
    watchosMinimumDeploymentTarget = "9.0"
}
```

---

## Complete Example

```kotlin
plugins {
    alias(libs.plugins.kotlinMultiplatform)
}

group = "org.example.myproject"
version = "1.0-SNAPSHOT"

kotlin {
    iosArm64()
    iosSimulatorArm64()

    // Framework configuration (moved from cocoapods block)
    listOf(iosArm64(), iosSimulatorArm64()).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "SharedModule"
            isStatic = true
        }
    }

    swiftPMDependencies {
        iosMinimumDeploymentTarget = "16.0"

        // Simple API — most packages
        swiftPackage(
            url = "https://github.com/lukaskubanek/LoremIpsum.git",
            version = "2.0.1",
            products = listOf("LoremIpsum"),
        )

        // Simple API — Google Maps
        swiftPackage(
            url = "https://github.com/googlemaps/ios-maps-sdk.git",
            version = "10.3.0",
            products = listOf("GoogleMaps"),
        )

        // Local package
        localSwiftPackage(
            directory = layout.projectDirectory.dir("LocalWrapper"),
            products = listOf("LocalWrapper"),
        )
    }

    compilerOptions {
        optIn.add("kotlinx.cinterop.ExperimentalForeignApi")
    }
}
```

---

## Transitive Dependencies

SwiftPM dependencies are handled automatically. When you run Kotlin/Native tests or link a framework, the Kotlin Gradle Plugin will provision necessary machine code from transitive SwiftPM dependencies. This behavior is automatic.

You can optionally declare transitive dependencies explicitly to pin specific versions:

```kotlin
swiftPMDependencies {
    // Main dependency
    swiftPackage(
        url = "https://github.com/firebase/firebase-ios-sdk.git",
        version = "12.5.0",
        products = listOf("FirebaseAnalytics"),
    )

    // Transitive dependency with explicit version pin
    swiftPackage(
        url = url("https://github.com/apple/swift-protobuf.git"),
        version = exact("1.32.0"),
        products = listOf(product("SwiftProtobuf")),
    )
}
```
