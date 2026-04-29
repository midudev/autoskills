#!/bin/sh
#
# analyze-project.sh - Analyze a Gradle/KMP project for AGP 9.0 migration readiness
#
# Usage: ./analyze-project.sh [PROJECT_ROOT]
#        Defaults to current directory if PROJECT_ROOT is not specified.

set -e

PROJECT_ROOT="${1:-.}"

# Resolve to absolute path
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"

echo "========================================"
echo " KMP AGP 9.0 Migration - Project Analysis"
echo "========================================"
echo ""
echo "Project root: $PROJECT_ROOT"
echo ""

# --- Gradle Version ---
echo "----------------------------------------"
echo " Gradle Version"
echo "----------------------------------------"
WRAPPER_PROPS="$PROJECT_ROOT/gradle/wrapper/gradle-wrapper.properties"
if [ -f "$WRAPPER_PROPS" ]; then
    GRADLE_URL=$(grep 'distributionUrl' "$WRAPPER_PROPS" | sed 's/.*=//' | sed 's/\\//g')
    GRADLE_VERSION=$(echo "$GRADLE_URL" | sed 's|.*gradle-||' | sed 's|-.*||')
    echo "  Distribution URL: $GRADLE_URL"
    echo "  Gradle version:   $GRADLE_VERSION"
else
    echo "  WARNING: gradle-wrapper.properties not found"
    GRADLE_VERSION="unknown"
fi
echo ""

# --- AGP Version ---
echo "----------------------------------------"
echo " Android Gradle Plugin Version"
echo "----------------------------------------"
TOML_FILE="$PROJECT_ROOT/gradle/libs.versions.toml"
if [ -f "$TOML_FILE" ]; then
    AGP_VERSION=$(grep '^agp' "$TOML_FILE" | head -1 | sed 's/.*= *"//' | sed 's/".*//')
    if [ -n "$AGP_VERSION" ]; then
        echo "  AGP version (from version catalog): $AGP_VERSION"
    else
        echo "  AGP version not found in version catalog"
        AGP_VERSION="unknown"
    fi
else
    echo "  WARNING: libs.versions.toml not found"
    AGP_VERSION="unknown"
fi

KOTLIN_VERSION=$(grep '^kotlin' "$TOML_FILE" 2>/dev/null | head -1 | sed 's/.*= *"//' | sed 's/".*//')
if [ -n "$KOTLIN_VERSION" ]; then
    echo "  Kotlin version: $KOTLIN_VERSION"
fi
echo ""

# --- Module Analysis ---
echo "----------------------------------------"
echo " Module Analysis"
echo "----------------------------------------"

# Find all build.gradle.kts and build.gradle files
BUILD_FILES=$(find "$PROJECT_ROOT" -name "build.gradle.kts" -o -name "build.gradle" | grep -v '.gradle/' | grep -v 'build/' | sort)

