import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_springboot/helper/apiHelper.dart';
import 'package:flutter_springboot/model/user.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var padding = 24.0.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    try {
      var formData = FormData.fromMap({
        'email': emailController.text,
        'password': passwordController.text,
      });

      var response = await Apihelper.post('/auth/login', data: formData);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null &&
          response.data is Map<String, dynamic>) {
        var result = loginResponse.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        const storage = FlutterSecureStorage();
        prefs.setBool('isLogin', true);
        storage.write(key: 'token', value: result.token);
        Get.toNamed('/home');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        Get.snackbar('Timeout', 'Connection timed out. Please try again.');
        return;
      }

      var response = e.response;
      var data = response?.data;
      if (data != null && data is Map) {
        var errorMessage = data.containsKey('error')
            ? data['error']
            : 'unable to login';
        Get.snackbar('Error', errorMessage);
      }

      // print("Error $e");
      // print(
      //     'Email: ${emailController.text}, Password: ${passwordController.text}');
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }
}
