import 'package:flutter/material.dart';

/// Hero animation example for shared element transitions
///
/// This example demonstrates:
/// - Basic hero animation with matching tags
/// - Custom PhotoHero widget
/// - Navigation between screens with hero transition
/// - MaterialRectCenterArcTween for aspect ratio preservation

void main() => runApp(const HeroAnimationApp());

class HeroAnimationApp extends StatelessWidget {
  const HeroAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GalleryScreen(),
    );
  }
}

/// Custom hero widget for images
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
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: width,
                  height: width,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Gallery screen showing multiple hero images
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<String> _photos = [
    'images/photo1.png',
    'images/photo2.png',
    'images/photo3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Gallery')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PhotoHero(
              photo: _photos[index],
              width: 100,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => DetailScreen(photo: _photos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Detail screen showing hero image in fullscreen
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
          width: MediaQuery.of(context).size.width - 32,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

/// Example with circular hero (using placeholder instead of asset)
class CircularHeroExample extends StatefulWidget {
  const CircularHeroExample({super.key});

  @override
  State<CircularHeroExample> createState() => _CircularHeroExampleState();
}

class _CircularHeroExampleState extends State<CircularHeroExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular Hero')),
      body: ListView(
        children: List.generate(3, (index) {
          final tag = 'circle-$index';
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: tag,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              CircularDetailScreen(tag: tag, index: index),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CircularDetailScreen extends StatelessWidget {
  const CircularDetailScreen({
    super.key,
    required this.tag,
    required this.index,
  });

  final String tag;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular Detail')),
      body: Center(
        child: Hero(
          tag: tag,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Center(
                  child: Text(
                    'Image $index',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
