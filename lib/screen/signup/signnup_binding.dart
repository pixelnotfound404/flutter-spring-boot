import 'package:flutter_springboot/screen/signup/signup_controller.dart';
import 'package:get/get.dart';

class SignnupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
