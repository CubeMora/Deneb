
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key, required this.imageProvider});

  final String imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExtendedImage.asset(imageProvider)
          ],
        ),   
    ));
  }
}
