import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class Apihelper {
  Apihelper._();

static final _dio = dio.Dio(dio.BaseOptions(
      baseUrl: dotenv.env['API_URL'] ?? 'unknown',
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }));
  
  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token == null) {
      logout();
      throw dio.DioException(
        requestOptions: dio.RequestOptions(path: endpoint),
        type: dio.DioExceptionType.unknown,
        error: 'Unauthenticated: No token found',
      );
    }
    setAuthToken(token);
    return await _dio.get(endpoint, queryParameters: queryParams);
  }

  static Future<Response> post(String endpoint, {dynamic data}) async {
    return await _dio.post(endpoint, data: data);
  }

  static Future<Response> put(String endpoint, {dynamic data}) async {
    return await _dio.put(endpoint, data: data);
  }

  static Future<Response> delete(String endpoint) async {
    return await _dio.post(endpoint);
  }

  static void logout() async {
    const storage = FlutterSecureStorage();
    storage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAllNamed('/login');
  }
}