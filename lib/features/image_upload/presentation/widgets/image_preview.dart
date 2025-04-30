import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onClear;

  const ImagePreview({
    super.key,
    required this.imageFile,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageFile != null)
            Expanded(
              child: Stack(
                children: [
                  Image.file(imageFile!),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: onClear,
                    ),
                  ),
                ],
              ),
            )
          else
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 100, color: Colors.grey),
                  Text('No image selected'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}