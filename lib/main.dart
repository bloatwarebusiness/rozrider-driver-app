import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/app_state_provider.dart';

// Auth Screens
import 'screens/auth/splash_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_verification_screen.dart';

// KYC Screens
import 'screens/kyc/driver_registration_screen.dart';
import 'screens/kyc/document_upload_screen.dart';
import 'screens/kyc/kyc_submitted_screen.dart';
import 'screens/kyc/kyc_rejected_screen.dart';

// Main Navigation
import 'screens/main_navigation_screen.dart';

// Home & Rides
import 'screens/rides/ride_accepted_screen.dart';
import 'screens/rides/arrived_pickup_screen.dart';
import 'screens/rides/ride_in_progress_screen.dart';
import 'screens/rides/ride_completed_screen.dart';

// Earnings
import 'screens/earnings/withdraw_screen.dart';
import 'screens/earnings/bank_details_screen.dart';

// Trips
import 'screens/trips/trip_details_screen.dart';

// Profile
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/documents_screen.dart';

// Ratings
import 'screens/ratings/rate_rider_screen.dart';
import 'screens/ratings/view_ratings_screen.dart';

// Settings
import 'screens/settings/settings_screen.dart';

// Support
import 'screens/support/support_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/legal/terms_screen.dart';
import 'screens/permissions/permissions_screen.dart';
import 'screens/chat/chat_screen.dart';

void main() {
  runApp(const RozRiderApp());
}

class RozRiderApp extends StatelessWidget {
  const RozRiderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'RozRider',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: {
              // Auth Routes
              '/': (context) => const SplashScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/otp': (context) => const OTPVerificationScreen(),

              // KYC Routes
              '/driver-registration': (context) =>
                  const DriverRegistrationScreen(),
              '/document-upload': (context) => const DocumentUploadScreen(),
              '/kyc-submitted': (context) => const KYCSubmittedScreen(),
              '/kyc-rejected': (context) => const KYCRejectedScreen(),

              // Main Navigation (Home)
              '/home': (context) => const MainNavigationScreen(),

              // Ride Routes
              '/ride-accepted': (context) => const RideAcceptedScreen(),
              '/arrived-pickup': (context) => const ArrivedPickupScreen(),
              '/ride-in-progress': (context) => const RideInProgressScreen(),
              '/ride-completed': (context) => const RideCompletedScreen(),

              // Earnings Routes
              '/withdraw': (context) => const WithdrawScreen(),
              '/bank-details': (context) => const BankDetailsScreen(),

              // Trip Routes
              '/trip-details': (context) => const TripDetailsScreen(),

              // Profile Routes
              '/edit-profile': (context) => const EditProfileScreen(),
              '/documents': (context) => const DocumentsScreen(),

              // Ratings Routes
              '/rate-rider': (context) => const RateRiderScreen(),
              '/ratings': (context) => const ViewRatingsScreen(),

              // Settings Routes
              '/settings': (context) => const SettingsScreen(),

              // Support Routes
              '/support': (context) => const SupportScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/terms': (context) => const TermsScreen(),
              '/permissions': (context) => const PermissionsScreen(),
              '/chat': (context) => const ChatScreen(),
            },
          );
        },
      ),
    );
  }
}
