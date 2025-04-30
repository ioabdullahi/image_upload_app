import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_app/app/providers.dart';
import 'package:image_upload_app/features/image_upload/presentation/widgets/image_preview.dart';
import 'package:image_upload_app/features/image_upload/presentation/widgets/upload_button.dart';

class ImageUploadScreen extends ConsumerWidget {
  const ImageUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageUploadNotifierProvider);
    final notifier = ref.read(imageUploadNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.isLoading)
              const CircularProgressIndicator()
            else if (state.errorMessage != null)
              Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: ImagePreview(
                imageFile: state.imageFile,
                onClear: () => notifier.clearImage(),
              ),
            ),
            const SizedBox(height: 20),
            UploadButtons(
              onGalleryPressed: () => notifier.uploadImage(ImageSource.gallery),
              onCameraPressed: () => notifier.uploadImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }
}