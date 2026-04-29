# Plugin Testing Guide

## Overview

Flutter plugins require special testing strategies because they include native code. This guide covers testing plugin packages with Dart, native, and integration tests.

## Test Types for Plugins

| Type           | Tests                      | Runs On         | Purpose                           |
|----------------|---------------------------|------------------|-----------------------------------|
| Dart Unit      | Single classes/functions  | Dart VM        | Test Dart code in isolation       |
| Dart Widget     | UI components             | Test environment | Test widget behavior              |
| Dart Integration | Dart + Native bridge     | Device/Emulator | Test full plugin functionality    |
| Native Unit     | Native code              | Native test env | Test native code in isolation     |
| Native UI       | Native UI + Flutter UI  | Device/Emulator | Test native UI interactions       |

## Project Structure

```
my_plugin/
├── lib/                    # Dart code
│   └── my_plugin.dart
├── android/                 # Android native code
│   └── src/test/           # Android unit tests
├── ios/                    # iOS native code
├── example/                 # Example app
│   ├── integration_test/      # Integration tests
│   ├── ios/RunnerTests/     # iOS tests
│   └── lib/
├── test/                    # Dart unit tests
│   └── my_plugin_test.dart
└── pubspec.yaml
```

## Dart Unit Tests

### Basic Plugin Unit Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin/my_plugin.dart';

void main() {
  test('plugin initializes correctly', () {
    final plugin = MyPlugin();
    expect(plugin.initialized, false);
    
    plugin.initialize();
    expect(plugin.initialized, true);
  });
  
  test('processes data correctly', () {
    final plugin = MyPlugin();
    final result = plugin.processData([1, 2, 3]);
    
    expect(result, [2, 4, 6]);
  });
}
```

### Mocking Platform Channels in Unit Tests

```dart
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin/my_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late MyPlugin plugin;
  
  setUp(() {
    // Mock platform channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.example.my_plugin'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getNativeValue') {
          return 42;
        }
        return null;
      },
    );
    
    plugin = MyPlugin();
  });
  
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.example.my_plugin'),
      null,
    );
  });
  
  test('gets value from native side', () async {
    final result = await plugin.getNativeValue();
    expect(result, 42);
  });
}
```

## Dart Integration Tests

### Setup

Add to `example/pubspec.yaml`:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
  my_plugin:
    path: ../
```

### Basic Integration Test

```dart
// example/integration_test/my_plugin_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_plugin_example/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('plugin works in real app', (tester) async {
    await tester.pumpWidget(const MyApp());
    
    final plugin = MyPlugin();
    final result = await plugin.getNativeValue();
    
    expect(result, greaterThan(0));
  });
}
```

### Create Test Driver

```dart
// test_driver/integration_test.dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

### Run Integration Tests

```bash
# From example directory
cd example
flutter test integration_test/

# Or with driver
flutter drive --target=integration_test/my_plugin_test.dart
```

## Android Unit Tests

### Setup

Create test in `android/src/test/java/com/example/my_plugin/MyPluginTest.java`:

```java
package com.example.my_plugin;

import org.junit.Test;
import static org.junit.Assert.*;

public class MyPluginTest {
    
    @Test
    public void testNativeMethod() {
        MyPlugin plugin = new MyPlugin();
        int result = plugin.calculate(10, 20);
        
        assertEquals(30, result);
    }
    
    @Test
    public void testStringProcessing() {
        MyPlugin plugin = new MyPlugin();
        String result = plugin.process("hello");
        
        assertEquals("HELLO", result);
    }
}
```

### Run Android Tests

```bash
# From android directory
cd example/android

# Run all tests
./gradlew testDebugUnitTest

# Run specific test
./gradlew test --tests MyPluginTest.testNativeMethod
```

## iOS Unit Tests

### Setup

Create test in `example/ios/RunnerTests/RunnerTests.m`:

```objectivec
#import <XCTest/XCTest.h>
#import "MyPlugin.h"

@interface MyPluginTest : XCTestCase
@end

@implementation MyPluginTest

- (void)setUp {
    [super setUp];
    // Setup code
}

- (void)testNativeMethod {
    MyPlugin *plugin = [[MyPlugin alloc] init];
    NSInteger result = [plugin calculateWithA:10 b:20];
    
    XCTAssertEqual(result, 30);
}

- (void)testStringProcessing {
    MyPlugin *plugin = [[MyPlugin alloc] init];
    NSString *result = [plugin processString:@"hello"];
    
    XCTAssertEqualObjects(result, @"HELLO");
}

@end
```

### Run iOS Tests

```bash
# From ios directory
cd example/ios

# Run tests
xcodebuild test -workspace Runner.xcworkspace -scheme Runner -configuration Debug

