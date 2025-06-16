import 'package:flutter/material.dart';
import 'package:flutter_springboot/screen/OTP/otp_binnding.dart';
import 'package:flutter_springboot/screen/OTP/otp_view.dart';
import 'package:flutter_springboot/screen/home/home_binding.dart';
import 'package:flutter_springboot/screen/home/home_view.dart';
import 'package:flutter_springboot/screen/login/login_binding.dart';
import 'package:flutter_springboot/screen/login/login_view.dart';
import 'package:flutter_springboot/screen/signup/signnup_binding.dart';
import 'package:flutter_springboot/screen/signup/signup_controller.dart';
import 'package:flutter_springboot/screen/signup/signup_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/utils.dart';

class Routes {
  Routes._();

  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/signup';

  static final appPages = [
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home, 
      page: () => HomeView(), 
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.register,
      page: () => SignupView(),
      binding: SignnupBinding(),
    ),
  ];
}
