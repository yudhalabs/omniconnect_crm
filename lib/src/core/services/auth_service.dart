import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:omniconnect_crm/src/core/services/api_service.dart';

class AuthService {
  final ApiService _apiService;
  final SharedPreferences _prefs;
  final _tokenKey = 'auth_token';
  final _refreshTokenKey = 'refresh_token';
  final _userKey = 'user_data';

  AuthService(this._apiService, this._prefs);

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        requiresAuth: false,
      );

      if (response['success'] == true) {
        final data = response['data'];
        await _saveTokens(
          data['token'],
          data['refreshToken'],
        );
        await _saveUserData(data['user']);
        return data['user'];
      }

      throw Exception(response['message'] ?? 'Login failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
    required String companyName,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'companyName': companyName,
        },
        requiresAuth: false,
      );

      if (response['success'] == true) {
        final data = response['data'];
        await _saveTokens(
          data['token'],
          data['refreshToken'],
        );
        await _saveUserData(data['user']);
        return data['user'];
      }

      throw Exception(response['message'] ?? 'Registration failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout');
    } catch (_) {
      // Ignore logout errors
    }

    await _prefs.remove(_tokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_userKey);
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _apiService.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        requiresAuth: false,
      );

      if (response['success'] == true) {
        final data = response['data'];
        await _saveTokens(data['token'], data['refreshToken']);
      } else {
        throw Exception('Token refresh failed');
      }
    } catch (e) {
      await logout();
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userData = _prefs.getString(_userKey);
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    await _saveUserData(data);
  }

  Future<void> _saveTokens(String token, String refreshToken) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> _saveUserData(Map<String, dynamic> user) async {
    await _prefs.setString(_userKey, jsonEncode(user));
  }
}
