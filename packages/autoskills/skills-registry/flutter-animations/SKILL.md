---
name: flutter-animations
description: "Comprehensive guide for implementing animations in Flutter. Use when adding motion and visual effects to Flutter apps: implicit animations (AnimatedContainer, AnimatedOpacity, TweenAnimationBuilder), explicit animations (AnimationController, Tween, AnimatedWidget/AnimatedBuilder), hero animations (shared element transitions), staggered animations (sequential/overlapping), and physics-based animations. Includes workflow for choosing the right animation type, implementation patterns, and best practices for performance and user experience."
metadata:
  author: Stanislav [MADTeacher] Chernyshev
  version: "1.0"
---

# Flutter Animations

## Overview

Create smooth, performant animations in Flutter using the right approach for each use case. This skill covers complete animation workflow: from choosing between implicit/explicit approaches to implementing complex effects like hero transitions and staggered animations.

## Animation Type Decision Tree

Choose the right animation type based on your requirements:

**Implicit Animations** - Use when:
- Animating a single property (color, size, position)
- Animation is triggered by state change
- No need for fine-grained control

**Explicit Animations** - Use when:
- Need full control over animation lifecycle
- Animating multiple properties simultaneously
- Need to react to animation state changes
- Creating custom animations or transitions

**Hero Animations** - Use when:
- Sharing an element between two screens
- Creating shared element transitions
- User expects element to "fly" between routes

**Staggered Animations** - Use when:
- Multiple animations should run sequentially or overlap
- Creating ripple effects or sequential reveals
- Animating list items in sequence

**Physics-Based Animations** - Use when:
- Animations should feel natural/physical
- Spring-like behavior, scrolling gestures
- Draggable interactions

## Implicit Animations

Implicit animations automatically handle the animation when properties change. No controller needed.

### Common Implicit Widgets

**AnimatedContainer** - Animates multiple properties (size, color, decoration, padding):

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _expanded ? 200 : 100,
  height: _expanded ? 200 : 100,
  color: _expanded ? Colors.blue : Colors.red,
  child: const FlutterLogo(),
)
```

**AnimatedOpacity** - Simple fade animation:

```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 300),
  child: const Text('Hello'),
)
```

**TweenAnimationBuilder** - Custom tween animation without boilerplate:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(begin: 0, end: 1),
  duration: const Duration(seconds: 1),
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

**Other implicit widgets:**
- `AnimatedPadding` - Padding animation
- `AnimatedPositioned` - Position animation (in Stack)
- `AnimatedAlign` - Alignment animation
- `AnimatedContainer` - Multiple properties
- `AnimatedSwitcher` - Cross-fade between widgets
- `AnimatedDefaultTextStyle` - Text style animation

### Best Practices

- Prefer implicit animations for simple cases
- Use appropriate curves for natural motion (see `Curves` class)
- Set `curve` and `duration` for predictable behavior
- Use `onEnd` callback when needed
- Avoid nested implicit animations for performance

## Explicit Animations

Explicit animations provide full control with AnimationController.

### Core Components

**AnimationController** - Drives the animation:

```dart
late AnimationController _controller;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

**Tween** - Interpolates between begin and end values:

```dart
animation = Tween<double>(begin: 0, end: 300).animate(_controller);
```

**CurvedAnimation** - Applies a curve to the animation:

```dart
animation = CurvedAnimation(
  parent: _controller,
  curve: Curves.easeInOut,
);
```

### AnimatedWidget Pattern

Best for reusable animated widgets:

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
```

### AnimatedBuilder Pattern

Best for complex widgets with animations:

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
```

### Monitoring Animation State

```dart
animation.addStatusListener((status) {
  switch (status) {
    case AnimationStatus.completed:
      _controller.reverse();
      break;
    case AnimationStatus.dismissed:
      _controller.forward();
      break;
    default:
      break;
  }
});
```

### Multiple Simultaneous Animations

```dart
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
```

### Built-in Explicit Transitions

Flutter provides ready-to-use transitions:
- `FadeTransition` - Fade animation
- `ScaleTransition` - Scale animation
- `SlideTransition` - Slide animation
- `SizeTransition` - Size animation
- `RotationTransition` - Rotation animation
- `PositionedTransition` - Position animation (in Stack)

Example:
```dart
FadeTransition(
  opacity: _animation,
  child: const FlutterLogo(),
)
```

### Performance Tips

- Dispose controllers when widget is removed
- Use `AnimatedBuilder` for optimal rebuilds
- Avoid `setState()` in animation listeners (use `AnimatedWidget`/`AnimatedBuilder`)
- Use `timeDilation` to slow animations during debugging

