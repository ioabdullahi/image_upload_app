import 'package:flutter/material.dart';

class UploadButtons extends StatelessWidget {
  final VoidCallback onGalleryPressed;
  final VoidCallback onCameraPressed;

  const UploadButtons({
    super.key,
    required this.onGalleryPressed,
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Gallery'),
            onPressed: onGalleryPressed,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Camera'),
            onPressed: onCameraPressed,
          ),
        ),
      ],
    );
  }
}