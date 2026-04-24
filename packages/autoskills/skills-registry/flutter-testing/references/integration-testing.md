# Integration Testing Guide

## Overview

Integration tests test complete apps or large parts of apps on real devices or emulators. They verify that all widgets and services work together as expected and can measure performance.

## When to Write Integration Tests

- Testing complete user flows across multiple screens
- Verifying navigation between pages
- Testing state persistence
- Validating real device behavior (sensors, camera, etc.)
- Performance profiling and benchmarking
- Testing platform-specific features

## Setup

### Add Dependency

Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
```

### Create Test Driver

Create `test_driver/integration_test.dart`:

```dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

## Test Structure

### Basic Integration Test

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('app launches and displays home', (tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('Home Screen'), findsOneWidget);
  });
}
```

### Running Integration Tests

```bash
# Run on all devices
flutter test integration_test/

# Run on specific device
flutter test -d <device-id> integration_test/

# Run specific test file
flutter test integration_test/my_test.dart

# Run with driver
flutter drive --target=integration_test/my_test.dart
```

## Testing User Flows

### Multi-Screen Navigation

```dart
testWidgets('complete user flow from login to dashboard', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Login screen
  expect(find.text('Login'), findsOneWidget);
  
  // Enter credentials
  await tester.enterText(find.byKey(const Key('username')), 'user@example.com');
  await tester.enterText(find.byKey(const Key('password')), 'password123');
  
  // Tap login
  await tester.tap(find.byKey(const Key('login-button')));
  await tester.pumpAndSettle();
  
  // Dashboard screen
  expect(find.text('Dashboard'), findsOneWidget);
  expect(find.text('Welcome, user@example.com'), findsOneWidget);
});
```

### Tab Navigation

```dart
testWidgets('navigate between tabs', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Initial tab
  expect(find.text('Home'), findsOneWidget);
  
  // Tap second tab
  await tester.tap(find.text('Profile'));
  await tester.pumpAndSettle();
  
  expect(find.text('Home'), findsNothing);
  expect(find.text('Profile'), findsOneWidget);
  
  // Navigate back
  await tester.tap(find.text('Home'));
  await tester.pumpAndSettle();
  
  expect(find.text('Home'), findsOneWidget);
});
```

## Testing Forms

### Complete Form Submission

```dart
testWidgets('submit registration form', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Navigate to registration
  await tester.tap(find.text('Sign Up'));
  await tester.pumpAndSettle();
  
  // Fill form
  await tester.enterText(find.byKey(const Key('name')), 'John Doe');
  await tester.enterText(find.byKey(const Key('email')), 'john@example.com');
  await tester.enterText(find.byKey(const Key('password')), 'password123');
  await tester.enterText(find.byKey(const Key('confirm-password')), 'password123');
  
  // Submit
  await tester.tap(find.byKey(const Key('submit')));
  await tester.pumpAndSettle();
  
  // Verify success
  expect(find.text('Registration Successful'), findsOneWidget);
});
```

### Form Validation

```dart
testWidgets('form shows validation errors', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  await tester.tap(find.text('Sign Up'));
  await tester.pumpAndSettle();
  
  // Submit empty form
  await tester.tap(find.byKey(const Key('submit')));
  await tester.pump();
  
  // Verify errors
  expect(find.text('Name is required'), findsOneWidget);
  expect(find.text('Email is required'), findsOneWidget);
  expect(find.text('Password is required'), findsOneWidget);
  
  // Fill with invalid email
  await tester.enterText(find.byKey(const Key('email')), 'invalid-email');
  await tester.tap(find.byKey(const Key('submit')));
  await tester.pump();
  
  expect(find.text('Invalid email format'), findsOneWidget);
});
```

## Testing Lists and Data

### Loading and Displaying Data

```dart
testWidgets('load and display items from API', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Wait for data load
  await tester.pumpAndSettle();
  
  // Verify items loaded
  expect(find.byType(ListTile), findsWidgets);
  expect(find.text('Item 1'), findsOneWidget);
  expect(find.text('Item 2'), findsOneWidget);
});
```

### Pull-to-Refresh

```dart
testWidgets('pull to refresh updates list', (tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  
  // Pull down
  await tester.drag(
    find.byType(RefreshIndicator),
    const Offset(0, 300),
  );
  await tester.pumpAndSettle();
  
  // Verify refreshed data
  expect(find.text('Updated Item 1'), findsOneWidget);
});
```

### Infinite Scrolling

```dart
testWidgets('load more items on scroll', (tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  
  // Initial items
  expect(find.text('Item 20'), findsNothing);
  
  // Scroll to bottom to trigger load more
  await tester.fling(
    find.byType(ListView),
    const Offset(0, -2000),
    10000,
  );
  await tester.pumpAndSettle();
  
  // New items loaded
  expect(find.text('Item 20'), findsOneWidget);
});
```

## Testing State Persistence

### SharedPreferences

```dart
testWidgets('user preference persists across restarts', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Change setting
  await tester.tap(find.text('Dark Mode'));
  await tester.pumpAndSettle();
  
  // Restart app
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  
  // Verify setting persisted
  expect(find.text('Light Mode'), findsNothing);
  expect(find.text('Dark Mode'), findsOneWidget);
});
```

### Authentication State

```dart
testWidgets('user stays logged in', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Login
  await tester.enterText(find.byKey(const Key('email')), 'user@example.com');
  await tester.enterText(find.byKey(const Key('password')), 'password');
  await tester.tap(find.byKey(const Key('login')));
  await tester.pumpAndSettle();
  
  expect(find.text('Dashboard'), findsOneWidget);
  
  // Restart app
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  
  // Still logged in
  expect(find.text('Dashboard'), findsOneWidget);
  expect(find.text('Login'), findsNothing);
});
```

## Performance Testing

### Measuring Frame Time

```dart
testWidgets('measure scrolling performance', (tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  
  final timeline = await tester.trace(() async {
    await tester.fling(
      find.byType(ListView),
      const Offset(0, -1000),
      5000,
    );
    await tester.pumpAndSettle();
  });
  
  // Analyze frame times
  final frameTimings = timeline.frames.map((frame) => frame.duration).toList();
  final averageFrameTime = frameTimings.reduce((a, b) => a + b) / frameTimings.length;
  
  // Should run at 60fps (16.67ms per frame max)
  expect(averageFrameTime.inMilliseconds, lessThan(17));
});
```

### Tracking Build Count

```dart
testWidgets('widget doesn't rebuild unnecessarily', (tester) async {
  int buildCount = 0;
  
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) {
          buildCount++;
          return const MyWidget();
        },
      ),
    ),
  );
  
  expect(buildCount, 1);
  
  // Perform unrelated action
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();
  
  // Should not rebuild
  expect(buildCount, 1);
});
```

### Memory Tracking

```dart
testWidgets('monitor memory usage during scrolling', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  final initialMemory = ProcessInfo.currentRss;
  
  await tester.fling(
    find.byType(ListView),
    const Offset(0, -5000),
    10000,
  );
  await tester.pumpAndSettle();
  
  final finalMemory = ProcessInfo.currentRss;
  final memoryIncrease = finalMemory - initialMemory;
  
  // Memory increase should be reasonable (< 10MB)
  expect(memoryIncrease, lessThan(10 * 1024 * 1024));
});
```

## Testing Platform-Specific Features

### Permissions

```dart
testWidgets('request and handle camera permission', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Request camera access
  await tester.tap(find.text('Take Photo'));
  await tester.pumpAndSettle();
  
  // Handle permission dialog (platform-specific)
  await tester.pumpAndSettle();
  
  // Verify camera screen appears
  expect(find.byType(CameraPreview), findsOneWidget);
});
```

### Deep Links

```dart
testWidgets('handle deep link to product page', (tester) async {
  await tester.pumpWidget(const MyApp(initialRoute: '/product/123'));
  await tester.pumpAndSettle();
  
  expect(find.text('Product #123'), findsOneWidget);
});
```

### In-App Purchases

```dart
testWidgets('complete purchase flow', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  await tester.tap(find.text('Premium'));
  await tester.pumpAndSettle();
  
  await tester.tap(find.text('Subscribe'));
  await tester.pumpAndSettle();
  
  // Verify purchase completed
  expect(find.text('Premium Active'), findsOneWidget);
});
```

## Testing Network

### Offline Behavior

```dart
testWidgets('handle offline state gracefully', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Simulate offline
  await tester.binding.setSurfaceSize(Size.zero);
  
  // Verify offline message
  expect(find.text('No internet connection'), findsOneWidget);
  
  // Simulate back online
  await tester.binding.setSurfaceSize(const Size(400, 800));
  await tester.pumpAndSettle();
  
  // Reload data
  expect(find.text('Data loaded'), findsOneWidget);
});
```

### Error Handling

```dart
testWidgets('handle network errors', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Trigger API call
  await tester.tap(find.text('Load Data'));
  await tester.pumpAndSettle();
  
  // Verify error message displayed
  expect(find.text('Failed to load data'), findsOneWidget);
  expect(find.byKey(const Key('retry-button')), findsOneWidget);
});
```

## Testing Animations

### Smooth Animations

```dart
testWidgets('animation runs smoothly', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  final timeline = await tester.trace(() async {
    await tester.tap(find.byKey(const Key('animate')));
    await tester.pumpAndSettle();
  });
  
  // Check for janky frames
  final jankyFrames = timeline.frames.where((frame) => 
    frame.duration.inMicroseconds > 16667 // 60fps threshold
  );
  
  expect(jankyFrames.length, lessThan(timeline.frames.length ~/ 10));
});
```

## Best Practices

1. **Test critical user paths** - Focus on important flows
2. **Keep tests independent** - Each test should be standalone
3. **Use descriptive names** - Explain what the test does
4. **Wait for async operations** - Use `pumpAndSettle()`
5. **Test real behavior** - Verify actual device behavior, not mocks
6. **Measure performance** - Track frame times, memory, and build counts
7. **Test edge cases** - Offline, errors, empty states
8. **Keep tests fast** - Avoid unnecessary delays

## Debugging Integration Tests

### Take Screenshots

```dart
testWidgets('debug test with screenshot', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Take screenshot
  await tester.takeScreenshot('test-screenshot');
  
  // Perform actions
  await tester.tap(find.text('Button'));
  await tester.pumpAndSettle();
  
  // Take another screenshot
  await tester.takeScreenshot('after-tap');
});
```

### Print Widget Tree

```dart
testWidgets('print widget tree for debugging', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Print widget tree
  debugDumpApp();
});
```

## CI/CD Integration

### GitHub Actions

```yaml
name: Integration Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run integration tests
        run: flutter test integration_test/
```

### Test Reports

```bash
# Generate test report
flutter test integration_test/ --reporter expanded

# Generate JSON report
flutter test integration_test/ --reporter json > test-results.json
```
