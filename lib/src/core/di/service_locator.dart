import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:omniconnect_crm/src/core/services/api_service.dart';
import 'package:omniconnect_crm/src/core/services/auth_service.dart';
import 'package:omniconnect_crm/src/core/services/websocket_service.dart';
import 'package:omniconnect_crm/src/core/services/notification_service.dart';
import 'package:omniconnect_crm/src/core/services/storage_service.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register Dio instance
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://api.omniconnect.id/v1';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  });

  // Register services
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<Dio>()),
  );

  sl.registerLazySingleton<AuthService>(
    () => AuthService(sl<ApiService>(), sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<WebSocketService>(
    () => WebSocketService(),
  );

  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );

  sl.registerLazySingleton<StorageService>(
    () => StorageService(sl<SharedPreferences>()),
  );
}
