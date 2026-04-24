# Physics-Based Animations Reference

Physics-based animations create natural-feeling motion using simulations like springs, gravity, and momentum.

## Core Concept

Instead of linear interpolation, use physics simulations for realistic motion that responds naturally to forces like velocity and damping.

## Fling Animation

### Basic Fling

```dart
class FlingWidget extends StatefulWidget {
  @override
  State<FlingWidget> createState() => _FlingWidgetState();
}

class _FlingWidgetState extends State<FlingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.fling(velocity: 2.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_controller.value * 100, 0),
          child: child,
        );
      },
      child: const FlutterLogo(),
    );
  }
}
```

### Fling with Gesture

```dart
class DraggableFling extends StatefulWidget {
  @override
  State<DraggableFling> createState() => _DraggableFlingState();
}

class _DraggableFlingState extends State<DraggableFling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragX = 0;
  Offset? _startPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePanStart(DragStartDetails details) {
    _controller.stop();
    _startPosition = details.globalPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_startPosition != null) {
      setState(() {
        _dragX += details.delta.dx;
      });
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    _controller.fling(velocity: details.velocity.pixelsPerSecond.dx / 1000);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_dragX + _controller.value, 0),
            child: child,
          );
        },
        child: const FlutterLogo(),
      ),
    );
  }
}
```

## Spring Simulation

### Basic Spring

```dart
class SpringAnimation extends StatefulWidget {
  @override
  State<SpringAnimation> createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);

    _controller.animateWith(
      SpringSimulation(
        spring: const SpringDescription(
          mass: 1.0,
          stiffness: 200.0,
          damping: 10.0,
        ),
        start: 0.0,
        end: 1.0,
        velocity: 0.0,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _controller.value,
          child: child,
        );
      },
      child: const FlutterLogo(),
    );
  }
}
```

### Spring Description Parameters

```dart
SpringDescription(
  mass: 1.0,        // Mass of the object (higher = more inertia)
  stiffness: 200.0,   // Spring stiffness (higher = faster, stiffer)
  damping: 10.0,      // Damping ratio (higher = less oscillation)
)
)
```

**Mass:**
- How "heavy" the object feels
- Typical values: 0.5 - 5.0
- Higher mass = more momentum, slower response

**Stiffness:**
- How stiff the spring is
- Typical values: 100 - 500
- Higher stiffness = faster oscillation
- Lower stiffness = slower, more "bouncy"

**Damping:**
- How quickly oscillation stops
- Typical values: 5 - 20
- Higher damping = less bounce
- Lower damping = more bounce
- Critical damping: ~15-18

### Spring Presets

**Bouncy:**
```dart
SpringDescription(
  mass: 0.5,
  stiffness: 300,
  damping: 8,
)
```

**Snappy:**
```dart
SpringDescription(
  mass: 1.0,
  stiffness: 400,
  damping: 18,
)
```

**Gentle:**
```dart
SpringDescription(
  mass: 2.0,
  stiffness: 150,
  damping: 20,
)
```

## Gravity Simulation

### Falling Animation

```dart
class GravityAnimation extends StatefulWidget {
  @override
  State<GravityAnimation> createState() => _GravityAnimationState();
}

class _GravityAnimationState extends State<GravityAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);

    _controller.animateWith(
      GravitySimulation(
        acceleration: 980,  // pixels/s²
        distance: 500,  // pixels to fall
        startDistance: 0,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _controller.value),
          child: child,
        );
      },
      child: const FlutterLogo(),
    );
  }
}
```

## Scroll Physics

### Bouncing Scroll

```dart
CustomScrollView(
  physics: const BouncingScrollPhysics(),
  slivers: [
    SliverList(
      delegate: SliverChildListDelegate([
        // Items
      ]),
    ),
  ],
)
```

### Clamping Scroll

```dart
CustomScrollView(
  physics: const ClampingScrollPhysics(),
  slivers: [
    SliverList(
      delegate: SliverChildListDelegate([
        // Items
      ]),
    ),
  ],
)
```

### Fixed Scroll

```dart
CustomScrollView(
  physics: const NeverScrollableScrollPhysics(),
  slivers: [
    SliverList(
      delegate: SliverChildListDelegate([
        // Items
      ]),
    ),
  ],
)
```

### Platform-Adaptive Scroll

```dart
CustomScrollView(
  physics: const AlwaysScrollableScrollPhysics(),
  slivers: [
    SliverList(
      delegate: SliverChildListDelegate([
        // Items
      ]),
    ),
  ],
)
```

## Custom Simulation

### Creating Custom Simulation

```dart
class CustomSimulation extends Simulation {
  final double target;

  CustomSimulation({required this.target});

  @override
  double x(double time) {
    // Calculate position at given time
    return target * (1 - math.exp(-time / 0.5));
  }

  @override
  double dx(double time) {
    // Calculate velocity (derivative) at given time
    return target * math.exp(-time / 0.5) / 0.5;
  }

  @override
  bool isDone(double time) {
    return dx(time).abs() < 0.01;
  }
}
```

**Usage:**
```dart
_controller.animateWith(
  CustomSimulation(target: 1.0),
);
```

### Decay Simulation

