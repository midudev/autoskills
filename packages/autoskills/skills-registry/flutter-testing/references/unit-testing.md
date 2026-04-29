# Unit Testing Guide

## Overview

Unit tests test individual functions, methods, or classes in isolation. They are the foundation of a well-tested Flutter app, providing fast feedback and high maintainability.

## When to Write Unit Tests

- Testing business logic functions
- Validating data transformations
- Testing state management logic (Bloc, Provider, Riverpod)
- Mocking external services/API calls
- Testing utility functions and helpers

## Test Structure

### Basic Test

```dart
import 'package:test/test.dart';

void main() {
  test('description', () {
    // Arrange
    final subject = MyClass();
    
    // Act
    final result = subject.myMethod();
    
    // Assert
    expect(result, expectedValue);
  });
}
```

### Group Tests

```dart
import 'package:test/test.dart';

void main() {
  group('Counter', () {
    late Counter counter;
    
    setUp(() {
      counter = Counter();
    });
    
    test('value starts at 0', () {
      expect(counter.value, 0);
    });
    
    test('increment increases value', () {
      counter.increment();
      expect(counter.value, 1);
    });
    
    tearDown(() {
      counter.dispose();
    });
  });
}
```

## Testing Patterns

### Testing Pure Functions

```dart
// Function to test
int add(int a, int b) => a + b;

// Test
test('add returns sum of two numbers', () {
  expect(add(2, 3), 5);
  expect(add(-1, 1), 0);
});
```

### Testing State Changes

```dart
class Counter {
  int _value = 0;
  int get value => _value;
  
  void increment() => _value++;
  void decrement() => _value--;
  void reset() => _value = 0;
}

// Tests
group('Counter state changes', () {
  late Counter counter;
  
  setUp(() => counter = Counter());
  
  test('initial value is 0', () {
    expect(counter.value, 0);
  });
  
  test('increment increases value by 1', () {
    counter.increment();
    expect(counter.value, 1);
  });
  
  test('decrement decreases value by 1', () {
    counter.decrement();
    expect(counter.value, -1);
  });
  
  test('multiple increments work correctly', () {
    counter.increment();
    counter.increment();
    counter.increment();
    expect(counter.value, 3);
  });
});
```

### Testing Async Operations

```dart
class DataService {
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'data';
  }
}

// Test
test('fetchData returns data after delay', () async {
  final service = DataService();
  final result = await service.fetchData();
  expect(result, 'data');
});
```

### Testing Streams

```dart
class CounterStream {
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;
  
  void increment() => _controller.sink.add(1);
  void dispose() => _controller.close();
}

// Test
test('stream emits values', () async {
  final counter = CounterStream();
  
  expectLater(
    counter.stream,
    emitsInOrder([1, 1, 1]),
  );
  
  counter.increment();
  counter.increment();
  counter.increment();
  
  await Future.delayed(const Duration(milliseconds: 100));
  counter.dispose();
});
```

## Matchers

### Common Matchers

```dart
// Equality
expect(actual, equals(expected));

// Not equal
expect(actual, isNot(equals(expected)));

// Null checks
expect(value, isNull);
expect(value, isNotNull);

// Numeric comparisons
expect(5, greaterThan(3));
expect(5, lessThan(10));
expect(5, greaterThanOrEqualTo(5));
expect(5, lessThanOrEqualTo(5));

// Type checking
expect(obj, isA<String>());
expect(obj, isNot(isA<int>()));

// String matching
expect(text, contains('substring'));
expect(text, startsWith('prefix'));
expect(text, endsWith('suffix'));
expect(text, matches(RegExp(r'\d+')));

// Lists
expect(list, isEmpty);
expect(list, isNotEmpty);
expect(list, hasLength(3));
expect(list, contains(item));
expect(list, orderedEquals([1, 2, 3]));
```

### Custom Matchers

