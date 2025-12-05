import 'dart:io';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/document_upload_widget.dart';
import '../../utils/file_picker_helper.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _dlDocument;
  File? _aadharDocument;
  File? _panDocument;
  File? _rcDocument;
  File? _profilePhoto;

  Future<void> _uploadDocument(String type) async {
    try {
      File? selectedFile;

      // For profile photo, use image picker
      if (type == 'Profile') {
        selectedFile = await FilePickerHelper.pickImageWithDialog(context);
        if (selectedFile == null && mounted) {
          // User cancelled or error occurred
          return;
        }
      } else {
        // For documents, show dialog to choose between camera and gallery
        final source = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Upload ${type == 'DL' ? 'Driving License' : type}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take Photo'),
                  subtitle: const Text('Capture document with camera'),
                  onTap: () => Navigator.pop(context, 'camera'),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  subtitle: const Text('Select photo of document'),
                  onTap: () => Navigator.pop(context, 'gallery'),
                ),
              ],
            ),
          ),
        );

        if (source == null) return;

        if (source == 'camera') {
          selectedFile = await FilePickerHelper.pickImageFromCamera();
        } else if (source == 'gallery') {
          selectedFile = await FilePickerHelper.pickImageFromGallery();
        }
      }

      if (selectedFile != null && mounted) {
        setState(() {
          switch (type) {
            case 'DL':
              _dlDocument = selectedFile;
              break;
            case 'Aadhar':
              _aadharDocument = selectedFile;
              break;
            case 'PAN':
              _panDocument = selectedFile;
              break;
            case 'RC':
              _rcDocument = selectedFile;
              break;
            case 'Profile':
              _profilePhoto = selectedFile;
              break;
          }
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${type == 'DL' ? 'Driving License' : type} uploaded successfully'),
              backgroundColor: AppTheme.successColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading file: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _removeDocument(String type) {
    setState(() {
      switch (type) {
        case 'DL':
          _dlDocument = null;
          break;
        case 'Aadhar':
          _aadharDocument = null;
          break;
        case 'PAN':
          _panDocument = null;
          break;
        case 'RC':
          _rcDocument = null;
          break;
        case 'Profile':
          _profilePhoto = null;
          break;
      }
    });
  }

  bool _allDocumentsUploaded() {
    return _dlDocument != null &&
        _aadharDocument != null &&
        _panDocument != null &&
        _rcDocument != null &&
        _profilePhoto != null;
  }

  String? _getFileName(File? file) {
    if (file == null) return null;
    return file.path.split('/').last;
  }

  void _submitDocuments() {
    if (_allDocumentsUploaded()) {
      Navigator.pushNamed(context, '/kyc-submitted');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload all documents'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMD,
          vertical: AppTheme.spacingLG,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Upload Required Documents',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              'Please upload clear photos of all documents',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Profile Photo',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'Upload Profile Photo',
              documentName: _getFileName(_profilePhoto),
              file: _profilePhoto,
              onUpload: () => _uploadDocument('Profile'),
              onRemove: _profilePhoto != null
                  ? () => _removeDocument('Profile')
                  : null,
              icon: Icons.person,
              isImage: true,
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Identity Documents',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'Driving License',
              documentName: _getFileName(_dlDocument),
              file: _dlDocument,
              onUpload: () => _uploadDocument('DL'),
              onRemove:
                  _dlDocument != null ? () => _removeDocument('DL') : null,
              icon: Icons.credit_card,
              isImage: FilePickerHelper.isImageFile(_dlDocument?.path ?? ''),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'Aadhar Card',
              documentName: _getFileName(_aadharDocument),
              file: _aadharDocument,
              onUpload: () => _uploadDocument('Aadhar'),
              onRemove: _aadharDocument != null
                  ? () => _removeDocument('Aadhar')
                  : null,
              icon: Icons.badge,
              isImage: FilePickerHelper.isImageFile(_aadharDocument?.path ?? ''),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'PAN Card',
              documentName: _getFileName(_panDocument),
              file: _panDocument,
              onUpload: () => _uploadDocument('PAN'),
              onRemove:
                  _panDocument != null ? () => _removeDocument('PAN') : null,
              icon: Icons.description,
              isImage: FilePickerHelper.isImageFile(_panDocument?.path ?? ''),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Vehicle Documents',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'RC Document',
              documentName: _getFileName(_rcDocument),
              file: _rcDocument,
              onUpload: () => _uploadDocument('RC'),
              onRemove:
                  _rcDocument != null ? () => _removeDocument('RC') : null,
              icon: Icons.description_outlined,
              isImage: FilePickerHelper.isImageFile(_rcDocument?.path ?? ''),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            PrimaryButton(
              text: 'Submit for Verification',
              onPressed: _submitDocuments,
            ),
          ],
        ),
      ),
    );
  }
}
