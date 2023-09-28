import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _preferences;

  StorageService(this._preferences);

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  int getInt(String key) {
    return _preferences.getInt(key) ?? 0;
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool getBool(String key, [value]) {
    return _preferences.getBool(key) ?? value ?? false;
  }

  String getString(String key, [value]) {
    return _preferences.getString(key) ?? value ?? '';
  }

  List<String>? getStringList(String key, [value]) {
    return _preferences.getStringList(key);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clear() async {
    return await _preferences.clear();
  }
}
