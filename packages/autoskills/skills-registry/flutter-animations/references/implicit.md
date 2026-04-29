# Implicit Animations Reference

Implicit animations automatically handle animations when widget properties change. No AnimationController or explicit state management needed.

## Core Concept

Implicitly animated widgets extend `ImplicitlyAnimatedWidget`. When you change a property (color, size, etc.), the widget automatically animates to the new value using a specified duration and curve.

## Available Widgets

### AnimatedContainer

Animates multiple properties simultaneously.

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _expanded ? 200 : 100,
  height: _expanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _expanded ? Colors.blue : Colors.red,
    borderRadius: BorderRadius.circular(_expanded ? 20 : 8),
  ),
  child: const FlutterLogo(),
)
```

**Animatable properties:**
- `width`, `height` - Size
- `color` - Background color
- `decoration` - BoxDecoration (includes border, shadow, image, etc.)
- `padding` - Padding
- `margin` - Margin (via decoration)
- `transform` - Matrix4 transformation

### AnimatedOpacity

Fades a widget in and out.

```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  onEnd: () => print('Animation complete'),
  child: const Text('Hello'),
)
```

### AnimatedPadding

Animates padding changes.

```dart
AnimatedPadding(
  padding: EdgeInsets.all(_padded ? 16.0 : 8.0),
  duration: const Duration(milliseconds: 300),
  curve: Curves.ease,
  child: const Card(child: Text('Padded content')),
)
```

### AnimatedPositioned

Animates position within a Stack.

```dart
Stack(
  children: [
    AnimatedPositioned(
      top: _top ? 0 : 100,
      left: _left ? 0 : 100,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: const FlutterLogo(),
    ),
  ],
)
```

### AnimatedAlign

Animates alignment changes.

```dart
AnimatedAlign(
  alignment: _aligned ? Alignment.topLeft : Alignment.bottomRight,
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeInOut,
  child: const Text('Align me'),
)
```

### AnimatedContainer (Multiple Properties)

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  transform: Matrix4.rotationZ(_rotated ? 0.5 : 0),
  child: const FlutterLogo(),
)
```

### TweenAnimationBuilder

Custom tween animation without creating a custom widget.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(begin: 0, end: 1),
  duration: const Duration(seconds: 1),
  curve: Curves.easeInOut,
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: Transform.scale(
        scale: value,
        child: child,
      ),
    );
  },
  child: const FlutterLogo(),
)
```

### AnimatedSwitcher

Cross-fades between two widgets.

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  transitionBuilder: (Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
  child: _showFirst
      ? const Text('First')
      : const Text('Second'),
)
```

With custom size transition:
```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 500),
  transitionBuilder: (Widget child, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: child,
    );
  },
  child: _expanded
      ? const Text('Expanded content')
      : const Text('Collapsed content'),
)
```

### AnimatedDefaultTextStyle

Animates text style changes.

```dart
AnimatedDefaultTextStyle(
  duration: const Duration(milliseconds: 300),
  style: TextStyle(
    fontSize: _large ? 32 : 16,
    color: _colored ? Colors.blue : Colors.black,
    fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
  ),
  child: const Text('Animated text'),
)
```

### AnimatedPhysicalModel

Animates elevation, color, and shape with physical shadow.

```dart
AnimatedPhysicalModel(
  duration: const Duration(milliseconds: 300),
  shape: BoxShape.rectangle,
  elevation: _elevated ? 12 : 0,
  color: _elevated ? Colors.blue : Colors.grey[300]!,
  borderRadius: BorderRadius.circular(12),
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Physical model'),
  ),
)
```

### AnimatedTheme

Animates theme changes.

```dart
AnimatedTheme(
  duration: const Duration(milliseconds: 500),
  data: ThemeData(
    brightness: _darkMode ? Brightness.dark : Brightness.light,
    primaryColor: _darkMode ? Colors.blue[700] : Colors.blue,
  ),
  child: const MyChildWidget(),
)
```

## Common Parameters

All implicit animations support these parameters:

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),  // Required: Animation duration
  curve: Curves.easeInOut,                 // Optional: Animation curve
  onEnd: () {},                           // Optional: Completion callback
  child: Widget(),                           // The child widget to animate
)
```

### Duration

```dart
const Duration(milliseconds: 300)  // 0.3 seconds
const Duration(seconds: 1)          // 1 second
const Duration(days: 1)               // 1 day
```

### Curves

Common curves from `Curves` class:

```dart
Curves.linear        // Linear (no easing)
Curves.ease          // Simple ease in and out
Curves.easeIn        // Slow start, fast end
Curves.easeOut       // Fast start, slow end
Curves.easeInOut     // Slow start and end, fast middle
Curves.easeInCubic   // Cubic ease in
Curves.easeOutCubic  // Cubic ease out
Curves.easeInOutCubic // Cubic ease in and out
Curves.elasticIn     // Bounces in
Curves.elasticOut    // Bounces out
Curves.elasticInOut  // Bounces in and out
Curves.bounceIn      // Bounces in (more subtle)
Curves.bounceOut     // Bounces out (more subtle)
```

Custom curve:
```dart
class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}

// Usage
AnimatedContainer(
  curve: ShakeCurve(),
  // ...
)
```

### onEnd Callback

Trigger action when animation completes:

```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 300),
  onEnd: () {
    if (!_visible) {
      // Animation finished fading out
      // Remove widget, navigate, etc.
    }
  },
  child: const Text('Hello'),
)
```

## Best Practices

### DO

- Use implicit animations for simple, one-off animations
- Set appropriate durations for natural feel (200-500ms typical)
- Use curves to make animations feel natural
- Use `onEnd` callback for post-animation actions
- Test animations on various devices
- Consider `MediaQuery.disableAnimations` for accessibility

### DON'T

- Use implicit animations for complex, multi-property sequences (use staggered instead)
- Forget to set duration (defaults to instant change)
- Use extremely long durations (> 1s) without good reason
- Animate too many properties simultaneously (performance impact)
- Nest implicit animations deeply (can cause jank)

## Performance Tips

- Implicit animations are optimized but still rebuild during animation
- Avoid animating complex widget trees
- Use `RepaintBoundary` around animated children to isolate repaints
- Test performance with Flutter DevTools Performance overlay
- Consider using `AnimatedBuilder` for complex widgets to minimize rebuilds

## Debugging

### Slow Animations

```dart
// Slow all animations by 10x during development
timeDilation = 10.0;
```

### Show Repaint Rainbows

```dart
void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}
```

### Performance Overlay

```dart
void main() {
  runApp(MyApp());
}

// In debug mode, press 'p' to toggle performance overlay
```

## Comparison: Implicit vs Explicit

| Feature | Implicit | Explicit |
|---------|----------|-----------|
| Controller needed | No | Yes (AnimationController) |
| Setup complexity | Low | Medium/High |
| Reusability | Widget-based | Controller-based |
| Multiple properties | AnimatedContainer only | Unlimited |
| Lifecycle control | Limited | Full |
| State monitoring | Limited (onEnd) | Full (addStatusListener) |
| Performance | Good | Excellent (with proper patterns) |

## When to Use Implicit Animations

Use implicit animations when:
- Animating a single property
- Animation is triggered by state change
- No need for fine-grained control
- Want simple, declarative code
- Animation is one-time or simple toggle

Use explicit animations when:
- Need full control over animation lifecycle
- Animating multiple properties
- Need to react to animation state
- Creating reusable animation components
- Need complex timing or sequencing
- Performance is critical
