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
    final maxHeight = MediaQuery.of(context).size.height * 0.5; // Limit height to 50% of screen

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Added scroll for overflow protection
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important for scroll
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
                      color: AppColors.primary.withOpacity(0.9),
                    ),
              ),
              const SizedBox(height: 24),
              
              // Constrained image container
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxHeight, // Set maximum height
                ),
                child: AspectRatio(
                  aspectRatio: 3/4, // Default ratio
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
              ),
              
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
    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            imageFile,
            fit: BoxFit.contain, // Maintain aspect ratio
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.black54,
                  child: const Text(
                    'Tap to Change Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}