import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/otp_input.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String? _phoneNumber;
  String _otp = '';
  bool _isLoading = false;
  int _resendTimer = 60;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      _phoneNumber = args as String;
    }
  }

  void _verifyOTP() {
    if (_otp.length == 6) {
      setState(() {
        _isLoading = true;
      });
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/driver-registration');
        }
      });
    }
  }

  void _resendOTP() {
    if (_resendTimer == 0) {
      setState(() {
        _resendTimer = 60;
        _otp = '';
      });
      _startResendTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP resent successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacingLG),
              Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppTheme.darkTextPrimary
                      : AppTheme.lightTextPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                _phoneNumber != null
                    ? 'We sent a 6-digit code to $_phoneNumber'
                    : 'We sent a 6-digit code to your mobile number',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),
              OTPInput(
                length: 6,
                onCompleted: (otp) {
                  setState(() {
                    _otp = otp;
                  });
                  _verifyOTP();
                },
              ),
              const SizedBox(height: AppTheme.spacingXL),
              Center(
                child: TextButton(
                  onPressed: _resendTimer == 0 ? _resendOTP : null,
                  child: Text(
                    _resendTimer > 0
                        ? 'Resend OTP in $_resendTimer seconds'
                        : 'Resend OTP',
                    style: TextStyle(
                      fontSize: 14,
                      color: _resendTimer == 0
                          ? AppTheme.accentColor
                          : (isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.lightTextSecondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              PrimaryButton(
                text: 'Verify',
                onPressed: _otp.length == 6 ? _verifyOTP : null,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
