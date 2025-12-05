import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cards/trip_card.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final trips = [
      {
        'id': 'TRIP001',
        'date': '2024-01-15',
        'time': '10:30 AM',
        'pickup': '123 Main Street, City Center',
        'drop': '456 Park Avenue, Downtown',
        'fare': 150.00,
        'status': 'completed',
      },
      {
        'id': 'TRIP002',
        'date': '2024-01-15',
        'time': '09:15 AM',
        'pickup': '789 Market Road',
        'drop': '321 Business District',
        'fare': 280.00,
        'status': 'completed',
      },
      {
        'id': 'TRIP003',
        'date': '2024-01-14',
        'time': '08:00 PM',
        'pickup': '555 High Street',
        'drop': '777 Shopping Mall',
        'fare': 120.00,
        'status': 'completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip History'),
      ),
      body: trips.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: theme.brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary,
                  ),
                  const SizedBox(height: AppTheme.spacingLG),
                  Text(
                    'No trips yet',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return TripCard(
                  tripId: trip['id'] as String,
                  date: trip['date'] as String,
                  time: trip['time'] as String,
                  pickupLocation: trip['pickup'] as String,
                  dropLocation: trip['drop'] as String,
                  fare: trip['fare'] as double,
                  status: trip['status'] as String,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/trip-details',
                      arguments: trip,
                    );
                  },
                );
              },
            ),
    );
  }
}
