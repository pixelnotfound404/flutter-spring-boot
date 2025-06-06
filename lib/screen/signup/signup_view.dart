import 'package:flutter/material.dart';
import 'package:flutter_springboot/screen/signup/signup_controller.dart';
import 'package:get/get.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Sign Up"),
        ),
      )
    );
  }
}