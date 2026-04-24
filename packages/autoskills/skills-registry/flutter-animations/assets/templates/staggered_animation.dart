import 'package:flutter/material.dart';

/// Staggered animation example with multiple property animations
///
/// This example demonstrates:
/// - Single AnimationController driving multiple animations
/// - Interval-based timing for sequential/overlapping animations
/// - Multiple tweens for different properties
/// - Status monitoring for animation loops

void main() => runApp(const StaggeredAnimationApp());

class StaggeredAnimationApp extends StatelessWidget {
  const StaggeredAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staggered Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StaggeredDemo(),
    );
  }
}

/// Staggered animation with fade, scale, and color changes
class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({super.key, required this.controller});

  late final Animation<double> opacity = Tween<double>(begin: 0.0, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.1, curve: Curves.ease),
        ),
      );

  late final Animation<double> width = Tween<double>(begin: 50.0, end: 150.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.125, 0.25, curve: Curves.ease),
        ),
      );

  late final Animation<double> height = Tween<double>(begin: 50.0, end: 150.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.25, 0.375, curve: Curves.ease),
        ),
      );

  late final Animation<BorderRadius?> borderRadius =
      BorderRadiusTween(
        begin: BorderRadius.circular(4),
        end: BorderRadius.circular(75),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.375, 0.5, curve: Curves.ease),
        ),
      );

  late final Animation<Color?> color =
      ColorTween(begin: Colors.red, end: Colors.orange).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.5, 0.625, curve: Curves.ease),
        ),
      );

  final AnimationController controller;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Center(
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(color: Colors.indigo[300]!, width: 3),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggeredDemo extends StatefulWidget {
  const StaggeredDemo({super.key});

  @override
  State<StaggeredDemo> createState() => _StaggeredDemoState();
}

class _StaggeredDemoState extends State<StaggeredDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // Animation was canceled
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Animation')),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnimation,
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              border: Border.all(color: Colors.black.withValues(alpha: 0.5)),
            ),
            child: StaggeredAnimation(controller: _controller.view),
          ),
        ),
      ),
    );
  }
}

/// Staggered menu animation example
class StaggeredMenuExample extends StatefulWidget {
  const StaggeredMenuExample({super.key});

  @override
  State<StaggeredMenuExample> createState() => _StaggeredMenuExampleState();
}

class _StaggeredMenuExampleState extends State<StaggeredMenuExample>
    with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Declarative Style',
    'Premade Widgets',
    'Stateful Hot Reload',
    'Native Performance',
    'Great Community',
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);

  late AnimationController _controller;

  final _animationDuration =
      _initialDelayTime + (_staggerTime * _menuTitles.length) + _itemSlideTime;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Menu')),
      body: ListView.builder(
        itemCount: _menuTitles.length,
        itemBuilder: (context, index) {
          final start =
              _initialDelayTime.inMilliseconds.toDouble() +
              (_staggerTime.inMilliseconds.toDouble() * index);
          final end = start + _itemSlideTime.inMilliseconds.toDouble();
          final intervalStart =
              start / _animationDuration.inMilliseconds.toDouble();
          final intervalEnd =
              end / _animationDuration.inMilliseconds.toDouble();

          final animation = CurvedAnimation(
            parent: _controller,
            curve: Interval(intervalStart, intervalEnd, curve: Curves.easeOut),
          );

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: ListTile(title: Text(_menuTitles[index])),
          );
        },
      ),
    );
  }
}
