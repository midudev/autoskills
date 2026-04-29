# Explicit Animations Reference

Explicit animations provide full control using AnimationController, Tween, and animation status listeners.

## Core Components

### AnimationController

The heart of explicit animations. Manages animation lifecycle, value, and timing.

```dart
late AnimationController _controller;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,  // Required TickerProvider
    lowerBound: 0.0,  // Optional: default 0.0
    upperBound: 1.0,  // Optional: default 1.0
  );
}

@override
void dispose() {
  _controller.dispose();  // ALWAYS dispose!
  super.dispose();
}
```

**Lifecycle methods:**

```dart
// Start animation forward
_controller.forward();

// Start animation backward
_controller.reverse();

// Stop animation
_controller.stop();

// Repeat animation
_controller.repeat();

// Animate to specific value
await _controller.animateTo(0.5);

// Reset to beginning
_controller.reset();

// Animate with physics simulation
_controller.fling(velocity: 2.0);

// Animate with custom simulation
_controller.animateWith(SpringSimulation(...));
```

**Listening to changes:**

```dart
_controller.addListener(() {
  // Value changed - rebuild needed
  setState(() {});
});

_controller.addStatusListener((status) {
  // Status changed
  switch (status) {
    case AnimationStatus.dismissed:
      print('Animation dismissed (at 0)');
      break;
    case AnimationStatus.forward:
      print('Animation moving forward');
      break;
    case AnimationStatus.reverse:
      print('Animation moving backward');
      break;
    case AnimationStatus.completed:
      print('Animation completed (at 1)');
      break;
  }
});
```

### Tween

Interpolates between begin and end values.

```dart
// Simple tween
animation = Tween<double>(begin: 0, end: 300).animate(_controller);

// Color tween
animation = ColorTween(
  begin: Colors.red,
  end: Colors.blue,
).animate(_controller);

// Border radius tween
animation = BorderRadiusTween(
  begin: BorderRadius.circular(4),
  end: BorderRadius.circular(75),
).animate(_controller);

// Rect tween
animation = RectTween(
  begin: Rect.fromLTWH(0, 0, 100, 100),
  end: Rect.fromLTWH(100, 100, 200, 200),
).animate(_controller);
```

**Common Tweens:**
- `Tween<T>` - Generic tween (use for most types)
- `ColorTween` - Color interpolation
- `RectTween` - Rectangle interpolation
- `IntTween` - Integer interpolation
- `SizeTween` - Size interpolation
- `OffsetTween` - Offset interpolation
- `BorderRadiusTween` - Border radius interpolation

### CurvedAnimation

Applies a curve to transform animation values.

```dart
animation = CurvedAnimation(
  parent: _controller,
  curve: Curves.easeInOut,
  reverseCurve: Curves.easeIn,  // Optional: different curve for reverse
);
```

**With Interval:**

```dart
animation = CurvedAnimation(
  parent: _controller,
  curve: const Interval(
    0.25,  // Start at 25% of controller
    0.75,  // End at 75% of controller
    curve: Curves.easeInOut,
  ),
);
```

### ReverseAnimation

Reverses the parent animation.

```dart
final forwardAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
final reverseAnimation = ReverseAnimation(forwardAnimation);
```

## Patterns

### AnimatedWidget Pattern

Best for reusable animated widgets. Automatically handles rebuilds.

```dart
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

// Usage
@override
Widget build(BuildContext context) {
  return AnimatedLogo(animation: _animation);
}
```

### AnimatedBuilder Pattern

Best for complex widgets. Separates animation logic from widget logic.

```dart
class GrowTransition extends StatelessWidget {
  const GrowTransition({
    required this.child,
    required this.animation,
    super.key,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

// Usage
@override
Widget build(BuildContext context) {
  return GrowTransition(
    animation: _animation,
    child: const LogoWidget(),
  );
}
```

**Why pass child twice?**
The `child` parameter to `AnimatedBuilder` is passed to the `builder` function, allowing the child to be built once and reused, rather than rebuilt every animation frame.

### Multiple Animations Pattern

Animate multiple properties from single controller.

```dart
class MultiPropertyAnimation extends AnimatedWidget {
  const MultiPropertyAnimation({super.key, required Animation<double> animation})
    : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);
  static final _colorTween = ColorTween(
    begin: Colors.red,
    end: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          decoration: BoxDecoration(
            color: _colorTween.evaluate(animation),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
```

## Built-in Transitions

Flutter provides pre-built transitions for common use cases.

### FadeTransition

