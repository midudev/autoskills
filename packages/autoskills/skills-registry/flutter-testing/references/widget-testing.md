# Widget Testing Guide

## Overview

Widget tests (component tests) verify that widgets render correctly and interact as expected. They run in a test environment that simulates widget lifecycle without a full UI system.

## When to Write Widget Tests

- Verifying widget rendering
- Testing user interactions (taps, drags, scrolling)
- Validating widget state changes
- Testing different orientations and screen sizes
- Testing form inputs and validation

## Test Structure

### Basic Widget Test

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget description', (tester) async {
    // Build widget
    await tester.pumpWidget(const MyWidget());
    
    // Find and verify
    expect(find.text('Hello'), findsOneWidget);
  });
}
```

### Using MaterialApp

```dart
testWidgets('widget with MaterialApp', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    ),
  );
  
  expect(find.byType(MyWidget), findsOneWidget);
});
```

## Finding Widgets

### Common Finders

```dart
// By text
find.text('Hello')
find.textContaining('ello')
find.textRegExp(RegExp(r'\d+'))

// By widget type
find.byType(Text)
find.byType(ElevatedButton)
find.byType(MyWidget)

// By key
find.byKey(const Key('my-button'))
find.byKey(const ValueKey('counter'))

// By icon
find.byIcon(Icons.add)

// By widget instance
find.byWidget(myWidgetInstance)

// By specific widget ancestor
find.ancestor(
  of: find.text('Child'),
  matching: find.byType(Column),
)
```

### Finder Matchers

```dart
// Find exactly one
expect(find.text('Hello'), findsOneWidget);

// Find multiple
expect(find.text('Hello'), findsWidgets);

// Find nothing
expect(find.text('Missing'), findsNothing);

// Find at least N
expect(find.text('Item'), findsNWidgets(3));
```

## User Interactions

### Tapping

```dart
// Tap a widget
await tester.tap(find.byType(ElevatedButton));

// Trigger a frame
await tester.pump();

// Wait for all animations
await tester.pumpAndSettle();
```

### Dragging

```dart
// Drag a widget
await tester.drag(
  find.byType(MyWidget),
  const Offset(0, -300),
);
await tester.pumpAndSettle();
```

### Entering Text

```dart
// Enter text into TextField
await tester.enterText(
  find.byType(TextField),
  'Hello World',
);

// Tap to focus, then enter
await tester.tap(find.byType(TextField));
await tester.enterText(find.byType(TextField), 'Text');

// Enter by key
await tester.enterText(
  find.byKey(const Key('email-field')),
  'test@example.com',
);
```

### Scrolling

```dart
// Scroll a ListView
await tester.fling(
  find.byType(ListView),
  const Offset(0, -500),
  10000,
);
await tester.pumpAndSettle();

// Scroll until widget is visible
await tester.scrollUntilVisible(
  find.text('Target Item'),
  500.0,
);
```

### Long Press

```dart
await tester.longPress(find.byType(IconButton));
await tester.pumpAndSettle();
```

## Testing Widget Properties

### Text Content

```dart
testWidgets('displays correct text', (tester) async {
  await tester.pumpWidget(const MyWidget(text: 'Hello'));
  
  expect(find.text('Hello'), findsOneWidget);
  expect(find.text('Goodbye'), findsNothing);
});
```

### Widget State

```dart
testWidgets('updates state on button press', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Initial state
  expect(find.text('Count: 0'), findsOneWidget);
  
  // Tap increment button
  await tester.tap(find.byKey(const Key('increment')));
  await tester.pumpAndSettle();
  
  // Updated state
  expect(find.text('Count: 1'), findsOneWidget);
});
```

### Conditional Rendering

```dart
testWidgets('shows loading indicator when loading', (tester) async {
  await tester.pumpWidget(MyWidget(isLoading: true));
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  expect(find.byType(ElevatedButton), findsNothing);
});

testWidgets('shows button when not loading', (tester) async {
  await tester.pumpWidget(MyWidget(isLoading: false));
  
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(find.byType(ElevatedButton), findsOneWidget);
});
```

## Testing with Arguments

```dart
testWidgets('receives and displays title', (tester) async {
  const title = 'My Title';
  
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(title: title),
    ),
  );
  
  expect(find.text(title), findsOneWidget);
});

testWidgets('receives and uses callback', (tester) async {
  bool callbackCalled = false;
  
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(
        onPressed: () => callbackCalled = true,
      ),
    ),
  );
  
  await tester.tap(find.byType(ElevatedButton));
  expect(callbackCalled, true);
});
```

## Testing Orientation

```dart
testWidgets('widget in portrait mode', (tester) async {
  await tester.binding.setSurfaceSize(const Size(400, 800));
  await tester.pumpWidget(const MyApp());
  
  // Verify portrait layout
  expect(find.byType(Column), findsOneWidget);
  
  // Clean up
  addTearDown(tester.binding.setSurfaceSize(null));
});

