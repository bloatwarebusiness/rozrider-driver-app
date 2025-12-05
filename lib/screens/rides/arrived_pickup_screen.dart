import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/otp_input.dart';

class ArrivedPickupScreen extends StatefulWidget {
  const ArrivedPickupScreen({Key? key}) : super(key: key);

  @override
  State<ArrivedPickupScreen> createState() => _ArrivedPickupScreenState();
}

class _ArrivedPickupScreenState extends State<ArrivedPickupScreen> {
  String _otp = '';
  bool _useOTP = true;

  void _confirmPickup() {
    if (_useOTP && _otp.length == 6) {
      Navigator.pushNamed(context, '/ride-in-progress');
    } else if (!_useOTP) {
      Navigator.pushNamed(context, '/ride-in-progress');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Confirm Pickup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingLG),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppTheme.successColor,
                    size: AppTheme.iconSizeLG,
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You\'ve arrived at pickup location',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          '123 Main Street, City Center',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              'Confirm Pickup',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Use OTP'),
                    selected: _useOTP,
                    onSelected: (selected) {
                      setState(() {
                        _useOTP = selected;
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Confirm Manually'),
                    selected: !_useOTP,
                    onSelected: (selected) {
                      setState(() {
                        _useOTP = !selected;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXL),
            if (_useOTP) ...[
              Text(
                'Enter OTP from Rider',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacingMD),
              OTPInput(
                length: 4,
                onCompleted: (otp) {
                  setState(() {
                    _otp = otp;
                  });
                },
              ),
              const SizedBox(height: AppTheme.spacingMD),
              Text(
                'Ask rider for 4-digit OTP',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.lightTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                'Tap the button below to confirm that you\'ve picked up the rider',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.lightTextSecondary,
                ),
              ),
            ],
            const SizedBox(height: AppTheme.spacingXL),
            PrimaryButton(
              text: 'Start Ride',
              onPressed: _useOTP && _otp.length == 4
                  ? _confirmPickup
                  : !_useOTP
                      ? _confirmPickup
                      : null,
              icon: Icons.play_arrow,
            ),
          ],
        ),
      ),
    );
  }
}
