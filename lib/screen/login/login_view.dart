import 'package:flutter/material.dart';
import 'package:flutter_springboot/routes/routes.dart';
import 'package:flutter_springboot/screen/login/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: controller.padding.value),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText:
                          'Password', // Acts as a placeholder but remains visible when typing
                      border:
                          OutlineInputBorder(), // Optional: Adds a border for better visibility
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    child: Text(
                      "sign in",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                         Get.toNamed(Routes.register);
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
