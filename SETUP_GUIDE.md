# RozRider Setup Guide

## Google Maps Integration

### Step 1: Get Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API
   - Directions API
   - Geocoding API
4. Create credentials (API Key)
5. Copy your API key

### Step 2: Configure Android

1. Open `android/app/src/main/AndroidManifest.xml`
2. Add the following inside the `<application>` tag:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
```

### Step 3: Configure iOS

1. Open `ios/Runner/AppDelegate.swift`
2. Add the following import at the top:

```swift
import GoogleMaps
```

3. In the `application` method, add:

```swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
```

4. Open `ios/Runner/AppDelegate.m` (if using Objective-C)
5. Add the import:

```objc
#import "GoogleMaps/GoogleMaps.h"
```

6. In the `application` method, add:

```objc
[GMSServices provideAPIKey:@"YOUR_GOOGLE_MAPS_API_KEY_HERE"];
```

### Step 4: Restrict API Key (Optional but Recommended)

1. In Google Cloud Console, go to APIs & Services > Credentials
2. Click on your API key
3. Under "Application restrictions", select:
   - Android apps (for Android)
   - iOS apps (for iOS)
4. Add your app's package name and SHA-1 certificate fingerprint

## Permissions Setup

### Android

1. Open `android/app/src/main/AndroidManifest.xml`
2. Add the following permissions inside `<manifest>`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS

1. Open `ios/Runner/Info.plist`
2. Add the following keys:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show you on the map and find nearby rides</string>

<key>NSLocationAlwaysUsageDescription</key>
<string>We need your location to show you on the map and find nearby rides</string>

<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos for document verification</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to upload documents</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need photo library access to save documents</string>
```

## Document Upload Setup

The app uses the following packages for file handling:
- `image_picker` - For camera and gallery access
- `file_picker` - For document file selection
- `permission_handler` - For runtime permissions

All permissions are requested at runtime. The app will prompt users when needed.

## Installation Steps

1. Install dependencies:
```bash
flutter pub get
```

2. Add your Google Maps API key to the configuration files above

3. Run the app:
```bash
flutter run
```

## Troubleshooting

### Maps Not Showing
- Verify your API key is correctly added
- Check that the required APIs are enabled in Google Cloud Console
- For Android, ensure your SHA-1 fingerprint is added to API key restrictions
- Check logs for any API key errors

### Permission Issues
- Ensure permissions are added to AndroidManifest.xml and Info.plist
- On Android 6.0+, permissions are requested at runtime
- Check that location services are enabled on the device

### Document Upload Issues
- Verify camera/storage permissions are granted
- On Android 11+, you may need to use scoped storage
- Check file size limits

## Production Checklist

- [ ] Replace API key placeholders with production keys
- [ ] Restrict API keys by application
- [ ] Set up API key billing alerts in Google Cloud Console
- [ ] Test all permissions on physical devices
- [ ] Verify maps work on both Android and iOS
- [ ] Test document upload on both platforms
- [ ] Review and update permission descriptions
- [ ] Set up error monitoring for API failures
