# testify/mock — Reference

Mock interfaces to isolate the unit under test. Embed `mock.Mock`, implement methods with `m.Called()`, and always verify with `AssertExpectations(t)`.

## Quick example

```go
type MockSender struct { mock.Mock }

func (m *MockSender) Send(ctx context.Context, to string, msg Message) error {
    return m.Called(ctx, to, msg).Error(0)
}

func TestOrderService_Place(t *testing.T) {
    is := assert.New(t)
    m := new(MockSender)
    m.On("Send", mock.Anything, "buyer@example.com", mock.AnythingOfType("Message")).Return(nil)

    err := NewOrderService(m).Place(context.Background(), order)

    is.NoError(err)
    m.AssertExpectations(t)
}
```

## Defining a mock

```go
type NotificationSender interface {
    Send(ctx context.Context, to string, msg Message) error
    BatchSend(ctx context.Context, recipients []string, msg Message) (int, error)
}

type MockNotificationSender struct { mock.Mock }

func (m *MockNotificationSender) Send(ctx context.Context, to string, msg Message) error {
    return m.Called(ctx, to, msg).Error(0)
}

func (m *MockNotificationSender) BatchSend(ctx context.Context, recipients []string, msg Message) (int, error) {
    args := m.Called(ctx, recipients, msg)
    return args.Int(0), args.Error(1)
}
```

## Argument matchers

```go
// mock.Anything — matches any value
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil)

// mock.AnythingOfType — matches by type name
m.On("Send", mock.Anything, mock.AnythingOfType("string"), mock.Anything).Return(nil)

// mock.MatchedBy — custom predicate
m.On("Send", mock.Anything, mock.MatchedBy(func(to string) bool {
    return strings.HasSuffix(to, "@example.com")
}), mock.Anything).Return(nil)
```

## Call modifiers

```go
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil).Once()     // exactly 1 call
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil).Times(3)   // exactly 3 calls
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil).Maybe()    // optional

// Side effects
m.On("Send", mock.Anything, mock.Anything, mock.Anything).
    Run(func(args mock.Arguments) {
        msg := args.Get(2).(Message)
        t.Logf("mock received: %s", msg.Subject)
    }).Return(nil)
```

## Different returns per call

```go
// First call returns error, second succeeds (retry testing)
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(errors.New("timeout")).Once()
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil).Once()
```

## Removing expectations

```go
call := m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(nil)
call.Unset()
m.On("Send", mock.Anything, mock.Anything, mock.Anything).Return(errors.New("fail"))
```

## Verification

```go
m.AssertExpectations(t)                                                          // verify all expectations
m.AssertCalled(t, "Send", mock.Anything, "buyer@example.com", mock.Anything)     // specific call made
m.AssertNotCalled(t, "BatchSend", mock.Anything, mock.Anything, mock.Anything)   // specific call NOT made
m.AssertNumberOfCalls(t, "Send", 2)                                              // exact call count
```
