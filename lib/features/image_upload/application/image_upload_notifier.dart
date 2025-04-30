import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_app/core/utils/image_picker_utils.dart';
import 'package:image_upload_app/core/utils/permission_utils.dart';

class ImageUploadState {
  final File? imageFile;
  final String? errorMessage;
  final bool isLoading;

  ImageUploadState({
    this.imageFile,
    this.errorMessage,
    this.isLoading = false,
  });

  ImageUploadState copyWith({
    File? imageFile,
    String? errorMessage,
    bool? isLoading,
  }) {
    return ImageUploadState(
      imageFile: imageFile ?? this.imageFile,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ImageUploadNotifier extends StateNotifier<ImageUploadState> {
  ImageUploadNotifier() : super(ImageUploadState());

  Future<void> uploadImage(ImageSource source) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final hasPermission = source == ImageSource.camera
          ? await PermissionUtils.requestCameraPermission()
          : await PermissionUtils.requestPhotosPermission();

      if (!hasPermission) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Permission denied',
        );
        return;
      }

      final XFile? pickedFile = source == ImageSource.camera
          ? await ImagePickerUtils.captureFromCamera()
          : await ImagePickerUtils.pickFromGallery();

      if (pickedFile == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No image selected',
        );
        return;
      }

      state = state.copyWith(
        imageFile: File(pickedFile.path),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to upload image: ${e.toString()}',
      );
    }
  }

  void clearImage() {
    state = ImageUploadState();
  }
}