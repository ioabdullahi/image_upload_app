import 'package:flutter/material.dart';
import 'package:image_upload_app/features/image_upload/presentation/image_upload_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageUploadScreen(),
    );
  }
}