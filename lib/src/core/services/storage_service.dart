import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Generic methods
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // JSON methods
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Remove
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  // Check exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Clear all
  Future<bool> clear() async {
    return _prefs.clear();
  }

  // Keys
  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  // Theme
  Future<bool> setDarkMode(bool isDarkMode) async {
    return _prefs.setBool('dark_mode', isDarkMode);
  }

  bool? isDarkMode() {
    return _prefs.getBool('dark_mode');
  }

  // Language
  Future<bool> setLanguage(String languageCode) async {
    return _prefs.setString('language', languageCode);
  }

  String? getLanguage() {
    return _prefs.getString('language') ?? 'en';
  }

  // Onboarding
  Future<bool> setOnboardingComplete(bool complete) async {
    return _prefs.setBool('onboarding_complete', complete);
  }

  bool? isOnboardingComplete() {
    return _prefs.getBool('onboarding_complete');
  }

  // First launch
  bool isFirstLaunch() {
    return !(_prefs.getBool('first_launch') ?? false);
  }

  Future<void> setFirstLaunchComplete() async {
    await _prefs.setBool('first_launch', false);
  }
}
