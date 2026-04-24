# SwiftPM Import DSL Reference

Complete reference for the `swiftPMDependencies {}` DSL in Kotlin Multiplatform.

## Basic Structure

```kotlin
kotlin {
    iosArm64()
    iosSimulatorArm64()

    swiftPMDependencies {
        // Deployment versions
        iosDeploymentVersion.set("16.0")
        macosDeploymentVersion.set("13.0")
        tvosDeploymentVersion.set("16.0")
        watchosDeploymentVersion.set("9.0")

        // IDE integration
        xcodeProjectPathForKmpIJPlugin.set(
            layout.projectDirectory.file("../iosApp/iosApp.xcodeproj")
        )

        // Module discovery (default: true)
        discoverModulesImplicitly = true

        // Package declarations
        swiftPackage(...)
        localSwiftPackage(...)
    }
}
```

---

## Package Declaration

### Remote Package (Git URL)

```kotlin
swiftPackage(
    url = url("https://github.com/owner/repo.git"),
    version = from("1.0.0"),
    products = listOf(
        product("ProductName"),
        product("AnotherProduct")
    ),
)
```

### Remote Package (Swift Package Registry)

```kotlin
swiftPackage(
    repository = id("scope.package-name"),
    version = from("1.0.0"),
    products = listOf(product("ProductName")),
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

| Function | Description | Use Case |
|----------|-------------|----------|
| `from("1.0")` | Minimum version (like Gradle "require") | Most packages |
| `exact("1.0")` | Exact version (like Gradle "strict") | GoogleMaps, strict dependencies |
| `branch("name")` | Git branch | Development, testing |
| `revision("hash")` | Git commit hash | Pinning specific commits |

### Examples

```kotlin
// Minimum version - allows compatible updates
version = from("12.5.0")

// Exact version - no updates
version = exact("10.3.0")

// Branch tracking
version = branch("main")

// Specific commit
version = revision("abc123def456")
```

---

## Product Configuration

### Basic Product

```kotlin
products = listOf(product("FirebaseAnalytics"))
```

### Multiple Products from Same Package

```kotlin
products = listOf(
    product("FirebaseAnalytics"),
    product("FirebaseAuth"),
    product("FirebaseFirestore")
)
```

### Platform-Constrained Product

For packages that only support certain platforms:

```kotlin
products = listOf(
    product("GoogleMaps", platforms = setOf(iOS()))  // iOS only
)
```

Available platforms:
- `iOS()`
- `macOS()`
- `tvOS()`
- `watchOS()`

---

## Module Import Configuration

### Automatic Discovery (Default)

By default, `discoverModulesImplicitly = true`. SwiftPM import automatically discovers and imports all accessible Clang modules.

**IMPORTANT:** When `discoverModulesImplicitly = true`, the `importedClangModules` parameter is ignored. Only set `importedClangModules` when `discoverModulesImplicitly = false`.

**IMPORTANT for Firebase:** Set `discoverModulesImplicitly = false` when using Firebase. Firebase's transitive C++ dependencies (gRPC, abseil, leveldb, BoringSSL) contain Clang modules that fail cinterop generation. Disable implicit discovery and explicitly list only the Firebase modules you need in `importedClangModules`.

### Explicit Module Import

When automatic discovery is disabled and the Clang module name differs from the product name:

```kotlin
swiftPMDependencies {
    discoverModulesImplicitly = false  // Disable auto-discovery

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
| Product name = module name | No (auto-discovery works) |
| Product name != module name | Yes |
| Multiple modules per product | Yes |
| Using discoverModulesImplicitly = false | Yes |

---

## Deployment Versions

Set minimum deployment targets for each platform:

```kotlin
swiftPMDependencies {
    iosDeploymentVersion.set("16.0")
    macosDeploymentVersion.set("13.0")
    tvosDeploymentVersion.set("16.0")
    watchosDeploymentVersion.set("9.0")
}
```

---

## IDE Integration

If you are using the KMP IntelliJ plugin to build the iOS application, specify the path to the `.xcodeproj` that has the `embedAndSignAppleFrameworkForXcode` integration:

```kotlin
kotlin {
    listOf(
        iosArm64(),
        iosSimulatorArm64(),
        iosX64(),
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "Shared"
            isStatic = true
        }
    }

    swiftPMDependencies {
        xcodeProjectPathForKmpIJPlugin.set(
            layout.projectDirectory.file("../iosApp/iosApp.xcodeproj")
        )
    }
}
```

This enables the IDE to properly resolve SwiftPM dependencies and provide code completion. The path should point to the `.xcodeproj` file (not `.xcworkspace`).

---

## Complete Example

```kotlin
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
}

group = "org.example.myproject"
version = "1.0-SNAPSHOT"

kotlin {
    iosArm64()
    iosSimulatorArm64()

    swiftPMDependencies {
        iosDeploymentVersion.set("16.0")

        xcodeProjectPathForKmpIJPlugin.set(
            layout.projectDirectory.file("../iosApp/iosApp.xcodeproj")
        )

        // Firebase packages
        swiftPackage(
            url = url("https://github.com/firebase/firebase-ios-sdk.git"),
            version = from("12.6.0"),
            products = listOf(
                product("FirebaseAnalytics"),
                product("FirebaseAuth"),
                product("FirebaseFirestore")
            ),
        )

        // Google Maps (iOS only, exact version)
        swiftPackage(
            url = url("https://github.com/googlemaps/ios-maps-sdk.git"),
            version = exact("10.6.0"),
            products = listOf(
                product("GoogleMaps", platforms = setOf(iOS()))
            ),
        )

        // Local package
        localSwiftPackage(
            directory = layout.projectDirectory.dir("LocalWrapper"),
            products = listOf("LocalWrapper"),
        )
    }

    // Framework configuration (moved from cocoapods block)
    listOf(
        iosArm64(),
        iosSimulatorArm64(),
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "SharedModule"
            isStatic = true
        }
    }

    sourceSets.configureEach {
        languageSettings {
            optIn("kotlinx.cinterop.ExperimentalForeignApi")
        }
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
        url = url("https://github.com/firebase/firebase-ios-sdk.git"),
        version = from("12.5.0"),
        products = listOf(product("FirebaseAnalytics")),
    )

    // Transitive dependency with explicit version
    swiftPackage(
        url = url("https://github.com/apple/swift-protobuf.git"),
        version = exact("1.32.0"),
        products = listOf(),  // No direct import needed
    )
}
```
