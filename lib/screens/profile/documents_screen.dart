import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/inputs/document_upload_widget.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Documents',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              'Keep your documents updated and verified',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            DocumentUploadWidget(
              label: 'Driving License',
              documentName: 'driving_license.pdf',
              onUpload: () {},
              onRemove: () {},
              icon: Icons.credit_card,
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'Aadhar Card',
              documentName: 'aadhar_card.pdf',
              onUpload: () {},
              onRemove: () {},
              icon: Icons.badge,
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'PAN Card',
              documentName: 'pan_card.pdf',
              onUpload: () {},
              onRemove: () {},
              icon: Icons.description,
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'RC Document',
              documentName: 'rc_document.pdf',
              onUpload: () {},
              onRemove: () {},
              icon: Icons.description_outlined,
            ),
            const SizedBox(height: AppTheme.spacingMD),
            DocumentUploadWidget(
              label: 'Profile Photo',
              documentName: 'profile_photo.jpg',
              onUpload: () {},
              onRemove: () {},
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
