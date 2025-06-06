import 'package:flutter_springboot/screen/OTP/otp_controller.dart';
import 'package:get/get.dart';

class OtpBinnding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
