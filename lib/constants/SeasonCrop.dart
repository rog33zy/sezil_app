import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SeasonCrop {
  String _crop = 'Maize';

  Future<String> get crop async {
    final prefs = await SharedPreferences.getInstance();

    final userData = prefs.getString('userData');
    final extractedUserData = json.decode(
      userData!,
    ) as Map<String, dynamic>;
    _crop = extractedUserData['crop'];
    return _crop;
  }

}
