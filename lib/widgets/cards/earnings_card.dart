import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class EarningsCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  const EarningsCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = color ?? (isDark ? AppTheme.darkSurface : AppTheme.lightSurface);
    final textColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final secondaryTextColor =
        isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Card(
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingSM),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.accentColor,
                      size: AppTheme.iconSizeMD,
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: AppTheme.iconSizeXS,
                      color: secondaryTextColor,
                    ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                '₹$amount',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