# Or run from Xcode
# Product > Test
```

## Native UI Tests (Espresso/XCUITest)

### Android Espresso Test

```java
// android/src/androidTest/java/com/example/my_plugin/UiTest.java
package com.example.my_plugin;

import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.rule.ActivityTestRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.assertion.ViewAssertions.matches;
import static androidx.test.espresso.matcher.ViewMatchers.isDisplayed;
import static androidx.test.espresso.matcher.ViewMatchers.withText;

@RunWith(AndroidJUnit4.class)
public class UiTest {
    
    @Rule
    public ActivityTestRule<MainActivity> activityRule = 
        new ActivityTestRule<>(MainActivity.class);
    
    @Test
    public void testPluginButton() {
        onView(withText("Plugin Button"))
            .check(matches(isDisplayed()));
    }
}
```

### iOS XCUITest

```objectivec
// example/ios/RunnerUITests/RunnerUITests.m
#import <XCTest/XCTest.h>

@interface RunnerUITests : XCTestCase
@end

@implementation RunnerUITests

- (void)setUp {
    [super setUp];
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
}

- (void)testPluginButtonExists {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *button = app.buttons[@"Plugin Button"];
    
    XCTAssertTrue(button.exists);
}

- (void)testPluginButtonClick {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *button = app.buttons[@"Plugin Button"];
    
    [button tap];
    
    XCUIElement *result = app.staticTexts[@"Success"];
    XCTAssertTrue(result.exists);
}

@end
```

## Testing Plugin Initialization

### Test Plugin Registration

```dart
testWidgets('plugin registers correctly', (tester) async {
  final calls = <MethodCall>[];
  
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('com.example.my_plugin'),
    (MethodCall methodCall) async {
      calls.add(methodCall);
      return null;
    },
  );
  
  await tester.pumpWidget(const MyApp());
  
  expect(calls.any((call) => call.method == 'initialize'), true);
});
```

## Testing Error Handling

### Native Error Handling

```dart
testWidgets('handles native errors', (tester) async {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('com.example.my_plugin'),
    (MethodCall methodCall) async {
      if (methodCall.method == 'failingMethod') {
        throw PlatformException(
          code: 'ERROR',
          message: 'Native error occurred',
        );
      }
      return null;
    },
  );
  
  final plugin = MyPlugin();
  
  expect(
    () => plugin.failingMethod(),
    throwsA(isA<PlatformException>()),
  );
});
```

## Testing Platform-Specific Features

### Android-Specific Tests

```java
@Test
public void testAndroidOnlyFeature() {
    MyPlugin plugin = new MyPlugin();
    
    // Test Android-specific API
    Context context = InstrumentationRegistry.getTargetContext();
    String deviceModel = plugin.getDeviceModel(context);
    
    assertNotNull(deviceModel);
}
```

### iOS-Specific Tests

```objectivec
- (void)testIOSOnlyFeature {
    MyPlugin *plugin = [[MyPlugin alloc] init];
    
    // Test iOS-specific API
    NSString *deviceName = plugin.getDeviceName();
    
    XCTAssertNotNil(deviceName);
}
```

## Testing Multiple Platforms

### Platform Detection Test

```dart
testWidgets('works on all platforms', (tester) async {
  final plugin = MyPlugin();
  final platform = await plugin.getPlatform();
  
  if (Platform.isAndroid) {
    expect(platform, contains('Android'));
  } else if (Platform.isIOS) {
    expect(platform, contains('iOS'));
  }
});
```

## Testing Performance

### Native Performance Test

```java
@Test
public void testPerformance() {
    MyPlugin plugin = new MyPlugin();
    
    long startTime = System.nanoTime();
    plugin.heavyOperation();
    long endTime = System.nanoTime();
    
    long duration = endTime - startTime;
    long maxDuration = 100_000_000; // 100ms
    
    assertTrue("Operation too slow", duration < maxDuration);
}
```

## Best Practices

1. **Test at each layer** - Dart, native, and integration
2. **Mock platform channels** - In Dart unit tests
3. **Test error cases** - Native failures, network issues
4. **Use integration tests** - Test full plugin functionality
5. **Test on real devices** - For platform-specific features
6. **Keep tests isolated** - Each test should be independent
7. **Test all platforms** - Android, iOS, web, desktop
8. **Document platform limitations** - Note platform-specific behavior

## CI/CD for Plugins

### GitHub Actions

```yaml
name: Plugin Tests

on: [push, pull_request]

jobs:
  dart-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter test
      
  android-tests:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Android tests
        run: |
          cd example/android
          ./gradlew testDebugUnitTest
          
  ios-tests:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run iOS tests
        run: |
          cd example/ios
          xcodebuild test -workspace Runner.xcworkspace \
            -scheme Runner -configuration Debug
```
