import 'package:flutter/material.dart';

/// Explicit animation example using AnimationController
///
/// This example demonstrates:
/// - AnimationController setup and lifecycle
/// - Tween interpolation
/// - AnimatedWidget pattern for reusable animations
/// - AnimatedBuilder pattern for complex widgets
/// - Animation status monitoring

void main() => runApp(const ExplicitAnimationApp());

class ExplicitAnimationApp extends StatelessWidget {
  const ExplicitAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explicit Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LogoAnimationDemo(),
    );
  }
}

/// Basic explicit animation with addListener and setState
class BasicExplicitAnimation extends StatefulWidget {
  const BasicExplicitAnimation({super.key});

  @override
  State<BasicExplicitAnimation> createState() => _BasicExplicitAnimationState();
}

class _BasicExplicitAnimationState extends State<BasicExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {});
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
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Explicit')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _animation.value,
          width: _animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

/// AnimatedWidget pattern - best for reusable animated widgets
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class AnimatedWidgetDemo extends StatefulWidget {
  const AnimatedWidgetDemo({super.key});

  @override
  State<AnimatedWidgetDemo> createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<AnimatedWidgetDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
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
      appBar: AppBar(title: const Text('Animated Widget')),
      body: AnimatedLogo(animation: _animation),
    );
  }
}

/// AnimatedBuilder pattern - best for complex widgets
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

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

class AnimatedBuilderDemo extends StatefulWidget {
  const AnimatedBuilderDemo({super.key});

  @override
  State<AnimatedBuilderDemo> createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
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
      appBar: AppBar(title: const Text('Animated Builder')),
      body: GrowTransition(animation: _animation, child: const LogoWidget()),
    );
  }
}

/// Multiple simultaneous animations with status monitoring
class MultiPropertyAnimation extends AnimatedWidget {
  const MultiPropertyAnimation({
    super.key,
    required Animation<double> animation,
  }) : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);
  static final _colorTween = ColorTween(begin: Colors.red, end: Colors.blue);

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

class MultiPropertyDemo extends StatefulWidget {
  const MultiPropertyDemo({super.key});

  @override
  State<MultiPropertyDemo> createState() => _MultiPropertyDemoState();
}

class _MultiPropertyDemoState extends State<MultiPropertyDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Property')),
      body: MultiPropertyAnimation(animation: _animation),
    );
  }
}

/// Main demo widget showing all examples
class LogoAnimationDemo extends StatelessWidget {
  const LogoAnimationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const BasicExplicitAnimation(),
                ),
              ),
              child: const Text('Basic Explicit'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const AnimatedWidgetDemo(),
                ),
              ),
              child: const Text('Animated Widget'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const AnimatedBuilderDemo(),
                ),
              ),
              child: const Text('Animated Builder'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const MultiPropertyDemo(),
                ),
              ),
              child: const Text('Multi Property'),
            ),
          ],
        ),
      ),
    );
  }
}
