# CocoaPods Extras Patterns

Patterns to look for in `build.gradle.kts` files beyond the standard `cocoapods {}` block. These are workarounds, hacks, and glue code that projects accumulate over time to work around CocoaPods limitations.

## Detection Patterns (Phase 1 step 11)

- **Custom tasks that hook into CocoaPods tasks** — e.g., tasks registered with `tasks.named("podInstall") { finalizedBy(...) }` or `tasks.register("fixXcodeProject")` that patch `Pods.xcodeproj/project.pbxproj` to fix paths, tweak build settings, or work around CocoaPods quirks. These are pure CocoaPods workarounds and become dead code after migration.
- **Pods.xcodeproj patching** — any code that reads/writes `Pods.xcodeproj` files (e.g., replacing Gradle invocation paths, fixing scheme settings). The `Pods.xcodeproj` will no longer exist after migration.
- `cocoapods.summary`, `cocoapods.homepage`, `cocoapods.version`, `cocoapods.name` — podspec metadata (safe to remove)
- `cocoapods.podfile` — explicit Podfile path reference
- `cocoapods.extraSpecAttributes` — custom podspec attributes
- `pod("...", extraOpts = ...)` or `pod("...", moduleName = ...)` — non-standard pod configurations
- `noPodspec()` — disables podspec generation
- **Any code referencing `Pods/` directory, `.xcworkspace`, or `podspec` files** — build logic, path constants, or task inputs/outputs tied to CocoaPods artifacts
- Compiler flags or linker settings added specifically for CocoaPods interop (e.g., `-framework`, cinterop `defFile` for pod headers)

---

## Phase 6.4 Cleanup Categories

### Safe to remove (no user consultation needed)

- `cocoapods.summary`, `cocoapods.homepage`, `cocoapods.version`, `cocoapods.name` — podspec metadata, not used by SPM
- `cocoapods.podfile = project.file(...)` — Podfile path reference, not used by SPM
- `cocoapods.extraSpecAttributes` — podspec attributes, not used by SPM
- `noPodspec()` — podspec generation flag, not used by SPM
- Custom Gradle tasks that hook into CocoaPods tasks (`podInstall`, `podSetup`, `generatePodspec`) — these tasks no longer exist without the plugin. This includes any tasks registered via `tasks.named("podInstall") { finalizedBy(...) }` or similar wiring. Example of dead code to remove entirely:
  ```kotlin
  // REMOVE — CocoaPods workaround, no longer needed
  tasks.register("fixXcodeProject") {
      doLast {
          val xcodeProjectFile = project.file("../iosApp/Pods/Pods.xcodeproj/project.pbxproj")
          // ... patching Pods.xcodeproj paths ...
      }
  }
  tasks.named("podInstall") { finalizedBy("fixXcodeProject") }
  ```
- Any code that reads/writes `Pods.xcodeproj` files — the `Pods/` directory will no longer exist
- References to `Pods/` directory paths, `.xcworkspace` files, or `podspec` files in build configurations

### Requires analysis — consult the user if unsure

- `pod("...", extraOpts = ...)` — extra options may indicate special compilation flags needed. Check if the underlying library needs equivalent flags in `swiftPMDependencies` (e.g., `importedClangModules`, platform constraints)
- `pod("...", moduleName = ...)` — custom module name may indicate the Clang module name differs from the pod name. This likely maps to an `importedClangModules` entry in the SPM package declaration
- Custom cinterop `defFile` configurations for pod headers — these may need to be adapted or may no longer be needed if the SwiftPM import handles the headers automatically. Present findings to the user before removing
- Compiler or linker flags added specifically for CocoaPods interop (e.g., `-framework Pod`, custom `cinterops {}` blocks) — analyze whether the SPM integration handles this automatically. If unclear, present the flags to the user and ask whether they are still needed
- Any custom task wiring or build logic that references CocoaPods outputs — explain what the task does and ask the user whether equivalent functionality is needed
