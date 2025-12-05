import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum AlertType { success, warning, error, info }

class StateAlert extends StatelessWidget {
  final AlertType type;
  final String message;
  final IconData? icon;
  final VoidCallback? onClose;

  const StateAlert({
    Key? key,
    required this.type,
    required this.message,
    this.icon,
    this.onClose,
  }) : super(key: key);

  Color _getColor() {
    switch (type) {
      case AlertType.success:
        return AppTheme.successColor;
      case AlertType.warning:
        return AppTheme.warningColor;
      case AlertType.error:
        return AppTheme.errorColor;
      case AlertType.info:
        return AppTheme.accentColor;
    }
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.error:
        return Icons.error;
      case AlertType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor();
    final alertIcon = icon ?? _getDefaultIcon();

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            alertIcon,
            color: color,
            size: AppTheme.iconSizeMD,
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close, size: AppTheme.iconSizeSM),
              color: color,
              onPressed: onClose,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
