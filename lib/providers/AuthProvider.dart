import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../constants/BaseUrls.dart';

import '../models/UserModel.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  String? _username;
  String? _firstName;
  String? _farmerId;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool? _isHRAdmin;
  bool? _isSezilMotherTrialFarmer;
  String _crop = 'Maize';
  UserModel _activeUser = UserModel();

  bool get isAuth {
    return _accessToken != null;
  }

  String? get accessToken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _accessToken != null) {
      return _accessToken;
    }
    return null;
  }

  String? get username {
    return _username;
  }

  String? get firstName {
    return _firstName;
  }

  String? get farmerId {
    return _farmerId;
  }

  bool? get isHRAdmin {
    return _isHRAdmin;
  }

  bool? get isSezilMotherTrialFarmer {
    return _isSezilMotherTrialFarmer;
  }

  String get crop {
    return _crop;
  }

  Future<void> _authenticateUser(UserModel userObject,
      {bool isRefreshing = false}) async {
    // _accessToken = 'accessToken';
    // _refreshToken = 'refreshToken';
    // _username = userObject.username;
    // _expiryDate = DateTime(2022);

    // if (_username == 'sorghum') {
    //   _crop = 'Sorghum';
    //   _firstName = 'SorghumFarmer';
    // } else if (_username == 'maize') {
    //   _crop = 'Maize';
    //   _firstName = 'MaizeFarmer';
    // } else if (_username == 'beans') {
    //   _crop = 'Beans';
    //   _firstName = 'BeansFarmer';
    // } else if (_username == 'sunflower') {
    //   _crop = 'Sunflower';
    //   _firstName = 'SunflowerFarmer';
    // } else {
    //   _crop = 'Maize';
    //   _firstName = 'MaizeFarmer';
    // }
    Uri url;
    if (isRefreshing) {
      url = Uri.parse(
        'https://${BaseUrls.authBaseUrl}/api/authenticate/mobile_get_refresh_token/',
      );
    } else {
      url = Uri.parse(
        'https://${BaseUrls.authBaseUrl}/api/authenticate/mobile_login/',
      );
    }

    try {
      var response;

      if (isRefreshing) {
        response = await http.post(
          url,
          body: json.encode(
            {
              'refresh_token': _refreshToken,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      } else {
        response = await http.post(
          url,
          body: json.encode(
            {
              "username": userObject.username,
              "password": userObject.password,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }

      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];
      final refreshToken = responseData['refresh_token'];
      final expiryDate = responseData['refresh_token_expiry_date'];

      Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

      _accessToken = accessToken;
      _refreshToken = refreshToken;
      _username = payload['user']['username'];
      _firstName = payload['user']['first_name'];
      _expiryDate = DateTime.parse(expiryDate);

      if (payload['user']['is_human_resource_admin'] == null) {
        _isHRAdmin = false;
      } else {
        _isHRAdmin = payload['user']['is_human_resource_admin'];
      }

      if (payload['user']['is_sezil_mother_trial_farmer'] == null) {
        _isSezilMotherTrialFarmer = false;
      } else {
        _isSezilMotherTrialFarmer =
            payload['user']['is_sezil_mother_trial_farmer'];
      }

      if (_isSezilMotherTrialFarmer!) {
        final url2 = Uri.parse(
          'https://${BaseUrls.sezilUrl}/api/accounts/farmer_details/$_username/',
        );

        final response2 = await http.get(
          url2,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $accessToken',
          },
        );
        final response2Data = json.decode(response2.body);
        _farmerId = response2Data['farmer_id'];
        _crop = response2Data['crop'];
      }

      _autoLogout();

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'accessToken': _accessToken,
          'refreshToken': _refreshToken,
          'username': _username,
          'firstName': _firstName,
          'expiryDate': _expiryDate!.toIso8601String(),
          'isHRAdmin': _isHRAdmin,
          'isSourceFieldSupervisor': _isSezilMotherTrialFarmer,
          'crop': _crop,
          'farmerId': _farmerId,
        },
      );
      prefs.setString(
        'userData',
        userData,
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(UserModel userObject) async {
    _activeUser = userObject;
    return _authenticateUser(userObject);
  }

  Future<void> refreshToken() async {
    return _authenticateUser(_activeUser, isRefreshing: true);
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

    _accessToken = extractedUserData['accessToken'];
    _refreshToken = extractedUserData['refreshToken'];
    _username = extractedUserData['username'];
    _firstName = extractedUserData['firstName'];
    _isHRAdmin = extractedUserData['isHRAdmin'];
    _isSezilMotherTrialFarmer = extractedUserData['isSourceFieldSupervisor'];
    _expiryDate = expiryDate;
    _crop = extractedUserData['crop'];
    _farmerId = extractedUserData['farmerId'];

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _accessToken = null;
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