```dart
FadeTransition(
  opacity: _animation,
  child: const FlutterLogo(),
)
```

### ScaleTransition

```dart
ScaleTransition(
  scale: _animation,
  child: const FlutterLogo(),
)
```

### SlideTransition

```dart
SlideTransition(
  position: Tween<Offset>(
    begin: Offset(0, 1),
    end: Offset.zero,
  ).animate(_animation),
  child: const FlutterLogo(),
)
```

### SizeTransition

```dart
SizeTransition(
  sizeFactor: _animation,
  axis: Axis.vertical,
  child: const FlutterLogo(),
)
```

### RotationTransition

```dart
RotationTransition(
  turns: _animation,
  child: const FlutterLogo(),
)
```

### DecoratedBoxTransition

```dart
DecoratedBoxTransition(
  decoration: DecorationTween(
    begin: BoxDecoration(color: Colors.red),
    end: BoxDecoration(color: Colors.blue),
  ).animate(_animation),
  child: const FlutterLogo(),
)
```

### PositionedTransition

```dart
Stack(
  children: [
    PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fill(calculateRect(context, startPosition)),
        end: RelativeRect.fill(calculateRect(context, endPosition)),
      ).animate(_animation),
      child: const FlutterLogo(),
    ),
  ],
)
```

## Animation Status Handling

### Basic Status Loop

```dart
_animation.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    _controller.reverse();
  } else if (status == AnimationStatus.dismissed) {
    _controller.forward();
  }
});
```

### One-way Animation

```dart
_animation.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    _controller.stop();  // Or navigate, show dialog, etc.
  }
});
```

### Reset and Repeat

```dart
_animation.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    _controller.reset();
    _controller.forward();
  }
});
```

## Performance Best Practices

### DO

- Always dispose AnimationController
- Use `AnimatedWidget` or `AnimatedBuilder` instead of `setState()` in listeners
- Minimize widget rebuilds during animation
- Use static Tweens when possible (avoid recreating)
- Profile with Flutter DevTools
- Use `timeDilation` for debugging

### DON'T

- Forget to dispose controllers (memory leak)
- Call `setState()` in animation listeners unnecessarily
- Create complex widget trees inside animation builds
- Animate too many widgets simultaneously
- Use animation values directly in expensive operations

### Performance Pattern: RepaintBoundary

```dart
RepaintBoundary(
  child: AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
      return ExpensiveWidget();
    },
  ),
)
```

## Debugging

### Slow Animations

```dart
void main() {
  timeDilation = 10.0;  // 10x slower
  runApp(MyApp());
}
```

### Print Animation Values

```dart
_controller.addListener(() {
  print('Animation value: ${_controller.value}');
});

_animation.addStatusListener((status) {
  print('Animation status: $status');
});
```

### Flutter DevTools Performance Overlay

1. Run app in debug mode
2. Press 'p' to toggle performance overlay
3. Look for "GPU UI" and "GPU Raster" graphs
4. Aim for 60fps (16.67ms per frame)

## Common Patterns

### Fade In Then Slide Up

```dart
_animation = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
  ),
);

_slideAnimation = Tween<Offset>(
  begin: Offset(0, 0.5),
  end: Offset.zero,
).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
  ),
);
```

### Bounce Effect

```dart
_animation = CurvedAnimation(
  parent: _controller,
  curve: Curves.elasticOut,
);
```

### Shake Effect

```dart
class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return sin(t * pi * 2);
  }
}

_animation = CurvedAnimation(
  parent: _controller,
  curve: ShakeCurve(),
);
```

### Parallax Scrolling

```dart
class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    required this.animation,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value * 50),
          child: child,
        );
      },
      child: child,
    );
  }
}
```

## Comparison: Implicit vs Explicit

| Feature | Implicit | Explicit |
|---------|----------|-----------|
| Controller | None needed | AnimationController required |
| Setup | Simple | More complex |
| Control | Limited (duration, curve) | Full (lifecycle, status, physics) |
| Multiple Properties | AnimatedContainer only | Unlimited |
| Performance | Good | Excellent (with patterns) |
| Reusability | Widget-based | Component-based |
| State Monitoring | Limited (onEnd) | Full (status listeners) |

## When to Use Explicit Animations

Use explicit animations when:
- Need full control over animation lifecycle
- Animating multiple properties
- Need to react to animation state changes
- Creating reusable animation components
- Need complex timing or sequencing
- Performance is critical
- Want physics-based or custom animations

Use implicit animations when:
- Simple, one-off animations
- Animation triggered by state change
- No need for fine-grained control
- Want simple, declarative code
