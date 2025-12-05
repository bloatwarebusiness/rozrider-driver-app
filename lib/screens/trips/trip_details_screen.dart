import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trip = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {
          'id': 'TRIP001',
          'date': '2024-01-15',
          'time': '10:30 AM',
          'pickup': '123 Main Street, City Center',
          'drop': '456 Park Avenue, Downtown',
          'fare': 150.00,
          'status': 'completed',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trip['id'],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingSM,
                            vertical: AppTheme.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                          ),
                          child: Text(
                            trip['status'].toString().toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingLG),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 80,
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
                                trip['pickup'],
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
                                trip['drop'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trip Information',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLG),
                    _InfoRow(
                      label: 'Date',
                      value: trip['date'],
                      theme: theme,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _InfoRow(
                      label: 'Time',
                      value: trip['time'],
                      theme: theme,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _InfoRow(
                      label: 'Distance',
                      value: '5.2 km',
                      theme: theme,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _InfoRow(
                      label: 'Duration',
                      value: '12 min',
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Breakdown',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLG),
                    _PaymentRow(
                      label: 'Base Fare',
                      amount: '₹80',
                      theme: theme,
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    _PaymentRow(
                      label: 'Distance',
                      amount: '₹52',
                      theme: theme,
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    _PaymentRow(
                      label: 'Time',
                      amount: '₹18',
                      theme: theme,
                    ),
                    const Divider(height: AppTheme.spacingLG),
                    _PaymentRow(
                      label: 'Total Earnings',
                      amount: '₹${trip['fare']}',
                      theme: theme,
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _InfoRow({
    Key? key,
    required this.label,
    required this.value,
    required this.theme,
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
            color: isDark
                ? AppTheme.darkTextSecondary
                : AppTheme.lightTextSecondary,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
