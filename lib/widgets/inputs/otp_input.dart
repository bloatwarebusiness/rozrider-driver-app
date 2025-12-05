import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final bool autoFocus;

  const OTPInput({
    Key? key,
    this.length = 6,
    required this.onCompleted,
    this.autoFocus = true,
  }) : super(key: key);

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _otp = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
      _otp.add('');
    }

    if (widget.autoFocus) {
      Future.delayed(const Duration(milliseconds: 120), () {
        if (_focusNodes.isNotEmpty) {
          _focusNodes[0].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      // If user pastes multiple chars, take only last typed digit
      value = value[value.length - 1];
    }

    setState(() {
      _otp[index] = value;
    });

    // Move to next box
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    // Check completion
    if (_otp.every((digit) => digit.isNotEmpty)) {
      widget.onCompleted(_otp.join());
    }
  }

  void _onBackspace(int index) {
    if (_otp[index].isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      _otp[index - 1] = '';
    } else {
      _controllers[index].clear();
      _otp[index] = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.1, // 🔥 Prevents text from getting cut / invisible
              color:
                  isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
            ),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14, // 🔥 FIX: Text stays properly visible
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                borderSide: BorderSide(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                borderSide: BorderSide(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                borderSide: const BorderSide(
                  color: AppTheme.accentColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
            ),
            onChanged: (value) => _onChanged(value, index),
            onTap: () {
              // Places cursor at end
              _controllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: _controllers[index].text.length),
              );
            },
          ),
        ),
      ),
    );
  }
}
