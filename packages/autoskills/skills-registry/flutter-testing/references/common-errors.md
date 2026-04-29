# Common Testing Errors

## Overview

This guide covers frequently encountered Flutter testing errors and their solutions.

## Layout Errors

### 'A RenderFlex overflowed...'

**Error Message:**
```
The following assertion was thrown during layout:
A RenderFlex overflowed by 1146 pixels on the right.
```

**Cause:** Yellow and black stripes indicate overflow when a child widget is too large for its parent (Row/Column).

**Solution:** Wrap the overflowing widget in `Expanded` or `Flexible`.

```dart
// Problem
Row(
  children: [
    Icon(Icons.message),
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: Theme.of(context).textTheme.headlineMedium),
        Text('Very long text that overflows the available space...'),
      ],
    ),
  ],
)

// Solution
Row(
  children: [
    Icon(Icons.message),
    Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title', style: Theme.of(context).textTheme.headlineMedium),
          Text('Very long text that fits in the available space...'),
        ],
      ),
    ),
  ],
)
```

### 'Vertical viewport was given unbounded height'

**Error Message:**
```
Vertical viewport was given unbounded height.
Viewports expand in the scrolling direction to fill their container.
This situation typically happens when a scrollable widget is nested inside another scrollable widget.
```

**Cause:** ListView or other scrollable widget inside Column without height constraints.

**Solution:** Wrap in `Expanded` or use `shrinkWrap: true`.

```dart
// Problem
Column(
  children: [
    Text('Header'),
    ListView(
      children: [
        ListTile(leading: Icon(Icons.map), title: Text('Map')),
        ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
      ],
    ),
  ],
)

// Solution 1: Expanded
Column(
  children: [
    Text('Header'),
    Expanded(
      child: ListView(
        children: [
          ListTile(leading: Icon(Icons.map), title: Text('Map')),
          ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
        ],
      ),
    ),
  ],
)

// Solution 2: shrinkWrap
Column(
  children: [
    Text('Header'),
    ListView(
      shrinkWrap: true,
      children: [
        ListTile(leading: Icon(Icons.map), title: Text('Map')),
        ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
      ],
    ),
  ],
)
```

### 'An InputDecorator...cannot have an unbounded width'

**Error Message:**
```
An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
This happens when the parent widget does not provide a finite width constraint.
```

**Cause:** TextField or TextFormField inside Row without width constraints.

**Solution:** Wrap in `Expanded` or `SizedBox`.

```dart
// Problem
Row(
  children: [TextField()],
)

// Solution 1: Expanded
Row(
  children: [Expanded(child: TextFormField())],
)

// Solution 2: SizedBox
Row(
  children: [SizedBox(width: 200, child: TextFormField())],
)
```

## Widget Lifecycle Errors

### 'setState called during build'

**Error Message:**
```
setState() or markNeedsBuild() called during build.
This Overlay widget cannot be marked as needing to build because the framework
is already in the process of building widgets.
```

**Cause:** Calling `setState` (or methods that call it like `showDialog`) directly in the `build` method.

**Solution:** Use `WidgetsBinding.instance.addPostFrameCallback` or Navigator API.

```dart
// Problem
Widget build(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text('Error!')),
  );
  return Center(child: Text('Show Dialog'));
}

// Solution 1: Post-frame callback
Widget build(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Success!')),
    );
  });
  return Center(child: Text('Show Dialog'));
}

// Solution 2: Navigator API (for initial navigation)
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => DialogScreen(),
        ),
      );
    },
    child: Text('Show Dialog'),
  );
}
```

## Parent Widget Errors

### 'Incorrect use of ParentData widget'

**Error Message:**
```
The following assertion was thrown while looking for parent data:
Incorrect use of ParentDataWidget.
Usually, this indicates that at least one of the offending ParentDataWidgets
listed above is not placed directly inside a compatible ancestor widget.
```

**Cause:** Using widgets that require specific parent widgets in wrong context.

**Common Solutions:**

| Widget               | Expected Parent     | Solution                          |
|---------------------|---------------------|-----------------------------------|
| `Flexible`          | `Row`, `Column`, `Flex` | Ensure parent is Row/Column/Flex |
| `Expanded`           | `Row`, `Column`, `Flex` | Ensure parent is Row/Column/Flex |
| `Positioned`         | `Stack`              | Wrap in Stack                     |
| `TableCell`          | `Table`              | Ensure parent is Table              |

```dart
// Problem
Column(
  children: [
    Expanded(child: Text('Wrong!')), // Expanded needs Row/Column parent, not Column children
  ],
)

// Solution
Column(
  children: [
    Row(
      children: [
        Expanded(child: Text('Correct!')),
      ],
    ),
  ],
)
```

## Testing-Specific Errors

### 'WidgetTester.pumpWidget() called with a widget that doesn't include a MaterialApp'

**Error Message:**
```
WidgetTester.pumpWidget() called with a widget that doesn't include a MaterialApp.
```

**Cause:** Pumping widget without MaterialApp context.

**Solution:** Wrap widget in MaterialApp.

