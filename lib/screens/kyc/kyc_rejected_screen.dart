import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/alerts/state_alert.dart';

class KYCRejectedScreen extends StatelessWidget {
  const KYCRejectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Status'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cancel,
                size: 64,
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'KYC Verification Failed',
              style: theme.textTheme.displayMedium?.copyWith(
                color: isDark
                    ? AppTheme.darkTextPrimary
                    : AppTheme.lightTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              'Your documents could not be verified. Please review the issues below and re-upload your documents.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXL),
            const StateAlert(
              type: AlertType.error,
              message: 'Driving License photo is unclear',
            ),
            const SizedBox(height: AppTheme.spacingMD),
            const StateAlert(
              type: AlertType.error,
              message: 'Aadhar card details do not match',
            ),
            const SizedBox(height: AppTheme.spacingMD),
            const StateAlert(
              type: AlertType.warning,
              message: 'PAN card document is expired',
            ),
            const SizedBox(height: AppTheme.spacingXL),
            PrimaryButton(
              text: 'Re-upload Documents',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/document-upload');
              },
              icon: Icons.upload_file,
            ),
          ],
        ),
      ),
    );
  }
}