```dart
class DecaySimulation extends Simulation {
  final double velocity;

  DecaySimulation({required this.velocity});

  @override
  double x(double time) {
    return velocity * (1 - math.exp(-time));
  }

  @override
  double dx(double time) {
    return velocity * math.exp(-time);
  }

  @override
  bool isDone(double time) {
    return dx(time).abs() < 0.1;
  }
}
```

## Combining Physics and Animation

### Spring with Fallback

```dart
void animateWithSpring({
  required AnimationController controller,
  required double start,
  required double end,
}) {
  try {
    controller.animateWith(
      SpringSimulation(
        spring: const SpringDescription(
          mass: 1.0,
          stiffness: 200.0,
          damping: 15.0,
        ),
        start: start,
        end: end,
        velocity: 0.0,
      ),
    );
  } catch (e) {
    // Fallback to linear animation
    controller.animateTo(end);
  }
}
```

### Spring with Completion Callback

```dart
_controller.animateWith(
  SpringSimulation(
    spring: const SpringDescription(
      mass: 1.0,
      stiffness: 200.0,
      damping: 15.0,
    ),
    start: 0.0,
    end: 1.0,
    velocity: 0.0,
  ),
);

_controller.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    // Animation complete
  }
});
```

## Physics for Gestures

### Swipe to Dismiss with Physics

```dart
class DismissibleWithPhysics extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismiss;

  const DismissibleWithPhysics({
    super.key,
    required this.child,
    required this.onDismiss,
  });

  @override
  State<DismissibleWithPhysics> createState() => _DismissibleWithPhysicsState();
}

class _DismissibleWithPhysicsState extends State<DismissibleWithPhysics>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragX = 0;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    final screenWidth = MediaQuery.of(context).size.width;

    if (velocity.abs() > 500 || _dragX.abs() > screenWidth / 3) {
      // Dismiss
      _controller.fling(velocity: velocity / screenWidth);
      _isDismissing = true;
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && _isDismissing) {
          widget.onDismiss();
        }
      });
    } else {
      // Spring back
      _controller.animateWith(
        SpringSimulation(
          spring: const SpringDescription(
            mass: 1.0,
            stiffness: 300.0,
            damping: 15.0,
          ),
          start: _dragX,
          end: 0,
          velocity: velocity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (!_controller.isAnimating) {
          setState(() {
            _dragX += details.delta.dx;
          });
        }
      },
      onPanEnd: _handlePanEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_dragX + _controller.value, 0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
```

## Performance Considerations

### Simulation Complexity

Physics simulations can be computationally expensive. Optimize by:

- Using simpler simulations when possible (e.g., linear interpolation)
- Reducing simulation resolution
- Caching simulation results
- Using built-in physics widgets

### Spring Tuning

Finding the right spring parameters can be trial and error:

1. Start with moderate values (mass: 1.0, stiffness: 200, damping: 15)
2. Adjust for feel:
   - Too slow? Increase stiffness or decrease mass
   - Too bouncy? Increase damping
   - Not bouncy enough? Decrease damping or stiffness
3. Test on real devices

## Debugging

### Visualize Physics

```dart
void main() {
  timeDilation = 5.0;  // Slow down physics
  runApp(MyApp());
}
```

### Print Simulation Values

```dart
_controller.addListener(() {
  print('Position: ${_controller.value}');
});

_controller.addStatusListener((status) {
  print('Status: $status');
});
```

### Physics Inspector

Use Flutter DevTools to profile physics animations:
1. Open Performance overlay
2. Look for frame drops during physics simulations
3. Identify expensive calculations

## Best Practices

### DO

- Use physics simulations for natural-feeling motion
- Tune spring parameters for desired feel
- Test on various devices and screen sizes
- Profile performance with DevTools
- Provide fallback animations for physics failures

### DON'T

- Use complex physics when simple curves suffice
- Forget to handle simulation completion
- Use overly bouncy animations (distracting)
- Ignore accessibility (respect disable animations preference)
- Assume physics simulation completes instantly

## Common Physics Patterns

### Bouncy Button Press

```dart
_controller.animateWith(
  SpringSimulation(
    spring: const SpringDescription(
      mass: 0.5,
      stiffness: 500,
      damping: 10,
    ),
    start: 1.0,
    end: 0.9,
    velocity: 0,
  ),
);
```

### Swipeable Card

```dart
_controller.fling(
  velocity: details.velocity.pixelsPerSecond.dx / 1000,
);
```

### Pull to Refresh

```dart
RefreshIndicator(
  onRefresh: () async {
    // Refresh data
  },
  child: ListView(...),
)
```

## Accessibility

- Respect `MediaQuery.disableAnimations` setting
- Provide non-physics alternatives
- Ensure physics animations don't cause motion sickness
- Test with reduced motion settings

## Platform-Specific Physics

### Adaptive Scroll Physics

```dart
class AdaptiveScrollPhysics extends ScrollPhysics {
  const AdaptiveScrollPhysics({super.parent});

  @override
  AdaptiveScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AdaptiveScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => Platform.isIOS
      ? const SpringDescription(
          mass: 0.5,
          stiffness: 100,
          damping: 10,
        )
      : const SpringDescription(
          mass: 0.8,
          stiffness: 150,
          damping: 15,
        );
}
```

**Usage:**
```dart
ListView(
  physics: const AdaptiveScrollPhysics(),
  children: [...],
)
```
