import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/custom_text_field.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _selectedBank = 'HDFC Bank - ****1234';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final availableBalance = 58450.00;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Earnings'),
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
                  children: [
                    Text(
                      'Available Balance',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    Text(
                      '₹${availableBalance.toStringAsFixed(2)}',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Withdraw Amount',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            CustomTextField(
              label: 'Amount',
              hint: 'Enter amount to withdraw',
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(AppTheme.spacingMD),
                child: Text('₹'),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _amountController.text = (availableBalance * 0.25)
                          .toStringAsFixed(0);
                    },
                    child: const Text('25%'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSM),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _amountController.text = (availableBalance * 0.5)
                          .toStringAsFixed(0);
                    },
                    child: const Text('50%'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSM),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _amountController.text = (availableBalance * 0.75)
                          .toStringAsFixed(0);
                    },
                    child: const Text('75%'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSM),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _amountController.text = availableBalance.toStringAsFixed(0);
                    },
                    child: const Text('All'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Select Bank Account',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance, color: AppTheme.accentColor),
                title: Text(_selectedBank),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/bank-details');
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/bank-details');
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Bank Account'),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            PrimaryButton(
              text: 'Withdraw',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Withdrawal request submitted'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
                Navigator.pop(context);
              },
              icon: Icons.account_balance_wallet,
            ),
          ],
        ),
      ),
    );
  }
}