```dart
// Problem
testWidgets('test without MaterialApp', (tester) async {
  await tester.pumpWidget(MyWidget());
});

// Solution
testWidgets('test with MaterialApp', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(),
    ),
  );
});
```

### 'No Finder found'

**Error Message:**
```
No Finder found.
Test failed: No elements found matching the finder.
```

**Cause:** Widget not found in tree at time of test.

**Common Solutions:**

```dart
// 1. Wrong text/content
expect(find.text('Wrong Text'), findsNothing); // Error

// Solution: Use correct text
expect(find.text('Correct Text'), findsOneWidget);

// 2. Widget not built yet
testWidgets('widget not built', (tester) async {
  await tester.pumpWidget(MyWidget());
  expect(find.text('Async Text'), findsOneWidget); // Error
});

// Solution: Pump and settle for async operations
testWidgets('widget not built', (tester) async {
  await tester.pumpWidget(MyWidget());
  await tester.pumpAndSettle(); // Wait for async operations
  expect(find.text('Async Text'), findsOneWidget);
});

// 3. Wrong finder type
testWidgets('wrong finder', (tester) async {
  await tester.pumpWidget(TextButton(child: Text('Button')));
  await tester.tap(find.byType(ElevatedButton)); // Error
});

// Solution: Use correct type or use Text finder
testWidgets('correct finder', (tester) async {
  await tester.pumpWidget(TextButton(child: Text('Button')));
  await tester.tap(find.byType(TextButton)); // Correct
});
```

## Plugin/Platform Errors

### 'MissingPluginException'

**Error Message:**
```
MissingPluginException(No implementation found for method MethodName on channel channel.name)
```

**Cause:** Plugin not registered or mock not set up in tests.

**Solution:** Mock the method channel in tests.

```dart
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('your.plugin.channel'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getPlatformVersion') {
          return 'Android 12';
        }
        throw MissingPluginException();
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

## Async Errors

### 'TimeoutException'

**Error Message:**
```
TimeoutException after 0:00:05.000000: Test timed out after 5 seconds.
```

**Cause:** Async operation not completing or `pumpAndSettle()` waiting indefinitely.

**Solution:** Set timeout or fix infinite loops.

```dart
// Solution 1: Increase timeout
testWidgets(
  'long-running test',
  (tester) async {
    await tester.pumpWidget(MyWidget());
    await Future.delayed(const Duration(seconds: 10));
  },
  timeout: const Timeout(Duration(minutes: 1)),
);

// Solution 2: Fix infinite pumpAndSettle
testWidgets('fix infinite settle', (tester) async {
  await tester.pumpWidget(MyWidget());
  await tester.pump(); // Use pump() instead of pumpAndSettle() if animation loops
});
```

## Data Errors

### 'RangeError'

**Error Message:**
```
RangeError: Index out of range: index should be less than 5, but is 5
```

**Cause:** Accessing list/array with invalid index.

**Solution:** Check bounds before access or handle empty cases.

```dart
// Problem
testWidgets('range error', (tester) async {
  final items = [1, 2, 3, 4, 5];
  expect(items[5], 6); // Error: index 5 out of range
});

// Solution 1: Check bounds
testWidgets('safe access', (tester) async {
  final items = [1, 2, 3, 4, 5];
  if (items.length > 5) {
    expect(items[5], 6);
  }
});

// Solution 2: Handle empty lists
testWidgets('handle empty list', (tester) async {
  final items = <int>[];
  if (items.isEmpty) {
    expect(find.text('No items'), findsOneWidget);
  } else {
    expect(items.first, 1);
  }
});
```

## Debugging Tips

### Enable Verbose Logging

```bash
flutter test --verbose
```

### Take Screenshots

```dart
testWidgets('debug with screenshot', (tester) async {
  await tester.pumpWidget(MyWidget());
  await tester.takeScreenshot('debug-state');
});
```

### Print Widget Tree

```dart
testWidgets('print tree', (tester) async {
  await tester.pumpWidget(MyWidget());
  debugDumpApp();
});
```

### Use Debug Flags

```dart
testWidgets('debug flags', (tester) async {
  debugPrint('Current state: ...');
  await tester.pumpWidget(MyWidget());
  debugPrint('Widget tree: ${tester.widgetList(find.byType(MyWidget))}');
});
```

## Prevention

### Use Type Safety

```dart
// Good: Use type-safe access
final text = tester.widget<Text>(find.byType(Text));

// Avoid: Unsafe casts
final text = find.byType(Text).evaluate().first.widget as Text;
```

### Check Before Actions

```dart
testWidgets('safe tap', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  final button = find.byType(ElevatedButton);
  if (button.evaluate().isNotEmpty) {
    await tester.tap(button);
  } else {
    fail('Button not found');
  }
});
```

### Handle All Cases

```dart
testWidgets('comprehensive', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  // Check all possible states
  if (find.text('Loading').evaluate().isNotEmpty) {
    // Handle loading state
  } else if (find.text('Error').evaluate().isNotEmpty) {
    // Handle error state
  } else {
    // Handle success state
  }
});
```
