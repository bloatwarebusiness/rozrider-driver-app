import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/custom_text_field.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();
  final _bankNameController = TextEditingController();
  final List<Map<String, String>> _banks = [
    {
      'name': 'HDFC Bank',
      'account': '1234567890',
      'ifsc': 'HDFC0001234',
      'last4': '1234',
    },
  ];

  void _addBank() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _banks.add({
          'name': _bankNameController.text,
          'account': _accountNumberController.text,
          'ifsc': _ifscController.text,
          'last4': _accountNumberController.text.length >= 4
              ? _accountNumberController.text.substring(
                  _accountNumberController.text.length - 4)
              : '',
        });
      });
      _accountNameController.clear();
      _accountNumberController.clear();
      _ifscController.clear();
      _bankNameController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bank account added successfully'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  void _showAddBankDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Bank Account'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  label: 'Account Holder Name',
                  controller: _accountNameController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                CustomTextField(
                  label: 'Bank Name',
                  controller: _bankNameController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                CustomTextField(
                  label: 'Account Number',
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                CustomTextField(
                  label: 'IFSC Code',
                  controller: _ifscController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            text: 'Add',
            onPressed: _addBank,
            width: 100,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Accounts'),
      ),
      body: _banks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_balance, size: 64),
                  const SizedBox(height: AppTheme.spacingLG),
                  Text(
                    'No bank accounts added',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppTheme.spacingMD),
                  PrimaryButton(
                    text: 'Add Bank Account',
                    onPressed: _showAddBankDialog,
                    icon: Icons.add,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingMD),
              itemCount: _banks.length + 1,
              itemBuilder: (context, index) {
                if (index == _banks.length) {
                  return Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMD),
                    child: OutlinedButton.icon(
                      onPressed: _showAddBankDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Bank Account'),
                    ),
                  );
                }
                final bank = _banks[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_balance,
                        color: AppTheme.accentColor),
                    title: Text('${bank['name']} - ****${bank['last4']}'),
                    subtitle: Text('IFSC: ${bank['ifsc']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: AppTheme.errorColor),
                      onPressed: () {
                        setState(() {
                          _banks.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: _banks.isNotEmpty
          ? FloatingActionButton(
              onPressed: _showAddBankDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
