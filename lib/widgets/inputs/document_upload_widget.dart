import 'dart:io';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DocumentUploadWidget extends StatelessWidget {
  final String label;
  final String? documentName;
  final File? file;
  final VoidCallback onUpload;
  final VoidCallback? onRemove;
  final IconData icon;
  final bool isImage;

  const DocumentUploadWidget({
    Key? key,
    required this.label,
    this.documentName,
    this.file,
    required this.onUpload,
    this.onRemove,
    this.icon = Icons.upload_file,
    this.isImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final secondaryTextColor =
        isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return GestureDetector(
      onTap: (documentName == null && file == null) ? onUpload : null,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          border: Border.all(color: AppTheme.primaryColor, width: 2),
        ),
        child: (documentName == null && file == null)
            ? Column(
                children: [
                  Icon(
                    icon,
                    size: AppTheme.iconSizeXL,
                    color: secondaryTextColor,
                  ),
                  const SizedBox(height: AppTheme.spacingSM),
                  Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    'Tap to upload',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              )
            : (file != null && isImage)
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                        child: Image.file(
                          file!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: surfaceColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: AppTheme.iconSizeXL,
                                    color: secondaryTextColor,
                                  ),
                                  const SizedBox(height: AppTheme.spacingSM),
                                  Text(
                                    'Error loading image',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: AppTheme.spacingSM,
                        right: AppTheme.spacingSM,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: onRemove,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: AppTheme.spacingSM,
                        left: AppTheme.spacingSM,
                        right: AppTheme.spacingSM,
                        child: Container(
                          padding: const EdgeInsets.all(AppTheme.spacingSM),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                          ),
                          child: Text(
                            label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      file != null && isImage
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusSM),
                              child: Image.file(
                                file!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.description,
                                    size: AppTheme.iconSizeMD,
                                    color: AppTheme.accentColor,
                                  );
                                },
                              ),
                            )
                          : Icon(
                              Icons.description,
                              size: AppTheme.iconSizeMD,
                              color: AppTheme.accentColor,
                            ),
                      const SizedBox(width: AppTheme.spacingMD),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: secondaryTextColor,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingXS),
                            Text(
                              documentName ?? file?.path.split('/').last ?? 'Unknown',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (onRemove != null)
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: onRemove,
                          color: AppTheme.errorColor,
                        ),
                    ],
                  ),
      ),
    );
  }
}
