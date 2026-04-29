# Version Compatibility Matrix for KMP AGP 9.0 Migration

---

## Compatibility Table

| Component                     | Minimum            | Recommended         | Notes                                                                                                                                                                                                                                                                            |
|-------------------------------|--------------------|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AGP                           | 9.0.0              | 9.0.1+              | 9.0.0 is the initial release; 9.0.1+ includes early bug fixes                                                                                                                                                                                                                    |
| Gradle                        | 9.1.0              | 9.1.0+              | AGP 9.0 requires Gradle 9.1+; earlier Gradle versions will not work                                                                                                                                                                                                              |
| JDK                           | 17                 | 17+                 | AGP 9.0 requires JDK 17 minimum                                                                                                                                                                                                                                                  |
| SDK Build Tools               | 36.0.0             | 36.0.0              | Required by AGP 9.0                                                                                                                                                                                                                                                              |
| KGP (Kotlin Gradle Plugin)    | 2.0.0              | 2.3.0+              | 2.0.0 is minimum for KMP library plugin; 2.3.0+ has best compatibility                                                                                                                                                                                                           |
| KGP (built-in Kotlin runtime) | 2.2.10             | 2.3.0+              | AGP 9.0 has runtime dependency on KGP 2.2.10; auto-upgrades if lower                                                                                                                                                                                                             |
| KSP                           | 2.3.1              | 2.3.6               | KSP version is no longer tied to the Kotlin compiler version since 2.3.0. AGP 9.0 and built-in Kotlin support added in 2.3.1. KSP migrated away from the deprecated compilerOptions KGP API in 2.3.3; earlier versions may have compatibility problems with other Gradle plugins |
| NDK                           | —                  | 28.2.13676358       | Default changed to r28c; specify explicitly if needed                                                                                                                                                                                                                            |
| Android Studio                | Otter 3 (2025.2.3) | Latest stable       | First version with full AGP 9.0 + KMP library plugin IDE support                                                                                                                                                                                                                 |
| IntelliJ IDEA                 | Not supported      | —                   | Does not support AGP 9.0 as of 2026.1, use Android Studio instead. Can still be used for non-Android KMP targets (JVM, iOS, JS/Wasm)                                                                                                                                             |
| Max API Level                 | —                  | 36.1                | Highest supported API level in AGP 9.0                                                                                                                                                                                                                                           |
| Compose Multiplatform         | 1.9.3              | 1.10.0+             | AGP 9.0 support was added in 1.9.3                                                                                                                                                                                                                                               |
| Compose Compiler Plugin       | 2.0.0              | Matches KGP version | Since KGP 2.0, use `org.jetbrains.kotlin.plugin.compose` — version is tied to KGP automatically                                                                                                                                                                                  |
| Kotlin Coroutines             | 1.8.0              | 1.10.0+             | 1.8.0+ for full K2 support                                                                                                                                                                                                                                                       |
| Kotlin Serialization          | 1.6.0              | 1.8.0+              | 1.8.0+ for K2 compiler plugin support                                                                                                                                                                                                                                            |
| Ktor                          | 2.3.0              | 3.0.0+              | 3.0.0 for best KMP library plugin compatibility                                                                                                                                                                                                                                  |
| Room (KMP)                    | 2.7.0              | 2.8.0+              | KMP Room requires KSP; verify KSP compatibility                                                                                                                                                                                                                                  |

---


## Version Notes

### AGP 9.0.0

- First release supporting `com.android.kotlin.multiplatform.library`.
- Built-in Kotlin compilation for `com.android.application` and `com.android.library` (no separate `kotlin-android` plugin needed).
- Removes support for `com.android.application` + `org.jetbrains.kotlin.multiplatform` in the same module.
- Single-variant model for KMP libraries (no build types/flavors).
- Runtime dependency on KGP 2.2.10 — projects using lower KGP versions are auto-upgraded.
- If the project uses KSP, upgrade to 2.3.1+ for AGP 9.0 support.
- New DSL interfaces only — `BaseExtension` and legacy types removed.
- `org.jetbrains.kotlin.kapt` incompatible — use KSP or `com.android.legacy-kapt`.
- Java source/target default changed from Java 8 to Java 11.
- R class is compile-time non-final in application modules by default.
- `targetSdk` defaults to `compileSdk` when not set (was `minSdk`).
- NDK default changed to r28c.
- Requires JDK 17+, Gradle 9.1.0+, SDK Build Tools 36.0.0.
- Many Gradle property defaults changed — see SKILL.md "Gradle Properties Default Changes".
- Removed: embedded Wear OS app support, density split APKs, legacy variant APIs.
- New: IDE support for test fixtures, fused library plugin (preview).

### AGP 9.0.1+

- Bug fixes for KMP library plugin edge cases.
- Improved error messages for common migration mistakes.
- Better IDE sync performance.

### KGP 2.3.0+

- Best compatibility with KMP AGP 9.0 library plugin.
- Improved multiplatform source set inference.
- Better error diagnostics for KMP configuration issues.
- Stable Compose compiler plugin integration.

---

## Upgrade Path

### From AGP 8.x + KGP 1.9.x

1. Upgrade KGP to 2.0.0+ first (can be done on AGP 8.x).
2. Migrate `kotlinOptions` to `compilerOptions`.
3. Upgrade Gradle to 9.1.0.
4. Upgrade AGP to 9.0.1+.
5. Migrate library plugins to `com.android.kotlin.multiplatform.library`.
6. Upgrade KGP to 2.3.0+ for best experience.

### From AGP 8.x + KGP 2.0.x

1. Upgrade Gradle to 9.1.0.
2. Upgrade AGP to 9.0.1+.
3. Migrate library plugins to `com.android.kotlin.multiplatform.library`.
4. Upgrade KGP to 2.3.0+ for best experience.

---

## gradle/wrapper/gradle-wrapper.properties

```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-9.1-bin.zip
```

---

## Basic libs.versions.toml template

```toml
[versions]
agp = "9.0.1"
kotlin = "2.3.20"
compose-multiplatform = "1.10.3"

[plugins]
androidApplication = { id = "com.android.application", version.ref = "agp" }
androidKmpLibrary = { id = "com.android.kotlin.multiplatform.library", version.ref = "agp" }
kotlinMultiplatform = { id = "org.jetbrains.kotlin.multiplatform", version.ref = "kotlin" }
kotlinJvm = { id = "org.jetbrains.kotlin.jvm", version.ref = "kotlin" }
composeMultiplatform = { id = "org.jetbrains.compose", version.ref = "compose-multiplatform" }
composeCompiler = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
```

---

## Compatibility Validation Commands

Run these to verify your setup is compatible:

```bash
# Check Gradle version
./gradlew --version

# Check AGP version applied
./gradlew buildEnvironment | grep -e "com.android.library" -e "com.android.application" -e "com.android.kotlin.multiplatform.library"

# Check KGP version
./gradlew buildEnvironment | grep "org.jetbrains.kotlin:kotlin-gradle-plugin"

# Verify the KMP library plugin is recognized
./gradlew :shared:tasks --group=build

# Full validation build
./gradlew :shared:assemble :androidApp:assembleDebug
```
