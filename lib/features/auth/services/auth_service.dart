import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // --- 1. SEND OTP ---
  Future<bool> sendOtp(String email) async {
    try {
      Response response = await _apiClient.dio.post(
        '/send-otp',
        data: {'email': email},
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint('Send OTP Failed: ${e.response?.data['message'] ?? e.message}');
      return false;
    }
  }

  // --- 2. REGISTER ---
  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      Response response = await _apiClient.dio.post(
        '/register',
        data: userData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        String token = response.data['token'];
        // Save token to secure storage
        await _storage.write(key: 'auth_token', value: token);
        return true;
      }
      return false;

    } on DioException catch (e) {
      debugPrint('Registration Failed: ${e.response?.data['message'] ?? e.message}');
      return false;
    }
  }

  // --- 3. LOGIN ---
  Future<bool> login(String email, String password) async {
    try {
      Response response = await _apiClient.dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        await _storage.write(key: 'auth_token', value: token);
        return true;
      }
      return false;

    } on DioException catch (e) {
      debugPrint('Login Failed: ${e.response?.data['message'] ?? e.message}');
      return false;
    }
  }

  // --- 4. LOGOUT ---
  Future<void> logout() async {
    try {
      // Hits the middleware protected route to revoke token
      await _apiClient.dio.post('/logout');
    } on DioException catch (e) {
      debugPrint('Logout API call failed: ${e.message}');
    } finally {
      await _storage.delete(key: 'auth_token');
    }
  }
}