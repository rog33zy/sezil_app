import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _refreshToken;
  String? _username;
  String? _firstName;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool? _isFieldFinanceAdmin;
  bool? _isSezilMotherTrialFarmer;
  String _crop = 'Maize';

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get username {
    return _username;
  }

  String? get firstName {
    return _firstName;
  }

  bool? get isFieldFinanceAdmin {
    return _isFieldFinanceAdmin;
  }

  bool? get isSourceFieldSupervisor {
    return _isSezilMotherTrialFarmer;
  }

  String get crop {
    return _crop;
  }

  Future<void> _authenticateUser(Map<String, String> userInputsMap,
      {bool isRefreshing = false}) async {
    _token = 'accessToken';
    _refreshToken = 'refreshToken';
    _username = userInputsMap['username'];
    _expiryDate = DateTime(2022);

    if (_username == 'sorghum') {
      _crop = 'Sorghum';
      _firstName = 'SorghumFarmer';
    } else if (_username == 'maize') {
      _crop = 'Maize';
      _firstName = 'MaizeFarmer';
    } else if (_username == 'beans') {
      _crop = 'Beans';
      _firstName = 'BeansFarmer';
    } else if (_username == 'sunflower') {
      _crop = 'Sunflower';
      _firstName = 'SunflowerFarmer';
    } else {
      _crop = 'Maize';
      _firstName = 'MaizeFarmer';
    }
    _autoLogout();

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': _token,
        'refreshToken': _refreshToken,
        'username': _username,
        'firstName': _firstName,
        'expiryDate': _expiryDate!.toIso8601String(),
        'isFieldFinanceAdmin': _isFieldFinanceAdmin,
        'isSourceFieldSupervisor': _isSezilMotherTrialFarmer,
        'crop': _crop,
      },
    );
    prefs.setString(
      'userData',
      userData,
    );
  }

  Future<void> login(Map<String, String> userInputsMap) async {
    return _authenticateUser(userInputsMap);
  }

  Future<void> refreshToken() async {
    return _authenticateUser({"username": ""}, isRefreshing: true);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData = prefs.getString('userData');
    final extractedUserData = json.decode(
      userData!,
    ) as Map<String, dynamic>;

    final expiryDate = DateTime.parse(
      extractedUserData['expiryDate']!,
    );

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _refreshToken = extractedUserData['refreshToken'];
    _username = extractedUserData['username'];
    _firstName = extractedUserData['firstName'];
    _isFieldFinanceAdmin = extractedUserData['isFieldFinanceAdmin'];
    _isSezilMotherTrialFarmer = extractedUserData['isSourceFieldSupervisor'];
    _expiryDate = expiryDate;
    _crop = extractedUserData['crop'];

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _firstName = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inDays;
    _authTimer = Timer(
      Duration(days: timeToExpiry),
      logout,
    );
  }
}
