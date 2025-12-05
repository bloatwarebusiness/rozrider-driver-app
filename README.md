# RozRider - Driver Ride Application

A complete Flutter application UI for drivers, similar to Uber and Ola, with a clean, professional, and modern design.

## Features

### Authentication & KYC
- Splash Screen
- Onboarding (3 screens)
- Mobile Login & OTP Verification
- Driver Registration Form
- Document Upload (DL, Aadhar, PAN, RC)
- Profile Photo Upload
- KYC Verification Status (Submitted/Rejected)

### Home & Ride Management
- Driver Home Dashboard with Map View
- Online/Offline Status Toggle
- Incoming Ride Popup with Details
- Slide-to-Accept Ride Button (Uber style)
- Ride Accepted Route Navigation
- Arrived Pickup Confirmation
- OTP or Manual Pickup Confirmation
- Ride In Progress with Live Route
- Ride Completed Summary & Payment Breakdown

### Earnings & Trips
- Wallet/Earnings Dashboard
- Daily/Weekly/Monthly Earnings
- Withdraw to Bank
- Add/Manage Bank Details
- Trip History List
- Trip Details Page

### Driver Experience
- Rate Rider
- View Ratings Received
- Notification Center
- Chat/Call Rider UI
- Support & Help Center
- SOS Emergency Button

### Profile & Settings
- Driver Profile View & Edit
- Document Review & Replace
- Permission Request Screens
- Terms & Privacy Policy
- Theme Settings: Light/Dark Mode Toggle
- App Logout

## Project Structure

```
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
├── providers/
│   ├── theme_provider.dart
│   └── app_state_provider.dart
├── widgets/
│   ├── buttons/
│   │   ├── primary_button.dart
│   │   ├── secondary_button.dart
│   │   └── slide_to_accept_button.dart
│   ├── inputs/
│   │   ├── custom_text_field.dart
│   │   ├── otp_input.dart
│   │   └── document_upload_widget.dart
│   ├── cards/
│   │   ├── trip_card.dart
│   │   └── earnings_card.dart
│   ├── navigation/
│   │   └── bottom_nav_bar.dart
│   ├── alerts/
│   │   └── state_alert.dart
│   └── common/
│       ├── notification_badge.dart
│       └── popup_bottom_sheet.dart
└── screens/
    ├── auth/
    ├── kyc/
    ├── home/
    ├── rides/
    ├── earnings/
    ├── trips/
    ├── profile/
    ├── ratings/
    ├── settings/
    ├── support/
    ├── notifications/
    ├── legal/
    ├── permissions/
    └── chat/
```

## Theme Configuration

The app includes a comprehensive theme system with:
- Light and Dark themes
- Consistent color palette
- Global spacing tokens
- Typography styles
- Border radius constants
- Icon sizes

## State Management

- **Provider** for theme switching and app state management
- Theme preference persists using SharedPreferences

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## Design Principles

- Clean, minimal, and professional design
- Flat colors with subtle shadows
- No glassmorphism effects
- Structured spacing and typography
- Consistent component styling
- Responsive layout

## Dependencies

- `provider` - State management
- `shared_preferences` - Theme persistence
- `google_maps_flutter` - Real Google Maps integration
- `geolocator` - Location services
- `image_picker` - Camera and gallery access
- `file_picker` - Document file selection
- `permission_handler` - Runtime permissions
- `fl_chart` - Charts for earnings

## Setup Instructions

### Google Maps Setup

**IMPORTANT:** You need to configure Google Maps API keys before running the app. See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions.

Quick setup:
1. Get your Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Enable required APIs (Maps SDK for Android/iOS, Directions API, etc.)
3. Add API key to Android and iOS configuration files
4. See `SETUP_GUIDE.md` for complete instructions

### Permissions

The app requests the following permissions at runtime:
- Location (for maps and navigation)
- Camera (for document photos)
- Storage (for document uploads)

All permissions are handled automatically by the app.

## Features Implemented

✅ **Real Google Maps Integration**
- Interactive maps with current location
- Markers for pickup/drop locations
- Route polylines for navigation
- Real-time location updates

✅ **Actual Document Upload**
- Camera capture for documents
- Gallery selection
- File picker for PDFs and images
- Image preview in upload widgets
- File validation and error handling

✅ **Location Services**
- Current location detection
- Permission handling
- Location accuracy settings

## Notes

- Maps require a valid Google Maps API key (see SETUP_GUIDE.md)
- Document uploads work with real files (camera/gallery/file picker)
- Location services require device permissions
- All ride/earnings data is still mock data (backend integration needed)


