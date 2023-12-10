import 'package:chatapp/src/presentations/setting/controllers/darkMode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeSettingScreen extends GetWidget<DarkModeSettingController> {
  const DarkModeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chế độ tối",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            ListTile(
              title: const Text("Bật"),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: controller.dartMode.value,
                onChanged: (ThemeMode? value) {
                  controller.dartMode.value = value;
                  Get.changeThemeMode(ThemeMode.dark);
                },
              ),
            ),
            ListTile(
              title: const Text("Tắt"),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: controller.dartMode.value,
                onChanged: (ThemeMode? value) {
                  controller.dartMode.value = value;
                  Get.changeThemeMode(ThemeMode.light);
                },
              ),
            ),
            ListTile(
              title: const Text("Mặc định của hệ thống"),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: controller.dartMode.value,
                onChanged: (ThemeMode? value) {
                  controller.dartMode.value = value;
                  Get.changeThemeMode(ThemeMode.system);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
