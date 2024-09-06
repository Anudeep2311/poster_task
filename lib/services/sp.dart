import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveUserType(bool isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdmin', isAdmin);
  }

  Future<bool?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin');
  }
}
