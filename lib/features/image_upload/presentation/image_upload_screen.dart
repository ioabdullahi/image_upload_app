import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_app/app/providers.dart';
import 'package:image_upload_app/core/constants/app_colors.dart';
import 'package:image_upload_app/features/image_upload/presentation/widgets/dotted_border.dart';

class ImageUploadScreen extends ConsumerWidget {
  const ImageUploadScreen({super.key});

  Future<void> _pickImage(ImageSource source, WidgetRef ref) async {
    final notifier = ref.read(imageUploadNotifierProvider.notifier);
    await notifier.uploadImage(source);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageUploadNotifierProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            Text(
              'Upload Your Image',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose an image from gallery or take a new photo',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 24),
            
            // Dynamic content area
            AspectRatio(
              aspectRatio: 4/3, // Standard image ratio (can adjust to 1/1 for square)
              child: state.imageFile != null
                  ? _UploadedState(
                      imageFile: state.imageFile!,
                      onTap: () => _pickImage(ImageSource.gallery, ref),
                    )
                  : DottedBorderWidget(
                      onTap: () => _pickImage(ImageSource.gallery, ref),
                      text: "Upload Image",
                    ),
            ),
            
            // Error message (if any)
            if (state.errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () => _pickImage(ImageSource.gallery, ref),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () => _pickImage(ImageSource.camera, ref),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadedState extends StatelessWidget {
  final File imageFile;
  final VoidCallback onTap;

  const _UploadedState({
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primaryLight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.broken_image, size: 36, color: AppColors.error),
                    const SizedBox(height: 8),
                    Text(
                      'Could not load image',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}