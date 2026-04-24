import 'package:flutter/material.dart';

/// Implicit animation example showing basic fade animation
///
/// This example demonstrates:
/// - AnimatedOpacity for fade in/out
/// - State-driven animation triggers
/// - Simple, declarative animation code

void main() => runApp(const ImplicitAnimationApp());

class ImplicitAnimationApp extends StatelessWidget {
  const ImplicitAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Implicit Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FadeExample(),
    );
  }
}

class FadeExample extends StatefulWidget {
  const FadeExample({super.key});

  @override
  State<FadeExample> createState() => _FadeExampleState();
}

class _FadeExampleState extends State<FadeExample> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit Fade')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: const FlutterLogo(size: 100),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _visible = !_visible),
              child: Text(_visible ? 'Fade Out' : 'Fade In'),
            ),
          ],
        ),
      ),
    );
  }
}

/// AnimatedContainer example - animating multiple properties
class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Container')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _expanded = !_expanded),
              child: Text(_expanded ? 'Shrink' : 'Expand'),
            ),
          ],
        ),
      ),
    );
  }
}

/// TweenAnimationBuilder example - custom tween without boilerplate
class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  State<TweenAnimationBuilderExample> createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  bool _animated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tween Animation Builder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(scale: value, child: child),
                );
              },
              child: const FlutterLogo(size: 100),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _animated = !_animated),
              child: const Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }
}
