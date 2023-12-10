import 'package:chatapp/src/components/setting_button.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/presentations/setting/controllers/setting_controller.dart';
//import 'package:chatapp/src/router/app_router.dart';
import 'package:get/get.dart';

class SettingScreen extends GetWidget<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cài đặt",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SettingButton(
              text: "Chế độ tối",
              icon: const Icon(Icons.dark_mode),
              onTap: () {
                Get.toNamed(AppRouter.darkmodeScreen);
              }),
          const Divider(indent: 48, height: 0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                controller.logout();
              },
              child: const Text("Đăng xuất"),
            ),
          )
        ]),
    );
  }
}
