import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  final SharedPreferences _prefs;

  UserDataManager(this._prefs);

  // Save user data
  Future<void> saveUserData(String userId, Map<String, dynamic> userData) async {
    await _prefs.setString('user_$userId', jsonEncode(userData));
  }

  // Retrieve user data
  Map<String, dynamic>? getUserData(String userId) {
    final String? userDataJson = _prefs.getString('user_$userId');
    if (userDataJson != null) {
      return jsonDecode(userDataJson) as Map<String, dynamic>;
    }
    return null; // User data not found
  }
}
