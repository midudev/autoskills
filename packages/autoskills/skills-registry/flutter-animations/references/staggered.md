# Staggered Animations Reference

Staggered animations run multiple animations with different timing offsets, creating sequential or overlapping visual effects.

## Core Concept

All animations share one `AnimationController`. Each animation has an `Interval` defining when it starts and ends within the controller's timeline.

## Basic Staggered Animation

### Two-Property Stagger

```dart
class StaggeredFadeSlide extends StatelessWidget {
  const StaggeredFadeSlide({super.key, required this.controller});

  final AnimationController controller;

  // Fade in first (0.0 - 0.5 of controller)
  late final Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ),
  );

  // Slide in later (0.25 - 1.0 of controller)
  late final Animation<Offset> slide = Tween<Offset>(
    begin: Offset(0, 0.5),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: opacity,
          child: SlideTransition(
            position: slide,
            child: child,
          ),
        );
      },
      child: const Text('Staggered animation'),
    );
  }
}
```

### Multiple Intervals Example

```dart
class MultiPropertyStagger extends StatelessWidget {
  const MultiPropertyStagger({super.key, required this.controller});

  final AnimationController controller;

  // Opacity: 0.0 - 0.1 (10%)
  late final Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.1, curve: Curves.ease),
    ),
  );

  // Width: 0.125 - 0.25 (12.5% - 25%)
  late final Animation<double> width = Tween<double>(begin: 50, end: 150).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.125, 0.25, curve: Curves.ease),
    ),
  );

  // Height: 0.25 - 0.375 (25% - 37.5%)
  late final Animation<double> height = Tween<double>(begin: 50, end: 150).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.375, curve: Curves.ease),
    ),
  );

  // Border radius: 0.375 - 0.5 (37.5% - 50%)
  late final Animation<BorderRadius?> borderRadius = BorderRadiusTween(
    begin: BorderRadius.circular(4),
    end: BorderRadius.circular(75),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.375, 0.5, curve: Curves.ease),
    ),
  );

  // Color: 0.5 - 0.625 (50% - 62.5%)
  late final Animation<Color?> color = ColorTween(
    begin: Colors.red,
    end: Colors.orange,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 0.625, curve: Curves.ease),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Container(
            width: width.value,
            height: height.value,
            decoration: BoxDecoration(
              color: color.value,
              borderRadius: borderRadius.value,
            ),
            child: child,
          ),
        );
      },
      child: const FlutterLogo(),
    );
  }
}
```

## Controller Setup

### Single Controller

```dart
class _StaggerState extends State<StaggerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggerAnimation(controller: _controller.view);
  }
}
```

### Multiple Controllers

For independent animation sequences:

```dart
class _ComplexStaggerState extends State<ComplexStaggerWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    _fadeInController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Start fade, then slide
    _fadeInController.forward().then((_) {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _slideController.dispose();
    super.dispose();
  }
}
```

## Interval Timing

### Understanding Interval

```dart
Interval(
  0.25,  // Start at 25% of controller duration
  0.75,  // End at 75% of controller duration
  curve: Curves.easeInOut,
)
```

**Example:** If controller duration is 2000ms:
- Animation starts at 500ms (0.25 * 2000)
- Animation ends at 1500ms (0.75 * 2000)
- Animation takes 1000ms (1500 - 500)

### Overlapping Intervals

```dart
// Animation 1: 0.0 - 0.5 (first half)
anim1 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.0, 0.5),
  ),
);

// Animation 2: 0.3 - 0.8 (starts before anim1 ends)
anim2 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.3, 0.8),
  ),
);

// Animation 3: 0.6 - 1.0 (starts after anim1 ends)
anim3 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.6, 1.0),
  ),
);
```

### Gaps Between Animations

```dart
// Animation 1: 0.0 - 0.4
// Gap: 0.4 - 0.5
// Animation 2: 0.5 - 0.9

anim1 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.0, 0.4),
  ),
);

anim2 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.5, 0.9),
  ),
);
```

## Staggered List Animation

### Menu Items Animation

```dart
class StaggeredMenu extends StatefulWidget {
  const StaggeredMenu({super.key});

  static const _menuItems = [
    'Home',
    'Profile',
    'Settings',
    'About',
  ];

  @override
  State<StaggeredMenu> createState() => _StaggeredMenuState();
}

class _StaggeredMenuState extends State<StaggeredMenu>
    with SingleTickerProviderStateMixin {
  static const _itemDelayTime = Duration(milliseconds: 50);
  static const _itemAnimationTime = Duration(milliseconds: 250);

  late AnimationController _controller;
  late List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _itemAnimationTime +
          (_itemDelayTime * (StaggeredMenu._menuItems.length - 1)),
      vsync: this,
    );

    _itemAnimations = StaggeredMenu._menuItems.map((item) {
      final index = StaggeredMenu._menuItems.indexOf(item);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.1,  // Start later for each item
            (index * 0.1) + 0.4,  // Each takes 40% of controller
            curve: Curves.easeOut,
          ),
        ),
      );
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: StaggeredMenu._menuItems.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  index * 0.1,
                  (index * 0.1) + 0.4,
                  curve: Curves.easeOut,
                ),
              )),
              child: FadeTransition(
                opacity: _itemAnimations[index],
                child: child,
              ),
            );
          },
          child: ListTile(
            title: Text(StaggeredMenu._menuItems[index]),
          ),
        );
      },
    );
  }
}
```

### Grid Animation

