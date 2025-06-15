import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _keyRegistered = 'is_registered';

  Future<void> setRegistered(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRegistered, value);
  }

  Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRegistered) ?? false;
  }
}