testWidgets('widget in landscape mode', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 400));
  await tester.pumpWidget(const MyApp());
  
  // Verify landscape layout
  expect(find.byType(Row), findsOneWidget);
  
  // Clean up
  addTearDown(tester.binding.setSurfaceSize(null));
});
```

## Testing Scrollable Widgets

### ListView Scrolling

```dart
testWidgets('scrolling in ListView', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    ),
  );
  
  // Initial item visible
  expect(find.text('Item 0'), findsOneWidget);
  expect(find.text('Item 50'), findsNothing);
  
  // Scroll down
  await tester.fling(
    find.byType(ListView),
    const Offset(0, -5000),
    10000,
  );
  await tester.pumpAndSettle();
  
  // Later item now visible
  expect(find.text('Item 50'), findsOneWidget);
});
```

### Scroll Until Visible

```dart
testWidgets('scroll until specific item is visible', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey('item-$index'),
          title: Text('Item $index'),
        ),
      ),
    ),
  );
  
  // Scroll until item 75 is visible
  await tester.scrollUntilVisible(
    find.byKey(const ValueKey('item-75')),
    500.0,
  );
  
  expect(find.text('Item 75'), findsOneWidget);
});
```

## Testing Forms

### TextField Validation

```dart
testWidgets('validates email field', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Form(
          child: TextFormField(
            key: const Key('email'),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Invalid email';
              }
              return null;
            },
          ),
        ),
      ),
    ),
  );
  
  // Enter invalid email
  await tester.enterText(find.byKey(const Key('email')), 'invalid');
  await tester.pump();
  
  // Should show error
  expect(find.text('Invalid email'), findsOneWidget);
  
  // Enter valid email
  await tester.enterText(find.byKey(const Key('email')), 'test@example.com');
  await tester.pump();
  
  // Should hide error
  expect(find.text('Invalid email'), findsNothing);
});
```

### Multiple Form Fields

```dart
testWidgets('form with multiple fields', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Form(
          child: Column(
            children: [
              TextFormField(
                key: const Key('name'),
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                key: const Key('email'),
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                key: const Key('submit'),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  
  // Fill form
  await tester.enterText(find.byKey(const Key('name')), 'John Doe');
  await tester.enterText(find.byKey(const Key('email')), 'john@example.com');
  
  // Submit
  await tester.tap(find.byKey(const Key('submit')));
  await tester.pumpAndSettle();
});
```

## Testing Animations

```dart
testWidgets('animation plays correctly', (tester) async {
  await tester.pumpWidget(const AnimatedWidget());
  
  // Initial state
  expect(find.byType(Opacity), findsOneWidget);
  
  // Trigger animation
  await tester.tap(find.byType(ElevatedButton));
  
  // Pump animation frames
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
  
  // Animation complete
  await tester.pumpAndSettle();
  
  // Verify final state
  final opacity = tester.widget<Opacity>(find.byType(Opacity));
  expect(opacity.opacity, 0.0);
});
```

## Testing Custom Widgets

### Testing InheritedWidgets

```dart
class MyInheritedWidget extends InheritedWidget {
  final String data;
  
  const MyInheritedWidget({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);
  
  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }
  
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      data != oldWidget.data;
}

testWidgets('inherited widget provides data', (tester) async {
  await tester.pumpWidget(
    MyInheritedWidget(
      data: 'Test Data',
      child: Builder(
        builder: (context) {
          return Text(MyInheritedWidget.of(context).data);
        },
      ),
    ),
  );
  
  expect(find.text('Test Data'), findsOneWidget);
});
```

### Testing StatefulWidget

```dart
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;
  
  void _increment() => setState(() => _count++);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          key: const Key('increment'),
          onPressed: _increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

testWidgets('CounterWidget increments correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CounterWidget(),
      ),
    ),
  );
  
  // Initial count
  expect(find.text('Count: 0'), findsOneWidget);
  
  // Increment
  await tester.tap(find.byKey(const Key('increment')));
  await tester.pump();
  
  expect(find.text('Count: 1'), findsOneWidget);
});
```

## Testing with Mock Data

```dart
class ProductList extends StatelessWidget {
  final List<Product> products;
  
  const ProductList({super.key, required this.products});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(products[index].name),
        subtitle: Text('\$${products[index].price}'),
      ),
    );
  }
}

testWidgets('displays list of products', (tester) async {
  final products = [
    Product(name: 'Product 1', price: 10.99),
    Product(name: 'Product 2', price: 20.99),
  ];
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: ProductList(products: products),
      ),
    ),
  );
  
  expect(find.text('Product 1'), findsOneWidget);
  expect(find.text('\$10.99'), findsOneWidget);
  expect(find.text('Product 2'), findsOneWidget);
  expect(find.text('\$20.99'), findsOneWidget);
});
```

## Testing Accessibility

```dart
testWidgets('widget has proper semantics', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Semantics(
        label: 'Submit button',
        button: true,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        ),
      ),
    ),
  );
  
  final semantics = tester.getSemantics(find.byType(ElevatedButton));
  expect(semantics.label, 'Submit button');
  expect(semantics.hasAction(SemanticsAction.tap), true);
});
```

## Best Practices

1. **Use descriptive test names** - Explain what and why
2. **Keep tests independent** - Each test should be standalone
3. **Use pumpAndSettle()** - Wait for all animations
4. **Test user behavior, not implementation** - Focus on what users see and do
5. **Group related tests** - Use `group()` for organization
6. **Test edge cases** - Empty lists, null values, errors
7. **Use keys for widgets** - Makes finding easier and more reliable
8. **Test accessibility** - Verify semantic labels and actions

## Common Patterns

### Testing Navigation

```dart
testWidgets('navigates to detail screen', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
      },
    ),
  );
  
  // Tap navigation button
  await tester.tap(find.text('Go to Detail'));
  await tester.pumpAndSettle();
  
  // Verify navigation
  expect(find.text('Detail Screen'), findsOneWidget);
  expect(find.text('Home Screen'), findsNothing);
});
```

### Testing Loading States

```dart
testWidgets('shows loading then content', (tester) async {
  bool isLoading = true;
  
  await tester.pumpWidget(
    MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          return isLoading
              ? const CircularProgressIndicator()
              : const Text('Content Loaded');
        },
      ),
    ),
  );
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  
  // Simulate data load
  isLoading = false;
  await tester.pump();
  
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(find.text('Content Loaded'), findsOneWidget);
});
```