```dart
class StaggeredGrid extends StatefulWidget {
  const StaggeredGrid({super.key, required this.itemCount});

  final int itemCount;

  @override
  State<StaggeredGrid> createState() => _StaggeredGridState();
}

class _StaggeredGridState extends State<StaggeredGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animations = List.generate(widget.itemCount, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / widget.itemCount,
            (index / widget.itemCount) + 0.3,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _animations[index],
              child: ScaleTransition(
                scale: _animations[index],
                child: child,
              ),
            );
          },
          child: Card(
            child: Center(child: Text('Item $index')),
          ),
        );
      },
    );
  }
}
```

## Complex Staggered Patterns

### Sequential Completion

```dart
animation1 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.0, 0.3),
  ),
);

animation2 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.3, 0.6),
  ),
);

animation3 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.6, 1.0),
  ),
);
```

### Ripple Effect

```dart
// Center expands first, then outward
for (int i = 0; i < itemCount; i++) {
  final distance = (i - centerIndex).abs();
  animations[i] = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        distance * 0.1,
        (distance * 0.1) + 0.3,
        curve: Curves.easeOut,
      ),
    ),
  );
}
```

### Staggered Reveal

```dart
// Reveal items one by one from top
for (int i = 0; i < itemCount; i++) {
  animations[i] = CurvedAnimation(
    parent: controller,
    curve: Interval(
      i * 0.1,
      (i * 0.1) + 0.15,
      curve: Curves.easeOut,
    ),
  );
}

// Use for opacity or transform
Opacity(opacity: animations[i].value)
```

## Duration Calculation

### Calculate Total Duration

```dart
const itemDelay = Duration(milliseconds: 50);
const itemAnimationTime = Duration(milliseconds: 250);
const itemCount = 10;

final totalDuration = itemAnimationTime +
    (itemDelay * (itemCount - 1));

// 250ms + (50ms * 9) = 700ms
```

### Using in Controller

```dart
_controller = AnimationController(
  duration: totalDuration,
  vsync: this,
);
```

### Dynamic Duration

```dart
late AnimationController _controller;
late Duration _totalDuration;

@override
void initState() {
  super.initState();

  final itemCount = _items.length;
  const itemDelay = Duration(milliseconds: 50);
  const itemAnimationTime = Duration(milliseconds: 250);

  _totalDuration = itemAnimationTime + (itemDelay * (itemCount - 1));

  _controller = AnimationController(
    duration: _totalDuration,
    vsync: this,
  );

  // Create animations...
  _controller.forward();
}
```

## Repeating Staggered Animations

### Loop on Completion

```dart
_controller.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    _controller.reset();
    _controller.forward();
  }
});
```

### Ping-Pong (Forward and Reverse)

```dart
_controller.addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    _controller.reverse();
  } else if (status == AnimationStatus.dismissed) {
    _controller.forward();
  }
});
```

## Debugging Staggered Animations

### Slow Animation

```dart
void main() {
  timeDilation = 10.0;  // 10x slower
  runApp(MyApp());
}
```

### Print Interval Ranges

```dart
for (int i = 0; i < _animations.length; i++) {
  final anim = _animations[i] as CurvedAnimation;
  print('Animation $i: ${anim.curve}');
}

// Output:
// Animation 0: Interval(0.0, 0.4, Curves.easeOut)
// Animation 1: Interval(0.1, 0.5, Curves.easeOut)
// ...
```

### Visualize Animation State

```dart
class DebugStaggeredWidget extends StatelessWidget {
  const DebugStaggeredWidget({super.key, required this.controller, required this.animations});

  final AnimationController controller;
  final List<Animation<double>> animations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < animations.length; i++)
          Text('Animation $i: ${animations[i].value.toStringAsFixed(2)}'),
      ],
    );
  }
}
```

## Performance Best Practices

### DO

- Use one controller when animations are related
- Calculate total duration correctly
- Use `AnimatedBuilder` for optimal rebuilds
- Profile with Flutter DevTools
- Test on various devices
- Consider reducing animation complexity on low-end devices

### DON'T

- Create too many controllers unnecessarily
- Forget to dispose controllers
- Use complex widget trees inside staggered animations
- Animate too many items simultaneously (jank)
- Use very long durations without good reason

## Common Patterns

### Loading Animation

```dart
// Dot 1: 0.0 - 0.3
// Dot 2: 0.1 - 0.4
// Dot 3: 0.2 - 0.5
// Repeat forever
```

### Success Animation Sequence

```dart
// Checkmark appears: 0.0 - 0.3
// "Success!" text fades in: 0.2 - 0.5
// Confetti falls: 0.3 - 1.0
```

### Onboarding Steps

```dart
// Step 1: 0.0 - 0.25
// Step 2: 0.25 - 0.5
// Step 3: 0.5 - 0.75
// Step 4: 0.75 - 1.0
```

## Accessibility

- Respect `MediaQuery.disableAnimations` setting
- Provide alternative to complex staggered animations
- Ensure content remains accessible during animation
- Test with screen readers

## Advanced Techniques

### Conditional Staggering

```dart
// Show animations based on device performance
final isLowEnd = Platform.isAndroid && deviceInfo.version.sdkInt < 21;

final staggerDelay = isLowEnd
    ? Duration(milliseconds: 100)  // Slower on low-end
    : Duration(milliseconds: 50);
```

### Adaptive Staggering

```dart
// Adjust based on screen size
final screenWidth = MediaQuery.of(context).size.width;
final itemsPerRow = screenWidth ~/ 150;

// Calculate stagger based on grid position
final row = index ~/ itemsPerRow;
final col = index % itemsPerRow;
final startDelay = (row * 0.2) + (col * 0.05);
```

### Physics-Influenced Staggering

```dart
// Use spring physics for staggered elements
for (int i = 0; i < itemCount; i++) {
  animations[i] = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        i * 0.05,
        (i * 0.05) + 0.5,
        curve: Curves.elasticOut,
      ),
    ),
  );
}
```