## Hero Animations

Hero animations create shared element transitions between screens.

### Basic Hero Animation

**Source screen:**
```dart
Hero(
  tag: 'hero-image',
  child: Image.asset('images/logo.png'),
)
```

**Destination screen:**
```dart
Hero(
  tag: 'hero-image',  // Same tag!
  child: Image.asset('images/logo.png'),
)
```

### Complete Example

```dart
class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(photo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
```

**Navigating between screens:**
```dart
Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: Center(
          child: PhotoHero(
            photo: 'images/logo.png',
            width: 300.0,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      );
    },
  ),
);
```

### Radial Hero Animation

Transform from circle to rectangle during transition:

```dart
class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    super.key,
    required this.maxRadius,
    this.child,
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
```

Use with `MaterialRectCenterArcTween` for center-based interpolation:
```dart
static RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}
```

### Hero Best Practices

- Use unique, consistent tags (often the data object itself)
- Keep hero widget trees similar between routes
- Wrap images in `Material` with transparent color for "pop" effect
- Use `timeDilation` to debug transitions
- Consider `HeroMode` to disable hero animations when needed

## Staggered Animations

Run multiple animations with different timing.

### Basic Staggered Animation

All animations share one controller:

```dart
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({super.key, required this.controller})
    : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.100, curve: Curves.ease),
        ),
      ),
      width = Tween<double>(begin: 50.0, end: 150.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.125, 0.250, curve: Curves.ease),
        ),
      );

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> width;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: 150,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
```

### Interval-Based Timing

Each animation has an Interval between 0.0 and 1.0:

```dart
animation = Tween<double>(begin: 0, end: 300).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(
      0.25,  // Start at 25% of controller duration
      0.50,  // End at 50% of controller duration
      curve: Curves.ease,
    ),
  ),
);
```

### Common Tweens

```dart
borderRadius = BorderRadiusTween(
  begin: BorderRadius.circular(4),
  end: BorderRadius.circular(75),
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.375, 0.500, curve: Curves.ease),
  ),
);
```

### Staggered Menu Animation

```dart
class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);

  final _animationDuration =
      _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Stagger Best Practices

- Use `Interval` to offset animations in time
- Ensure controller duration covers all intervals
- Use curves for natural motion within intervals
- Consider `timeDilation` to debug timing
- Stagger menu items with increasing delay for ripple effect

## Physics-Based Animations

Create natural-feeling animations using physics simulations.

### Fling Animation

```dart
_controller.fling(
  velocity: 2.0,  // Units per second
);
```

### Custom Physics Simulation

```dart
_controller.animateWith(
  SpringSimulation(
    spring: const SpringDescription(
      mass: 1,
      stiffness: 100,
      damping: 10,
    ),
    start: 0.0,
    end: 1.0,
    velocity: 0.0,
  ),
);
```

### Common Physics Simulations

- `SpringSimulation` - Spring physics
- `BouncingScrollSimulation` - Scroll with bounce
- `ClampingScrollSimulation` - Scroll without bounce
- `GravitySimulation` - Gravity-based

## Best Practices

### DO

- Dispose AnimationController in widget disposal
- Use `AnimatedBuilder`/`AnimatedWidget` instead of `setState()` in listeners
- Choose appropriate curves for natural motion
- Use `timeDilation` for debugging animations
- Consider performance (avoid heavy widgets in animation builds)
- Test animations on various devices
- Support reverse animations for intuitive feel

### DON'T

- Forget to dispose AnimationController (memory leak)
- Use `setState()` in animation listeners when `AnimatedBuilder` suffices
- Assume animation completes instantly (handle `AnimationStatus`)
- Over-animate (animations can distract users)
- Create animations that feel "jerky" (use smooth curves)
- Ignore accessibility (respect `disableAnimations` preference)

## Resources

### references/

**implicit.md** - Complete reference for implicit animation widgets with examples and best practices.

**explicit.md** - Deep dive into explicit animations, AnimationController, and patterns.

**hero.md** - Hero animations guide with standard and radial transitions.

**staggered.md** - Staggered animation patterns and timing strategies.

**physics.md** - Physics-based animations and simulations.

**curves.md** - Reference for Curves class and choosing appropriate curves.

### assets/templates/

Template code for common animation patterns:
- `implicit_animation.dart` - Implicit animation examples
- `explicit_animation.dart` - Explicit animation setup
- `hero_transition.dart` - Hero animation boilerplate
- `staggered_animation.dart` - Staggered animation template