```dart
import 'package:test/test.dart';

class HasLength extends Matcher {
  final int expectedLength;
  HasLength(this.expectedLength);
  
  @override
  bool matches(item, Map matchState) {
    return (item as List).length == expectedLength;
  }
  
  @override
  Description describe(Description description) {
    return description.add('has length $expectedLength');
  }
}

// Usage
test('list has custom length', () {
  final list = [1, 2, 3];
  expect(list, HasLength(3));
});
```

## Exception Testing

```dart
class Calculator {
  int divide(int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a ~/ b;
  }
}

// Test
test('divide throws when dividing by zero', () {
  final calculator = Calculator();
  expect(
    () => calculator.divide(10, 0),
    throwsArgumentError,
  );
});

test('divide throws with specific message', () {
  final calculator = Calculator();
  expect(
    () => calculator.divide(10, 0),
    throwsA(isA<ArgumentError>()
      .having((e) => e.message, 'message', contains('zero'))),
  );
});
```

## Mocking

### Using Mockito

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks with: flutter pub run build_runner build

class MockApiClient extends Mock implements ApiClient {}

@GenerateMocks([ApiClient])
void main() {
  group('UserService', () {
    late MockApiClient mockApiClient;
    late UserService userService;
    
    setUp(() {
      mockApiClient = MockApiClient();
      userService = UserService(mockApiClient);
    });
    
    test('fetches user data', () async {
      when(mockApiClient.getUser('123'))
        .thenAnswer((_) async => User(id: '123', name: 'John'));
      
      final user = await userService.getUser('123');
      
      expect(user.name, 'John');
      verify(mockApiClient.getUser('123')).called(1);
    });
  });
}
```

### Manual Mocking

```dart
class MockStorage implements Storage {
  String? savedData;
  
  @override
  void save(String data) {
    savedData = data;
  }
  
  @override
  String? load() => savedData;
}

// Test
test('saves and loads data', () {
  final mockStorage = MockStorage();
  final service = DataService(mockStorage);
  
  service.saveData('test');
  expect(mockStorage.savedData, 'test');
  
  final loaded = service.loadData();
  expect(loaded, 'test');
});
```

## Testing with Fake Clock

```dart
import 'package:clock/clock.dart';

test('time-based operations', () {
  withClock(Clock(() => DateTime(2024, 1, 1)), () {
    final timestamp = DateTime.now();
    expect(timestamp.year, 2024);
  });
});
```

## Test Organization

### File Structure

```
lib/
  counter.dart
test/
  counter/
    counter_test.dart
    counter_value_test.dart
    counter_operations_test.dart
```

### Naming Conventions

- Test files: `*_test.dart`
- Test groups: Group related functionality
- Test names: Describe what and why

```dart
// Good
test('value increments when increment is called', () {});

// Avoid
test('increment', () {});
```

## Best Practices

1. **Arrange-Act-Assert** - Structure tests with clear sections
2. **One assertion per test** - When possible, keep tests focused
3. **Descriptive names** - Explain what and why, not just what
4. **Avoid test interdependence** - Each test should be independent
5. **Use setUp/tearDown** - Avoid code duplication
6. **Test edge cases** - Test boundaries, nulls, and errors
7. **Keep tests fast** - Avoid slow operations in unit tests
8. **Mock external dependencies** - Tests should be deterministic

## Common Pitfalls

### Testing Implementation Details

```dart
// Bad - tests implementation
test('counter calls _update', () {
  verify(counter._update()).called(1);
});

// Good - tests behavior
test('counter value increases after increment', () {
  expect(counter.value, 1);
});
```

### Fragile Tests

```dart
// Bad - depends on exact timing
test('completes within 100ms', () async {
  final stopwatch = Stopwatch()..start();
  await operation();
  expect(stopwatch.elapsedMilliseconds, lessThan(100));
});

// Good - tests completion
test('completes successfully', () async {
  await operation();
  // operation completed without error
});
```

## Running Tests

```bash
# Run all tests
flutter test

# Run specific file
flutter test test/counter/counter_test.dart

# Run with coverage
flutter test --coverage

# Run verbose
flutter test --verbose

# Run specific test
flutter test --name "value increments"
```
