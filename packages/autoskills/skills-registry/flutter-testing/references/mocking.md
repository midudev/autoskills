# Mocking Guide

## Overview

Mocking replaces real dependencies with test doubles to isolate code and make tests deterministic. This guide covers mocking strategies for Flutter tests.

## When to Mock

- Testing code that depends on external services (APIs, databases)
- Isolating components for unit tests
- Simulating error conditions and edge cases
- Making tests faster and more reliable
- Testing code that uses plugins

## Using Mockito

### Setup

Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.10.4
  mockito: ^5.6.1
```

### Generate Mocks

Create mock class with annotation:

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiClient, UserRepository])
void main() {}
```

Generate mocks:

```bash
flutter pub run build_runner build
```

### Basic Mocking

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late MyService myService;
  
  setUp(() {
    mockApiService = MockApiService();
    myService = MyService(mockApiService);
  });
  
  test('calls API and returns data', () async {
    // Arrange
    when(mockApiService.fetchData())
      .thenAnswer((_) async => {'data': 'value'});
    
    // Act
    final result = await myService.getData();
    
    // Assert
    expect(result['data'], 'value');
    verify(mockApiService.fetchData()).called(1);
  });
}
```

## Mocking Different Types

### Mocking Classes

```dart
class DataService {
  Future<String> fetchData() async => 'real data';
}

// Test
test('mocks class method', () async {
  final mockService = MockDataService();
  
  when(mockService.fetchData())
    .thenAnswer((_) async => 'mocked data');
  
  final result = await mockService.fetchData();
  expect(result, 'mocked data');
});
```

### Mocking Interfaces

```dart
abstract class Storage {
  void save(String key, String value);
  String? load(String key);
}

class MockStorage extends Mock implements Storage {}

// Test
test('mocks interface methods', () {
  final mockStorage = MockStorage();
  
  mockStorage.save('key', 'value');
  when(mockStorage.load('key')).thenReturn('value');
  
  expect(mockStorage.load('key'), 'value');
  verify(mockStorage.save('key', 'value')).called(1);
});
```

### Mocking Streams

```dart
class StreamService {
  Stream<int> get counterStream => StreamController<int>().stream;
}

// Test
test('mocks stream', () async {
  final mockService = MockStreamService();
  
  final controller = StreamController<int>();
  when(mockService.counterStream).thenAnswer((_) => controller.stream);
  
  expectLater(
    mockService.counterStream,
    emitsInOrder([1, 2, 3]),
  );
  
  controller.add(1);
  controller.add(2);
  controller.add(3);
  await controller.close();
});
```

## Mockito Features

### Returning Values

```dart
when(mockService.getData()).thenReturn('value');

when(mockService.getUser(id)).thenReturn(User(id: id, name: 'Test'));

when(mockService.getList()).thenReturn([1, 2, 3]);
```

### Throwing Errors

```dart
when(mockService.getData())
  .thenThrow(Exception('Network error'));

when(mockService.saveData(data))
  .thenThrow(FormatException('Invalid data'));
```

### Async Responses

```dart
when(mockService.fetchData())
  .thenAnswer((_) async => 'async data');

when(mockService.loadUser(id))
  .thenAnswer((_) async => Future.delayed(
    const Duration(milliseconds: 100),
    () => User(id: id),
  ));
```

### Sequential Returns

```dart
when(mockService.getData())
  .thenReturn('first')
  .thenReturn('second')
  .thenThrow(Exception('error'));

// First call returns 'first'
expect(await mockService.getData(), 'first');

// Second call returns 'second'
expect(await mockService.getData(), 'second');

// Third call throws
await expectLater(mockService.getData(), throwsException);
```

### Conditional Returns

```dart
when(mockService.getUser(argThat(isA<String>() && contains('@')))
  .thenReturn(User(email: 'test@example.com'));

when(mockService.getUser(argThat(predicate((arg) => arg.length > 5)))
  .thenReturn(User(name: 'Long Name'));

// Matches email format
expect(mockService.getUser('test@example.com').email, 'test@example.com');

// Matches length > 5
expect(mockService.getUser('Long Name').name, 'Long Name');
```

### Capturing Arguments

```dart
final captured = captureNamed(mockService, 'save');

mockService.save('key1', 'value1');
mockService.save('key2', 'value2');

verify(mockService.save('key1', 'value1')).called(1);
expect(captured[0].positionalArguments[0], 'key1');
expect(captured[1].positionalArguments[1], 'value2');
```

## Verification

### Verify Calls

```dart
mockService.getData();

verify(mockService.getData()).called(1);
verify(mockService.getData()).called(greaterThan(0));
verifyNever(mockService.otherMethod());
```

### Verify In Order

```dart
mockService.first();
mockService.second();
mockService.third();

verifyInOrder([
  verify(mockService.first()).called(1),
  verify(mockService.second()).called(1),
  verify(mockService.third()).called(1),
]);
```

### Verify Specific Arguments

```dart
mockService.save('key', 'value');

verify(mockService.save('key', 'value')).called(1);
verify(mockService.save(argThat(isA<String>()), any)).called(1);
```

### Verify No More Interactions

```dart
mockService.getData();
mockService.getData();

verifyNoMoreInteractions(mockService);

verifyNoInteractions(otherMockService);
```

## Mocking Platform Channels

### Basic Platform Channel Mock

```dart
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.example.app/channel'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getBatteryLevel':
            return 85;
          case 'openUrl':
            return true;
          default:
            throw MissingPluginException();
        }
      },
    );
  });
  
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.example.app/channel'),
      null,
    );
  });
  
  test('gets battery level', () async {
    final platform = MethodChannel('com.example.app/channel');
    final result = await platform.invokeMethod('getBatteryLevel');
    expect(result, 85);
  });
}
```

### Platform Channel with Arguments

```dart
setUp(() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('com.example.app/storage'),
    (MethodCall methodCall) async {
      if (methodCall.method == 'save') {
        final args = methodCall.arguments as Map;
        storage[args['key']] = args['value'];
        return true;
      } else if (methodCall.method == 'load') {
        final args = methodCall.arguments as Map;
        return storage[args['key']];
      }
      return null;
    },
  );
});