for BUILD_FILE in $BUILD_FILES; do
    REL_PATH=$(echo "$BUILD_FILE" | sed "s|$PROJECT_ROOT/||")
    MODULE_DIR=$(dirname "$BUILD_FILE")
    REL_MODULE=$(echo "$MODULE_DIR" | sed "s|$PROJECT_ROOT||" | sed 's|^/||')

    if [ -z "$REL_MODULE" ]; then
        MODULE_NAME="(root)"
    else
        MODULE_NAME=":$(echo "$REL_MODULE" | sed 's|/|:|g')"
    fi

    echo ""
    echo "  Module: $MODULE_NAME"
    echo "  File:   $REL_PATH"

    # Detect plugins
    HAS_ANDROID_APP="no"
    HAS_ANDROID_LIB="no"
    HAS_KMP="no"
    HAS_KOTLIN_ANDROID="no"
    HAS_COMPOSE="no"
    HAS_APPLY_FALSE="no"

    if grep -q 'com.android.application\|androidApplication' "$BUILD_FILE"; then
        if grep -q 'apply false' "$BUILD_FILE" 2>/dev/null; then
            HAS_APPLY_FALSE="yes"
        else
            HAS_ANDROID_APP="yes"
        fi
    fi

    if grep -q 'com.android.library\|androidLibrary' "$BUILD_FILE"; then
        if grep -q 'apply false' "$BUILD_FILE" 2>/dev/null; then
            HAS_APPLY_FALSE="yes"
        else
            HAS_ANDROID_LIB="yes"
        fi
    fi

    if grep -q 'kotlin.multiplatform\|kotlin("multiplatform")\|kotlinMultiplatform' "$BUILD_FILE"; then
        HAS_KMP="yes"
    fi

    if grep -q 'kotlin.android\|kotlin("android")\|kotlinAndroid' "$BUILD_FILE"; then
        HAS_KOTLIN_ANDROID="yes"
    fi

    if grep -q 'org.jetbrains.compose\|composeMultiplatform' "$BUILD_FILE"; then
        HAS_COMPOSE="yes"
    fi

    echo "  Plugins detected:"
    [ "$HAS_ANDROID_APP" = "yes" ] && echo "    - com.android.application"
    [ "$HAS_ANDROID_LIB" = "yes" ] && echo "    - com.android.library"
    [ "$HAS_KMP" = "yes" ] && echo "    - kotlin.multiplatform"
    [ "$HAS_KOTLIN_ANDROID" = "yes" ] && echo "    - kotlin.android"
    [ "$HAS_COMPOSE" = "yes" ] && echo "    - org.jetbrains.compose"
    [ "$HAS_APPLY_FALSE" = "yes" ] && echo "    - (declarations with apply false — root buildscript)"

    # Check for android {} block
    HAS_ANDROID_BLOCK="no"
    if grep -q '^android {' "$BUILD_FILE" || grep -q '^android {' "$BUILD_FILE"; then
        HAS_ANDROID_BLOCK="yes"
        echo "  Has android {} block: yes"
    fi

    # Check source set layout
    if [ -d "$MODULE_DIR/src/main" ]; then
        echo "  Source layout: src/main (legacy Android)"
    fi
    if [ -d "$MODULE_DIR/src/androidMain" ]; then
        echo "  Source layout: src/androidMain (KMP)"
    fi
    if [ -d "$MODULE_DIR/src/commonMain" ]; then
        echo "  Source layout: src/commonMain (KMP)"
    fi

    # Determine migration recommendation
    echo "  Migration recommendation:"
    if [ "$HAS_APPLY_FALSE" = "yes" ]; then
        echo "    -> Root buildscript: update plugin versions only"
    elif [ "$HAS_KMP" = "yes" ] && [ "$HAS_ANDROID_LIB" = "yes" ]; then
        echo "    -> Replace com.android.library with android-kotlin-multiplatform-library"
        echo "    -> Move android {} config into androidTarget {} in kotlin {} block"
        echo "    -> Remove the standalone android {} block"
    elif [ "$HAS_KMP" = "yes" ] && [ "$HAS_ANDROID_APP" = "yes" ]; then
        echo "    -> Split into separate androidApp module (com.android.application)"
        echo "    -> Convert shared KMP module to use android-kotlin-multiplatform-library"
        echo "    -> Move Android entry point (Activity) to the new androidApp module"
    elif [ "$HAS_ANDROID_APP" = "yes" ] && [ "$HAS_KMP" = "no" ]; then
        echo "    -> Pure Android app module: update AGP to 9.x, no KMP migration needed"
    elif [ "$HAS_ANDROID_LIB" = "yes" ] && [ "$HAS_KMP" = "no" ]; then
        echo "    -> Pure Android library: update AGP to 9.x, no KMP migration needed"
        echo "    -> (Consider converting to KMP if cross-platform is desired)"
    elif [ "$HAS_KOTLIN_ANDROID" = "yes" ]; then
        echo "    -> Replace org.jetbrains.kotlin.android with kotlin.multiplatform if going KMP"
        echo "    -> Or keep as-is and just update AGP version"
    else
        echo "    -> No Android plugins detected: no AGP migration needed"
    fi
done

echo ""

# --- Gradle Properties Check ---
echo "----------------------------------------"
echo " Gradle Properties"
echo "----------------------------------------"
GRADLE_PROPS="$PROJECT_ROOT/gradle.properties"
if [ -f "$GRADLE_PROPS" ]; then
    LEGACY_FLAGS=""
    if grep -q 'android.enableLegacyVariantApi' "$GRADLE_PROPS"; then
        LEGACY_FLAGS="$LEGACY_FLAGS\n    - android.enableLegacyVariantApi (must be removed for AGP 9.0)"
    fi
    if grep -q 'android.useAndroidX' "$GRADLE_PROPS"; then
        LEGACY_FLAGS="$LEGACY_FLAGS\n    - android.useAndroidX (default in AGP 9.0, can be removed)"
    fi
    if grep -q 'android.enableJetifier' "$GRADLE_PROPS"; then
        LEGACY_FLAGS="$LEGACY_FLAGS\n    - android.enableJetifier (removed in AGP 9.0, must be removed)"
    fi
    if grep -q 'android.nonTransitiveRClass' "$GRADLE_PROPS"; then
        LEGACY_FLAGS="$LEGACY_FLAGS\n    - android.nonTransitiveRClass (default in AGP 9.0, can be removed)"
    fi

    if [ -n "$LEGACY_FLAGS" ]; then
        echo "  Legacy flags found:"
        printf "$LEGACY_FLAGS\n"
    else
        echo "  No legacy flags found"
    fi
else
    echo "  No gradle.properties file found"
fi
echo ""

# --- Summary ---
echo "========================================"
echo " Summary"
echo "========================================"
echo ""
echo "  Current AGP version:    $AGP_VERSION"
echo "  Current Gradle version: $GRADLE_VERSION"
echo "  Target AGP version:     9.0.0+"
echo "  Target Gradle version:  9.1.0+"
echo ""

if [ "$AGP_VERSION" != "unknown" ]; then
    AGP_MAJOR=$(echo "$AGP_VERSION" | cut -d. -f1)
    if [ "$AGP_MAJOR" -ge 9 ] 2>/dev/null; then
        echo "  Status: Project appears to already be on AGP 9.0+"
    else
        echo "  Status: Project needs migration from AGP $AGP_VERSION to 9.0+"
    fi
fi

echo ""
echo "========================================"
echo " Run the migration skill for guided assistance."
echo "========================================"
