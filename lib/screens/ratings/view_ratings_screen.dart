import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ViewRatingsScreen extends StatelessWidget {
  const ViewRatingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final ratings = [
      {
        'name': 'Jhon Doe',
        'rating': 5,
        'comment': 'Great driver!',
        'date': '2024-01-15'
      },
      {
        'name': 'Jane Smith',
        'rating': 5,
        'comment': 'Very professional',
        'date': '2024-01-14'
      },
      {
        'name': 'Bob Johnson',
        'rating': 4,
        'comment': 'Good service',
        'date': '2024-01-13'
      },
    ];

    final averageRating = 4.8;
    final totalRatings = 156;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < averageRating.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppTheme.warningColor,
                          size: 24,
                        );
                      }),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    Text(
                      '$totalRatings ratings',
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
            ...ratings.map((rating) => Card(
                  margin: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.person, color: AppTheme.accentColor),
                    ),
                    title: Text(rating['name'] as String),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (rating['rating'] as int)
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 16,
                              color: AppTheme.warningColor,
                            );
                          }),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(rating['comment'] as String),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          rating['date'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
