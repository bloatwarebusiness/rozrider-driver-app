import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/alerts/state_alert.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StateAlert(
              type: AlertType.info,
              message: 'SOS Emergency: Press and hold the SOS button for immediate help',
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                border: Border.all(
                  color: AppTheme.errorColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppTheme.errorColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),
                  Text(
                    'SOS Emergency',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    'Hold for 3 seconds',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Get Help',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: AppTheme.accentColor),
                title: const Text('Call Support'),
                subtitle: const Text('+91 1800-XXX-XXXX'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: AppTheme.accentColor),
                title: const Text('Email Support'),
                subtitle: const Text('support@rozrider.com'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.chat, color: AppTheme.accentColor),
                title: const Text('Live Chat'),
                subtitle: const Text('Chat with our support team'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/chat');
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'FAQs',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            ...List.generate(3, (index) => Card(
                  margin: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                  child: ExpansionTile(
                    title: Text('FAQ Question ${index + 1}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingMD),
                        child: Text(
                          'FAQ Answer ${index + 1}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
