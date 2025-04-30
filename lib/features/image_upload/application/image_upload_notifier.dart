import 'dart:io';

import 'package:flutter/material.dart';
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
      // Request permissions
      final hasPermission = source == ImageSource.camera
          ? await PermissionUtils.requestCameraPermission()
          : await PermissionUtils.requestPhotosPermission();

      if (!hasPermission) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Please grant permission in app settings',
        );
        return;
      }

      final XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      // User cancelled the picker
      if (pickedFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      // Verify the file exists
      final file = File(pickedFile.path);
      if (!await file.exists()) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Selected image cannot be accessed',
        );
        return;
      }

      state = state.copyWith(
        imageFile: file,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to select image. Please try again.',
      );
    }
  }

  void clearImage() {
    state = ImageUploadState();
  }
}