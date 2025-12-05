import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';

class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: AppTheme.successColor,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),
              Center(
                child: Text(
                  'Ride Completed!',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingLG),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip Summary',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingLG),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMD),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pickup',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppTheme.darkTextSecondary
                                        : AppTheme.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingXS),
                                Text(
                                  '123 Main Street, City Center',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingMD),
                                Text(
                                  'Drop',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppTheme.darkTextSecondary
                                        : AppTheme.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingXS),
                                Text(
                                  '456 Park Avenue, Downtown',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: AppTheme.spacingXL),
                      _PaymentRow(
                        label: 'Base Fare',
                        amount: '₹80',
                        theme: theme,
                      ),
                      const SizedBox(height: AppTheme.spacingSM),
                      _PaymentRow(
                        label: 'Distance (5.2 km)',
                        amount: '₹52',
                        theme: theme,
                      ),
                      const SizedBox(height: AppTheme.spacingSM),
                      _PaymentRow(
                        label: 'Time (12 min)',
                        amount: '₹18',
                        theme: theme,
                      ),
                      const Divider(height: AppTheme.spacingXL),
                      _PaymentRow(
                        label: 'Total Earnings',
                        amount: '₹150',
                        theme: theme,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),
              PrimaryButton(
                text: 'Rate Rider',
                onPressed: () {
                  Navigator.pushNamed(context, '/rate-rider');
                },
                icon: Icons.star,
              ),
              const SizedBox(height: AppTheme.spacingMD),
              SecondaryButton(
                text: 'Go to Home',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String amount;
  final ThemeData theme;
  final bool isTotal;

  const _PaymentRow({
    Key? key,
    required this.label,
    required this.amount,
    required this.theme,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
          ),
        ),
        Text(
          amount,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal
                ? AppTheme.accentColor
                : (isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary),
          ),
        ),
      ],
    );
  }
}