test('saves and loads from platform storage', () async {
  final platform = MethodChannel('com.example.app/storage');
  
  await platform.invokeMethod('save', {'key': 'test', 'value': 'data'});
  final result = await platform.invokeMethod('load', {'key': 'test'});
  
  expect(result, 'data');
});
```

## Mocking Repositories

### Data Repository

```dart
class UserRepository {
  final ApiClient apiClient;
  
  UserRepository(this.apiClient);
  
  Future<User> getUser(String id) async {
    final data = await apiClient.get('/users/$id');
    return User.fromJson(data);
  }
}

// Test
@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late UserRepository userRepository;
  
  setUp(() {
    mockApiClient = MockApiClient();
    userRepository = UserRepository(mockApiClient);
  });
  
  test('fetches and parses user', () async {
    when(mockApiClient.get('/users/123'))
      .thenAnswer((_) async => {
        'id': '123',
        'name': 'John Doe',
        'email': 'john@example.com',
      });
    
    final user = await userRepository.getUser('123');
    
    expect(user.id, '123');
    expect(user.name, 'John Doe');
    verify(mockApiClient.get('/users/123')).called(1);
  });
}
```

## Mocking State Management

### BLoC Mock

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>((event, emit) => emit(CounterIncremented()));
  }
}

// Test
test('emits states on increment', () {
  final bloc = CounterBloc();
  
  expectLater(bloc, emitsInOrder([
    CounterInitial(),
    CounterIncremented(),
  ]));
  
  bloc.add(IncrementEvent());
});
```

### Provider Mock

```dart
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }
}

// Test
test('notifies listeners on login', () {
  final provider = AuthProvider();
  bool notified = false;
  
  provider.addListener(() {
    notified = true;
  });
  
  provider.login();
  
  expect(notified, true);
  expect(provider.isLoggedIn, true);
});
```

## Manual Mocks

### Simple Manual Mock

```dart
class ApiService {
  Future<String> fetchData() async => 'real data';
}

class MockApiService implements ApiService {
  String? _mockedResponse;
  
  void setMockResponse(String response) {
    _mockedResponse = response;
  }
  
  @override
  Future<String> fetchData() async => _mockedResponse ?? 'default mock';
}

// Test
test('uses manual mock', () async {
  final mockService = MockApiService();
  mockService.setMockResponse('test data');
  
  final result = await mockService.fetchData();
  expect(result, 'test data');
});
```

### State-Based Mock

```dart
class StatefulMockService implements ApiService {
  final List<String> responses = [];
  int _callCount = 0;
  
  @override
  Future<String> fetchData() async {
    if (_callCount < responses.length) {
      return responses[_callCount++];
    }
    throw Exception('No more responses');
  }
  
  void addResponse(String response) {
    responses.add(response);
  }
}

// Test
test('returns sequential responses', () async {
  final mock = StatefulMockService();
  mock.addResponse('first');
  mock.addResponse('second');
  
  expect(await mock.fetchData(), 'first');
  expect(await mock.fetchData(), 'second');
  
  expect(() => mock.fetchData(), throwsException);
});
```

## Best Practices

1. **Mock at boundaries** - Mock external dependencies, not internal logic
2. **Avoid over-mocking** - Only mock what's necessary for the test
3. **Verify interactions** - Ensure mocks are called correctly
4. **Use specific matchers** - Avoid `any` when possible
5. **Clear expectations** - Make test intentions clear
6. **Reset mocks** - Use setUp/tearDown to clean up
7. **Test real behavior** - Verify expected outcomes, not implementation
8. **Keep mocks simple** - Complex mocks indicate design issues

## Common Patterns

### Mock Chain

```dart
when(mockService.first())
  .thenReturn(mockSecondService);
when(mockSecondService.getData())
  .thenReturn('result');

final result = mockService.first().getData();
expect(result, 'result');
```

### Mock Repository

```dart
class MockRepository {
  final Map<String, dynamic> _data = {};
  
  T get<T>(String key) => _data[key] as T;
  void set<T>(String key, T value) => _data[key] = value;
}

// Test
test('uses mock repository', () {
  final repo = MockRepository();
  repo.set('name', 'John');
  
  expect(repo.get<String>('name'), 'John');
});
```

### Mock Factory

```dart
class ServiceFactory {
  static ApiService create() => RealApiService();
}

class MockServiceFactory {
  ApiService? mockService;
  
  ApiService create() => mockService ?? RealApiService();
}

// Test
test('uses factory mock', () {
  final factory = MockServiceFactory();
  factory.mockService = MockApiService();
  
  when(factory.mockService!.getData()).thenReturn('mocked');
  
  final service = factory.create();
  expect(service.getData(), 'mocked');
});
```
