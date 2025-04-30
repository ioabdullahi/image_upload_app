
# Image Upload App

A Flutter application that allows users to upload images from their device gallery or camera and display a preview.

## Features

- 📸 Upload images from gallery or camera
- 🖼️ Preview uploaded images
- 🗑️ Clear uploaded images
- ⚠️ Error handling for permissions and upload failures
- 🎨 Clean and intuitive UI


## Setup Instructions

### Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 2.17.0 or higher)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/image-upload-app.git
   ```

2. Navigate to the project directory
   ```bash
   cd image-upload-app
   ```

3. Install dependencies
   ```bash
   flutter pub get
   ```

4. Run the app
   ```bash
   flutter run
   ```

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_riverpod | ^2.4.9 | State management |
| image_picker | ^1.0.4 | Image selection from gallery/camera |
| permission_handler | ^10.4.0 | Permission management |

## Folder Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── providers.dart
├── features/
│   └── image_upload/
│       ├── presentation/
│       │   ├── widgets/
│       │   │   ├── image_preview.dart
│       │   │   └── upload_button.dart
│       │   └── image_upload_screen.dart
│       └── application/
│           └── image_upload_notifier.dart
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   └── utils/
│       ├── image_picker_utils.dart
│       └── permission_utils.dart
```

## Platform Setup

### Android

Add these permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS

Add these to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>Need camera access to take photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Need photo library access to select photos</string>
<key>NSMicrophoneUsageDescription</key>
<string>Need microphone access for video recording</string>
```

## How to Use

1. Tap the "Gallery" button to select an image from your device gallery
2. Tap the "Camera" button to take a new photo
3. View the selected image in the preview area
4. Tap the "X" button to clear the selected image

## Error Handling

The app handles these error cases:
- Permission denied
- No image selected
- Image picker errors
- General upload failures

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
