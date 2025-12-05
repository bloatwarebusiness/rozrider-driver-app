import 'package:flutter/material.dart';

class AppStateProvider with ChangeNotifier {
  bool _isDriverOnline = false;
  bool _isKycVerified = false;
  bool _isLoggedIn = false;
  String? _currentRideId;

  bool get isDriverOnline => _isDriverOnline;
  bool get isKycVerified => _isKycVerified;
  bool get isLoggedIn => _isLoggedIn;
  String? get currentRideId => _currentRideId;

  void setDriverOnline(bool value) {
    _isDriverOnline = value;
    notifyListeners();
  }

  void setKycVerified(bool value) {
    _isKycVerified = value;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setCurrentRideId(String? rideId) {
    _currentRideId = rideId;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _isDriverOnline = false;
    _currentRideId = null;
    notifyListeners();
  }
}
