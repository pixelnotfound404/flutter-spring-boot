import 'package:flutter_springboot/screen/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>HomeController());
  }
}
