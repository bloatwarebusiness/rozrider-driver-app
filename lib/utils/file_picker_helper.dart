import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      // image_picker handles permissions internally, but we can request them explicitly
      // For Android 13+ use photos permission, for older versions it's handled automatically
      if (Platform.isAndroid) {
        try {
          // Try photos permission for Android 13+
          final photosPermission = await Permission.photos.status;
          if (photosPermission.isDenied) {
            await Permission.photos.request();
          }
        } catch (e) {
          // Fallback - image_picker will handle permissions
          debugPrint('Photos permission check failed: $e');
        }
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      return null;
    }
  }

  /// Take a photo with camera
  static Future<File?> pickImageFromCamera() async {
    try {
      // Request permission
      final permission = await Permission.camera.request();
      if (permission.isDenied || permission.isPermanentlyDenied) {
        if (permission.isPermanentlyDenied) {
          await openAppSettings();
        }
        return null;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error taking photo: $e');
      return null;
    }
  }

  /// Show dialog to choose between camera and gallery
  static Future<File?> pickImageWithDialog(BuildContext context) async {
    final source = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                subtitle: const Text('Take a new photo'),
                onTap: () => Navigator.pop(context, 'camera'),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                subtitle: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(context, 'gallery'),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return null;

    if (source == 'camera') {
      return await pickImageFromCamera();
    } else if (source == 'gallery') {
      return await pickImageFromGallery();
    }

    return null;
  }

  /// Pick a document file (using image picker for photos of documents)
  static Future<File?> pickDocument() async {
    try {
      // For documents, use image picker to select photo of document from gallery
      // This is the common use case - users take photos of their documents
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking document: $e');
      return null;
    }
  }

  /// Check and request storage permission
  static Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        final result = await Permission.storage.request();
        return result.isGranted;
      }
      return status.isGranted;
    }
    // iOS doesn't require explicit storage permission for gallery access
    return true;
  }

  /// Get file size in human-readable format
  static String getFileSizeString(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  /// Get file extension from path
  static String getFileExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  /// Check if file is an image
  static bool isImageFile(String path) {
    final extension = getFileExtension(path);
    return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
  }

  /// Check if file is a PDF
  static bool isPdfFile(String path) {
    return getFileExtension(path) == 'pdf';
  }
}
