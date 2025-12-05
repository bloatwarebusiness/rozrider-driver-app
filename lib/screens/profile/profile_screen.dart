import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://res.cloudinary.com/dv3gmxtuw/image/upload/v1764872206/pvhuo7ijbnpojs3ipmfm.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),
                  Text(
                    'Jhon Doe',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    '+91 96XXXXX888',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSM),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMD,
                      vertical: AppTheme.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified,
                          size: 16,
                          color: AppTheme.successColor,
                        ),
                        const SizedBox(width: AppTheme.spacingXS),
                        Text(
                          'Verified Driver',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            _ProfileMenuItem(
              icon: Icons.document_scanner,
              title: 'Documents',
              subtitle: 'View and manage documents',
              onTap: () {
                Navigator.pushNamed(context, '/documents');
              },
            ),
            _ProfileMenuItem(
              icon: Icons.star,
              title: 'Ratings',
              subtitle: 'View your ratings',
              onTap: () {
                Navigator.pushNamed(context, '/ratings');
              },
            ),
            _ProfileMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'App settings and preferences',
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            _ProfileMenuItem(
              icon: Icons.help_center,
              title: 'Help & Support',
              subtitle: 'Get help and contact support',
              onTap: () {
                Navigator.pushNamed(context, '/support');
              },
            ),
            _ProfileMenuItem(
              icon: Icons.description,
              title: 'Terms & Privacy',
              subtitle: 'Terms of service and privacy policy',
              onTap: () {
                Navigator.pushNamed(context, '/terms');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMD),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSM),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSM),
          ),
          child: Icon(icon, color: AppTheme.accentColor),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color:
              isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
