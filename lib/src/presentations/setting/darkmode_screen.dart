import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeSettingScreen extends StatelessWidget {
  const DarkModeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chế độ tối",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: context.isDarkMode ? [const Color.fromARGB(96, 43, 42, 42), const Color.fromARGB(96, 43, 42, 42)] : 
                [const Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Get.changeThemeMode(ThemeMode.dark);
            },
            child: const ListTile(
              title: Text("Bật"),
            ),
          ),
          InkWell(
            onTap: () {
              Get.changeThemeMode(ThemeMode.light);
            },
            child: const ListTile(
              title: Text("Tắt"),
            ),
          ),
          InkWell(
            onTap: () {
              Get.changeThemeMode(ThemeMode.system);
            },
            child: const ListTile(
              title: Text("Mặc định của hệ thống"),
              // trailing: Radio<ThemeMode>(
              //   value: ThemeMode.system,
              //   groupValue: controller.dartMode.value,
              //   onChanged: (ThemeMode? value) {
              //     controller.dartMode.value = value;
              //     Get.changeThemeMode(ThemeMode.system);
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
