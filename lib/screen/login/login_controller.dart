import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_springboot/helper/apiHelper.dart';
import 'package:flutter_springboot/model/user.dart';
import 'package:flutter_springboot/routes/routes.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var padding = 24.0.obs;
  var isPasswordHidden = true.obs; 
  var isLoading = false.obs;
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    if (isLoading.value) return;
    
    FocusManager.instance.primaryFocus?.unfocus();
    
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }
    
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
      return;
    }
    
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    try {
      isLoading.value = true;
      
      var data = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      
      var response = await Apihelper.post('/auth/login', data: data);
      

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null &&
          response.data is Map<String, dynamic>) {
        
        
        var result = loginResponse.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        const storage = FlutterSecureStorage();
        
        await prefs.setBool('isLogin', true);
        await storage.write(key: 'token', value: result.token);

        Get.offAllNamed(Routes.home); 
        
      } else {

        Get.snackbar('Error', 'Invalid response from server');
      }
      
    } on DioException catch (e) {
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        Get.snackbar('Timeout', 'Connection timed out. Please try again.');
        return;
      }
      
      if (e.type == DioExceptionType.connectionError) {
        Get.snackbar('Connection Error', 'Unable to connect to server. Please check your internet connection.');
        return;
      }

      var response = e.response;
      var data = response?.data;
      
      if (data != null && data is Map) {
        var errorMessage = data.containsKey('error')
            ? data['error']
            : data.containsKey('message') 
                ? data['message']
                : 'Unable to login';
        Get.snackbar('Error', errorMessage.toString());
      } else {
        switch (response?.statusCode) {
          case 401:
            Get.snackbar('Error', 'Invalid email or password');
            break;
          case 404:
            Get.snackbar('Error', 'Login endpoint not found');
            break;
          case 500:
            Get.snackbar('Error', 'Server error. Please try again later.');
            break;
          default:
            Get.snackbar('Error', 'Login failed. Please try again.');
        }
      }

    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}