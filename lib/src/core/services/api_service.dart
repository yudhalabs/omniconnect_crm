import 'package:dio/dio.dart';
import 'package:omniconnect_crm/src/core/services/auth_service.dart';
import 'package:omniconnect_crm/src/core/di/service_locator.dart';

class ApiService {
  final Dio _dio;
  final _baseUrl = 'https://api.omniconnect.id/v1';

  ApiService(this._dio);

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    final headers = await _getHeaders(requiresAuth);
    final response = await _dio.get(
      '$_baseUrl$endpoint',
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    bool requiresAuth = true,
  }) async {
    final headers = await _getHeaders(requiresAuth);
    final response = await _dio.post(
      '$_baseUrl$endpoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    bool requiresAuth = true,
  }) async {
    final headers = await _getHeaders(requiresAuth);
    final response = await _dio.put(
      '$_baseUrl$endpoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> delete(
    String endpoint, {
    bool requiresAuth = true,
  }) async {
    final headers = await _getHeaders(requiresAuth);
    final response = await _dio.delete(
      '$_baseUrl$endpoint',
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> upload(
    String endpoint,
    String filePath, {
    String fieldName = 'file',
    bool requiresAuth = true,
  }) async {
    final headers = await _getHeaders(requiresAuth);
    headers['Content-Type'] = 'multipart/form-data';

    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(filePath),
    });

    final response = await _dio.post(
      '$_baseUrl$endpoint',
      data: formData,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<Map<String, String>> _getHeaders(bool requiresAuth) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requiresAuth) {
      final authService = sl<AuthService>();
      final token = await authService.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }
}
