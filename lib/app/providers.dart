import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_app/features/image_upload/application/image_upload_notifier.dart';

final imageUploadNotifierProvider =
    StateNotifierProvider<ImageUploadNotifier, ImageUploadState>(
  (ref) => ImageUploadNotifier(),
);