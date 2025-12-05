import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cards/earnings_card.dart';
import '../../widgets/common/popup_bottom_sheet.dart';
import '../../widgets/buttons/primary_button.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String _selectedPeriod = 'Daily';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Earnings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance),
            onPressed: () {
              Navigator.pushNamed(context, '/withdraw');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: ['Daily', 'Weekly', 'Monthly'].map((period) {
                final isSelected = _selectedPeriod == period;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXS,
                    ),
                    child: ChoiceChip(
                      label: Text(period),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPeriod = period;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            EarningsCard(
              title: 'Today\'s Earnings',
              amount: '2,450.00',
              icon: Icons.today,
              onTap: () {},
            ),
            const SizedBox(height: AppTheme.spacingMD),
            EarningsCard(
              title: 'This Week',
              amount: '15,230.00',
              icon: Icons.date_range,
              onTap: () {},
            ),
            const SizedBox(height: AppTheme.spacingMD),
            EarningsCard(
              title: 'This Month',
              amount: '58,500.00',
              icon: Icons.calendar_month,
              onTap: () {},
            ),
            const SizedBox(height: AppTheme.spacingLG),
            Text(
              'Earnings Chart',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Container(
              height: 200,
              padding: const EdgeInsets.all(AppTheme.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                border: Border.all(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.show_chart,
                      size: 48,
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Text(
                      'Earnings Chart',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            PrimaryButton(
              text: 'Withdraw Earnings',
              onPressed: () {
                Navigator.pushNamed(context, '/withdraw');
              },
              icon: Icons.account_balance_wallet,
            ),
          ],
        ),
      ),
    );
  }
}
