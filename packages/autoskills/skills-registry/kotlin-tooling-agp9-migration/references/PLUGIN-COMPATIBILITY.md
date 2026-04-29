# Plugin Compatibility: AGP 9.0

AGP 9.0 introduces breaking changes that affect many third-party plugins. **Before migrating, check
which plugins the project uses and whether they are compatible.**

---

## Known Compatible Plugins (minimum version required)

| Plugin                              | Minimum Compatible Version | Notes                                                                                                                                |
|-------------------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| `com.google.devtools.ksp`           | 2.3.1 (2.3.3+ recommended) | 2.3.1 adds AGP 9.0 support; 2.3.3+ fixes deprecated compilerOptions KGP API usage. May need `android.disallowKotlinSourceSets=false` |
| `com.google.dagger.hilt.android`    | 2.59                       | —                                                                                                                                    |
| `com.google.firebase.firebase-perf` | 2.0.2                      | —                                                                                                                                    |
| `androidx.navigation.safeargs`      | 2.9.5                      | —                                                                                                                                    |
| `org.jetbrains.compose`             | 1.9.3                      | —                                                                                                                                    |
| `org.jetbrains.dokka`               | 2.2.0-Beta                 | —                                                                                                                                    |
| `app.cash.burst`                    | 2.10.0                     | —                                                                                                                                    |
| `com.google.firebase.testlab`       | 0.0.1-alpha11              | —                                                                                                                                    |

---

## Plugins Requiring Opt-Out Flags

These work but require temporarily setting `android.newDsl=false` (or other flags):

| Plugin                                                  | Workaround                                                                                          |
|---------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| `androidx.baselineprofile` (< 1.5.0-alpha01)            | `android.newDsl=false`                                                                              |
| `de.mannodermaus.android-junit5` (< 1.13.4.0)           | `android.newDsl=false`                                                                              |
| `com.google.android.gms:oss-licenses-plugin` (< 0.10.8) | `android.newDsl=false`                                                                              |
| `com.apollographql.apollo` (< 4.4.0)                    | `android.newDsl=false`                                                                              |
| `org.gradle.android.cache-fix` (< 3.0.2)                | `android.newDsl=false`                                                                              |
| `com.github.triplet.play` (< 4.0.0)                     | `android.newDsl=false`                                                                              |
| `app.cash.sqldelight`                                   | `android.newDsl=false` + `android.disallowKotlinSourceSets=false`                                   |
| `com.google.protobuf`                                   | `android.newDsl=false`                                                                              |
| `app.cash.paparazzi`                                    | `android.newDsl=false`                                                                              |
| `io.gitlab.arturbosch.detekt` (< 2.0.0)                 | `android.newDsl=false` + `android.builtInKotlin=false`                                              |
| `org.jlleitschuh.gradle.ktlint`                         | `android.builtInKotlin=false`                                                                       |
| `dev.icerock.mobile.multiplatform-resources` (< 0.26.0) | `android.builtInKotlin=false` + `android.newDsl=false` + `android.sourceset.disallowProvider=false` |

---

## Known Broken Plugins (No Workaround)

| Plugin                       | Status                    |
|------------------------------|---------------------------|
| `com.newrelic.agent.android` | Incompatible with AGP 9.0 |
| `com.huawei.agconnect.agcp`  | Incompatible with AGP 9.0 |

---

## What To Do

1. **Inventory all plugins** used in the project
2. **Check each against the tables above**
3. **If any plugin is broken without workaround**, inform the user — they may need to wait for a plugin update or remove it
4. **If plugins need opt-out flags**, add them to `gradle.properties` and note them as temporary workarounds
5. **Update plugin versions** to their AGP 9.0-compatible versions before or during migration
