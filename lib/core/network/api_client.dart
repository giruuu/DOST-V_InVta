import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio dio;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final String baseUrl = "http://127.0.0.1:8000/api";

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // THE INTERCEPTOR: Automatically injects the token into every request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Grab the token from secure storage
          final token = await secureStorage.read(key: 'auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          debugPrint("--> ${options.method.toUpperCase()} ${options.uri}");
          return handler.next(options); // Continue the request
        },
        onResponse: (response, handler) {
          debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          debugPrint("<-- Error: ${e.response?.statusCode} ${e.message}");

          // If Laravel says the token is invalid/expired (401 Unauthorized)
          if (e.response?.statusCode == 401) {
            // Clear the bad token
            await secureStorage.delete(key: 'auth_token');

            // TODO: Add logic here to force navigation back to the LoginPage
            debugPrint("Session expired. User logged out.");
          }

          return handler.next(e);
        },
      ),
    );
  }
}