import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/UserModel.dart';

class RegisterSezilFarmerProvider with ChangeNotifier {
  String? accessToken;

  set auth(String? token) {
    this.accessToken = token;
    notifyListeners();
  }

  Future<void> registerFarmer(UserModel newUserObject) async {
    final url = Uri.parse('uri');

    final response = await http.post(
      url,
      body: json.encode(
        {
          'first_name': newUserObject.firstName,
          'last_name': newUserObject.lastName,
          'email': newUserObject.email,
          'is_sezil_mother_trial_farmer':
              newUserObject.isSezilMotherTrialFarmer,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      },
    );

    final responseData = json.decode(response.body);

    final username = responseData['user']['username'];

    final url2 = Uri.parse('df');

    await http.post(
      url2,
      body: json.encode(
        {
          'username': username,
          'farmer_id': newUserObject.farmerId,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      },
    );
    notifyListeners();
  }
}
