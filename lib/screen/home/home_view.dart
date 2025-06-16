import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_springboot/screen/home/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Text("Home screen")
                ),
                SizedBox(
                  height: controller.padding.value,
                ),
                Center(
                  child: Text("Home screen")
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
