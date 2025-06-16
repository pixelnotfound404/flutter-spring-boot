import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_springboot/helper/apiHelper.dart';
import 'package:flutter_springboot/model/user.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  var padding = 24.0.obs;
  var isPasswordHidden = true.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  void signup() async {
    isLoading.value = true;


    try {
      var formData = {
        'username': nameController.text.trim(),
        'email': emailController.text.trim().toLowerCase(),
        'password': passwordController.text,
      };

      var response = await Apihelper.post('/auth/signup', data: formData);


      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data is Map<String, dynamic>) {
        try {
          var result = loginResponse.fromJson(response.data);
          const storage = FlutterSecureStorage();

          await storage.write(key: 'isLogin', value: 'true');
          await storage.write(key: 'token', value: result.token);
          await storage.write(key: 'email', value: emailController.text.trim());
          Get.offAllNamed('/login');
        } catch (parseError) {
          Get.snackbar(
            'Parse Error',
            'Failed to parse server response: $parseError',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {

        Get.snackbar(
          'Signup Failed',
          'Unexpected server response (${response.statusCode})',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on DioException catch (e) {
      
      String errorMessage = 'Signup failed. Please try again.';

      if (e.response?.statusCode == 400) {
        var data = e.response?.data;
      
        if (data != null && data is Map && data.containsKey('message')) {
          errorMessage = data['message'];
        } else if (data != null && data is Map && data.containsKey('error')) {
          errorMessage = data['error'];

        }
      } else if (e.response?.statusCode == 409) {
        errorMessage = 'Email already exists. Please use a different email.';

      } else if (e.response?.statusCode == 422) {
        errorMessage = 'Invalid input data. Please check your information.';

      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage ='Connection timeout. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server response timeout. Please try again.';
        
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage ='Connection error. Please check your internet connection.';
        
      }

      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e, stackTrace) {
     
      Get.snackbar(
        'Error',
        'Something went wrong. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    

    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Name is required');
      return false;
    }

    if (nameController.text.trim().length < 2) {
      Get.snackbar('Validation Error', 'Name must be at least 2 characters');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Email is required');
      return false;
    }
   
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(emailPattern).hasMatch(emailController.text.trim())) {
      Get.snackbar('Validation Error', 'Please enter a valid email address');
      return false;
    }
    
    if (passwordController.text.isEmpty) {
    
      Get.snackbar('Validation Error', 'Password is required');
      return false;
    }
   
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Validation Error',
        'Password must be at least 6 characters',
      );
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}
