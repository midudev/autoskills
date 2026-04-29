# Hero Animations Reference

Hero animations create shared element transitions between screens, making elements appear to "fly" from one route to another.

## Core Concept

Use two `Hero` widgets with matching `tag` in different routes. Flutter automatically animates the transition between them.

## Basic Hero Animation

### Simple Image Transition

**Source route (list screen):**
```dart
GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const DetailScreen(),
      ),
    );
  },
  child: Hero(
    tag: 'hero-image',
    child: Image.asset('images/thumbnail.png'),
  ),
)
```

**Destination route (detail screen):**
```dart
Scaffold(
  appBar: AppBar(title: const Text('Detail')),
  body: GestureDetector(
    onTap: () => Navigator.of(context).pop(),
    child: Hero(
      tag: 'hero-image',  // Same tag!
      child: Image.asset('images/thumbnail.png'),
    ),
  ),
)
```

### Custom PhotoHero Widget

Reusable hero widget for images:

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
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
```

**Usage in source route:**
```dart
class SourceScreen extends StatelessWidget {
  const SourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return PhotoHero(
            photo: 'images/photo_$index.png',
            width: 100,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => DetailScreen(photo: 'images/photo_$index.png'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

**Usage in destination route:**
```dart
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: PhotoHero(
          photo: photo,
          width: 300,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
```

## Hero Tag Best Practices

### Using Object as Tag

For unique, consistent tags:

```dart
// Data model
class Photo {
  final String url;
  final String id;

  Photo({required this.url, required this.id});
}

// Source
Hero(
  tag: photo.id,  // Use unique identifier
  child: Image.network(photo.url),
)

// Destination
Hero(
  tag: photo.id,  // Same unique identifier
  child: Image.network(photo.url),
)
```

### Using Data Object as Tag

When data object is consistent:

```dart
// Source
Hero(
  tag: photo,  // Photo object must be same instance or implement ==
  child: Image.network(photo.url),
)

// Destination
Hero(
  tag: photo,  // Same Photo object
  child: Image.network(photo.url),
)
```

**Important:** If using object as tag, ensure proper `==` and `hashCode` implementation.

## Custom Hero Flight Path

### MaterialRectArcTween (Default)

```dart
Hero(
  tag: 'hero-image',
  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: child,
    );
  },
  createRectTween: (begin, end) {
    return MaterialRectArcTween(begin: begin, end: end);
  },
  child: Image.asset('image.png'),
)
```

### MaterialRectCenterArcTween

Center-based interpolation (good for maintaining aspect ratio):

```dart
static RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}

Hero(
  tag: 'hero-image',
  createRectTween: _createRectTween,
  child: Image.asset('image.png'),
)
```

### Custom RectTween

For complete control:

```dart
class LinearRectTween extends Tween<Rect> {
  LinearRectTween({required Rect begin, required Rect end})
    : super(begin: begin, end: end);

  @override
  Rect lerp(double t) => Rect.lerp(begin!, end!, t);
}

Hero(
  tag: 'hero-image',
  createRectTween: (begin, end) => LinearRectTween(begin: begin, end: end),
  child: Image.asset('image.png'),
)
```

## Radial Hero Animation

Transform from circle to rectangle during transition.

### RadialExpansion Widget

```dart
import 'dart:math' as math;

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

### Radial Photo Widget

```dart
class RadialPhoto extends StatelessWidget {
  const RadialPhoto({
    super.key,
    required this.photo,
    this.onTap,
  });

  final String photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
```

### Complete Radial Hero Example

```dart
class RadialHeroAnimation extends StatelessWidget {
  const RadialHeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero')),
      body: ListView(
        children: List.generate(6, (index) {
          final photo = 'images/photo_$index.png';
          return Hero(
            tag: photo,
            createRectTween: _createRectTween,
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: child,
              );
            },
            child: RadialExpansion(
              maxRadius: 120,
              child: RadialPhoto(
                photo: photo,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => DetailScreen(photo: photo),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Hero(
          tag: photo,
          createRectTween: RadialHeroAnimation._createRectTween,
          child: SizedBox(
            width: 300,
            height: 300,
            child: RadialPhoto(
              photo: photo,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Custom Placeholder During Flight

### flightShuttleBuilder

Customize hero appearance during flight:

```dart
Hero(
  tag: 'hero-image',
  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
    // fromContext - source hero's context
    // toContext - destination hero's context
    // direction - HeroFlightDirection.push or pop
    // animation - Animation<double> for the flight

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value * math.pi,
          child: child,
        );
      },
      child: child,
    );
  },
  child: Image.asset('image.png'),
)
```

### Replace Entire Hero During Flight

```dart
Hero(
  tag: 'hero-image',
  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
    // Show different widget during flight
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  },
  child: Image.asset('image.png'),
)
```

## Transition Settings

### Animation Duration

```dart
MaterialApp(
  // Set global hero animation duration
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  ),
)
```

### Custom PageTransitionBuilder

```dart
class CustomHeroTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext? secondaryContext,
    Widget child,
  ) {
    return FadeUpwardsPageTransitionsBuilder().buildTransitions(
      route,
      secondaryContext,
      child,
    );
  }
}
```

## Hero Mode

### Disable Hero Animations

```dart
HeroMode(
  enabled: false,  // Disable all child hero animations
  child: ListView(
    children: [
      Hero(tag: 'image1', child: Image.asset('1.png')),
      Hero(tag: 'image2', child: Image.asset('2.png')),
    ],
  ),
)
```

### Conditional Hero Mode

```dart
HeroMode(
  enabled: !_disableAnimations,
  child: Hero(tag: 'image', child: Image.asset('image.png')),
)
```

## Debugging Hero Animations

### Slow Animation

```dart
void main() {
  timeDilation = 10.0;  // 10x slower
  runApp(MyApp());
}
```

### Visualize Hero Bounds

```dart
void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}
```

### Print Hero Tags

```dart
class DebugHero extends StatelessWidget {
  const DebugHero({
    super.key,
    required this.tag,
    required this.child,
  });

  final Object tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('Building Hero with tag: $tag');
    return Hero(tag: tag, child: child);
  }
}
```

## Best Practices

### DO

- Use unique, consistent tags (often the data object itself)
- Keep hero widget trees similar between routes
- Wrap images in `Material` with transparent color for "pop" effect
- Use `timeDilation` to debug transitions
- Consider `createRectTween` for custom flight paths
- Use `flightShuttleBuilder` for custom flight appearance

### DON'T

- Use duplicate tags (conflicts!)
- Change hero structure significantly between routes (jarring transition)
- Forget `Material` wrapper (no splash effect)
- Use very large images in heroes (performance)
- Ignore aspect ratio during transition (distortion)

## Common Patterns

### Grid to Fullscreen Image

**Grid item:**
```dart
PhotoHero(
  photo: photo.url,
  width: 150,  // Smaller in grid
  onTap: () => Navigator.push(..., detailScreen),
)
```

**Fullscreen:**
```dart
PhotoHero(
  photo: photo.url,
  width: MediaQuery.of(context).size.width,  // Full width
  onTap: () => Navigator.pop(),
)
```

### List Header to Page Header

**List:**
```dart
Hero(
  tag: 'header',
  child: SizedBox(
    height: 200,
    child: Image.asset('header.jpg'),
  ),
)
```

**Page:**
```dart
Hero(
  tag: 'header',
  child: SizedBox(
    height: 300,  // Larger on detail page
    child: Image.asset('header.jpg'),
  ),
)
```

### Shared Element with Content Update

```dart
// In both routes
Hero(
  tag: 'card',
  child: Card(
    child: Column(
      children: [
        Image.asset('image.png'),
        Text(showDetails ? 'Full description...' : 'Brief description'),
      ],
    ),
  ),
)
```

## Performance Tips

- Optimize hero images (compress, lazy load)
- Use `RepaintBoundary` around hero children if needed
- Test on low-end devices
- Profile with Flutter DevTools Performance overlay
- Avoid complex widget trees inside hero

## Accessibility

- Respect `MediaQuery.disableAnimations` setting
- Consider alternative navigation for users who prefer no animations
- Ensure hero content remains accessible during transition
- Test with screen readers

## Advanced Techniques

### Multiple Heroes on Same Route

```dart
class PhotoDetail extends StatelessWidget {
  const PhotoDetail({super.key, required this.photos});

  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main photo hero
        Positioned.fill(
          child: Hero(
            tag: photos[0],
            child: Image.asset(photos[0]),
          ),
        ),
        // Overlay hero (e.g., like button)
        Positioned(
          top: 16,
          right: 16,
          child: Hero(
            tag: 'like-button',
            child: Icon(Icons.favorite),
          ),
        ),
      ],
    );
  }
}
```

### Nested Heroes

```dart
Hero(
  tag: 'parent',
  child: Card(
    child: Column(
      children: [
        Hero(
          tag: 'child-image',
          child: Image.asset('image.png'),
        ),
        Hero(
          tag: 'child-title',
          child: Text('Title'),
        ),
      ],
    ),
  ),
)
```

### Hero with Scroll Views

```dart
class ScrollableHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'header-image',
              child: Image.asset('header.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // Content
          ]),
        ),
      ],
    );
  }
}
```
