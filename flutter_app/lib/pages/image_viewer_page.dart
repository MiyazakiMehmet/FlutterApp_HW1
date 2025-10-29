import 'package:flutter/material.dart';

class ImageViewerPage extends StatelessWidget {
  static const routeName = '/image-viewer';
  const ImageViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final path = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Görsel')),
      body: Center(
        child: Hero(
          tag: path,
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 5,
            child: Image.asset(path, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
