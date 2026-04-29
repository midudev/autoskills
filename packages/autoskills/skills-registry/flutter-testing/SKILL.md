---
name: flutter-testing
description: Comprehensive Flutter testing guidance covering unit tests, widget tests, and integration tests. Use when working with Flutter applications to write unit tests for functions/methods/classes, create widget tests to verify UI components, develop integration tests for end-to-end testing, mock dependencies and plugin interactions, debug common testing errors, test Flutter plugins with native code, and run tests in different build modes (debug, profile, release)
metadata:
  author: Stanislav [MADTeacher] Chernyshev
  version: "1.0"
---

# Flutter Testing

## Overview

This skill provides comprehensive guidance for testing Flutter applications across all test types. Flutter testing falls into three categories:

- **Unit tests** - Test individual functions, methods, or classes in isolation
- **Widget tests** (component tests) - Test single widgets and verify UI appearance and behavior
- **Integration tests** - Test complete apps or large parts to verify end-to-end functionality

A well-tested Flutter app has many unit and widget tests for code coverage, plus enough integration tests to cover important use cases.

### Test Type Trade-offs

| Tradeoff          | Unit   | Widget | Integration |
|-------------------|--------|--------|-------------|
| Confidence        | Low    | Higher | Highest     |
| Maintenance cost  | Low    | Higher | Highest     |
| Dependencies      | Few    | More   | Most        |
| Execution speed   | Quick  | Quick  | Slow        |

### Build Modes for Testing

Flutter supports three build modes with different implications for testing:

- **Debug mode** - Use during development with hot reload. Assertions enabled, debugging enabled, but performance is janky
- **Profile mode** - Use for performance analysis. Similar to release mode but with some debugging features enabled
- **Release mode** - Use for deployment. Assertions disabled, optimized for speed and size

## Quick Start

### Unit Tests

Unit tests test a single function, method, or class. Mock external dependencies and avoid disk I/O or UI rendering.

```dart
import 'package:test/test.dart';
import 'package:my_app/counter.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });
}
```

Run with: `flutter test`

### Widget Tests

Widget tests test single widgets to verify UI appearance and interaction.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
    
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
    
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

### Integration Tests

Integration tests test complete apps on real devices or emulators.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('tap button, verify counter', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byKey(const ValueKey('increment')));
    await tester.pumpAndSettle();
    
    expect(find.text('1'), findsOneWidget);
  });
}
```

Run with: `flutter test integration_test/`

## Testing Workflow Decision Tree

1. **What are you testing?**
   - Single function/class → [Unit Tests](#unit-tests)
   - Single widget/component → [Widget Tests](#widget-tests)
   - Complete user flow → [Integration Tests](#integration-tests)

2. **Does it depend on plugins/native code?**
   - Yes → See [Plugins in Tests](#plugins-in-tests) or [Testing Plugins](#testing-plugins)

3. **Need to mock dependencies?**
   - Yes → See [Mocking Guide](references/mocking.md)

4. **Encountering errors?**
   - See [Common Testing Errors](references/common-errors.md)

## Unit Tests

Unit tests verify the correctness of a unit of logic under various conditions.

### When to Use Unit Tests

- Testing business logic functions
- Validating data transformations
- Testing state management logic
- Mocking external services/API calls

### Key Concepts

- Use `package:test/test.dart`
- Mock dependencies using Mockito or similar
- Avoid file I/O or UI rendering
- Fast execution, high maintainability

### Advanced Unit Testing

For mocking dependencies, plugin interactions, and complex scenarios, see [Unit Testing Reference](references/unit-testing.md).

## Widget Tests

Widget tests verify widget UI appearance and behavior in a test environment.

### When to Use Widget Tests

- Testing widget rendering
- Verifying user interactions (taps, drags, scrolling)
- Testing different orientations
- Validating widget state changes

### Widget Testing Patterns

#### Finding Widgets

```dart
// By text
final titleFinder = find.text('Title');

// By widget type
final buttonFinder = find.byType(ElevatedButton);

// By key
final fabFinder = find.byKey(const ValueKey('increment'));

// By widget instance
final myWidgetFinder = find.byWidget(myWidgetInstance);
```

#### User Interactions

```dart
// Tap
await tester.tap(buttonFinder);

// Drag
await tester.drag(listFinder, const Offset(0, -300));

// Enter text
await tester.enterText(fieldFinder, 'Hello World');

// Scroll
await tester.fling(listFinder, const Offset(0, -500), 10000);
await tester.pumpAndSettle();
```

#### Testing Different Orientations

```dart
testWidgets('widget in landscape mode', (tester) async {
  // Set to landscape
  await tester.binding.setSurfaceSize(const Size(800, 400));
  await tester.pumpWidget(const MyApp());
  
  // Verify landscape behavior
  expect(find.byType(MyWidget), findsOneWidget);
  
  // Reset to portrait
  addTearDown(tester.binding.setSurfaceSize(null));
});
```

### Advanced Widget Testing

For scrolling, complex interactions, and performance testing, see [Widget Testing Reference](references/widget-testing.md).

## Integration Tests

Integration tests test complete apps or large parts on real devices or emulators.

### When to Use Integration Tests

- Testing complete user flows
- Verifying multiple screens/pages
- Testing navigation flows
- Performance profiling

### Integration Test Structure

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('end-to-end test', () {
    testWidgets('complete user flow', (tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Step 1: Navigate to screen
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      
      // Step 2: Enter credentials
      await tester.enterText(find.byKey(const Key('username')), 'user');
      await tester.enterText(find.byKey(const Key('password')), 'pass');
      
      // Step 3: Submit
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      
      // Verify result
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
```

### Performance Testing

```dart
testWidgets('scrolling performance', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  final listFinder = find.byType(ListView);
  
  // Measure performance
  final timeline = await tester.trace(() async {
    await tester.fling(listFinder, const Offset(0, -500), 10000);
    await tester.pumpAndSettle();
  });
  
  // Analyze timeline data
  expect(timeline.frames.length, greaterThan(10));
});
```

### Advanced Integration Testing

For performance profiling, CI integration, and complex scenarios, see [Integration Testing Reference](references/integration-testing.md).

## Plugins in Tests

When testing code that uses plugins, special handling is required to avoid crashes.

### Testing App Code with Plugins

If your Flutter app uses plugins, you need to mock the platform channel calls in unit/widget tests.

```dart
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    // Mock platform channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('your.plugin.channel'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getPlatformVersion') {
          return 'Android 12';
        }
        return null;
      },
    );
  });
  
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('your.plugin.channel'),
      null,
    );
  });
}
```

### Testing Plugins

For comprehensive guidance on testing Flutter plugins (including native code), see [Plugin Testing Reference](references/plugin-testing.md).

## Common Testing Errors

### 'A RenderFlex overflowed...'

Yellow and black stripes indicate overflow. Usually caused by unconstrained children in Row/Column.

**Solution:** Wrap the overflowing widget in `Expanded` or `Flexible`.

```dart
// Problem
Row(
  children: [
    Icon(Icons.message),
    Column(children: [Text('Very long text...')]), // Overflow!
  ],
)

// Solution
Row(
  children: [
    Icon(Icons.message),
    Expanded(child: Column(children: [Text('Very long text...')])),
  ],
)
```

### 'Vertical viewport was given unbounded height'

Occurs when ListView (or other scrollable) is inside Column without height constraints.

**Solution:** Wrap in `Expanded` or use `shrinkWrap: true`.

```dart
// Problem
Column(
  children: [
    Text('Header'),
    ListView(children: [...]), // Error!
  ],
)

// Solution
Column(
  children: [
    Text('Header'),
    Expanded(child: ListView(children: [...])),
  ],
)
```

### 'setState called during build'

Never call setState during build method.

**Solution:** Use Navigator API or defer to post-build callback.

For more errors and solutions, see [Common Errors Reference](references/common-errors.md).

## Testing Best Practices

1. **Test Pyramid** - More unit/widget tests, fewer integration tests
2. **Descriptive Test Names** - Names should clearly describe what and why
3. **Arrange-Act-Assert** - Structure tests with clear sections
4. **Avoid Test Interdependence** - Each test should be independent
5. **Mock External Dependencies** - Keep tests fast and reliable
6. **Run Tests in CI** - Automate testing on every push

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/widget_test.dart
```

### Run Integration Tests

```bash
flutter test integration_test/
```

### Run with Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Run Tests on Different Platforms

```bash
# Android
flutter test --platform android

# iOS
flutter test --platform ios

# Web
flutter test --platform chrome
```

## Debugging Tests

### Debug a Test

```bash
flutter test --no-sound-null-safety test/my_test.dart
```

### Verbose Output

```bash
flutter test --verbose
```

### Run Specific Test

```bash
flutter test --name "Counter value should be incremented"
```

## Resources

### Reference Files

- [Unit Testing Guide](references/unit-testing.md) - In-depth unit testing patterns and mocking strategies
- [Widget Testing Guide](references/widget-testing.md) - Widget finding, interactions, and advanced scenarios
- [Integration Testing Guide](references/integration-testing.md) - End-to-end testing and performance profiling
- [Mocking Guide](references/mocking.md) - Mocking dependencies and plugin interactions
- [Common Errors](references/common-errors.md) - Solutions for frequent testing errors
- [Plugin Testing](references/plugin-testing.md) - Testing Flutter plugins with native code

### External Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/cookbook/testing)
- [flutter_test package](https://pub.dev/packages/flutter_test)
- [Mockito package](https://pub.dev/packages/mockito)
- [Integration Test package](https://pub.dev/packages/integration_test)
