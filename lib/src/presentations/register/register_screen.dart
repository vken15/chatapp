import 'package:chatapp/src/presentations/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/components/app_textfield.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ĐĂNG KÝ"),
      ),
      body: Obx(
        () => Column(
          children: [
            TextFieldCustom(
                labelText: "Họ và tên", controller: controller.fullNameController.value),
            TextFieldCustom(
                labelText: "Tên tài khoản",
                controller: controller.usernameController.value),
            TextFieldCustom(
                labelText: "Mật khẩu",
                obscureText: controller.hidePass.value,
                suffixIcon: GestureDetector(
                    onTap: () {
                      controller.hidePass.value = !controller.hidePass.value;
                    },
                    child: controller.hidePass.value == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                controller: controller.passwordController.value),
            TextFieldCustom(
                labelText: "Nhập lại mật khẩu",
                obscureText: controller.hidePass.value,
                suffixIcon: GestureDetector(
                    onTap: () {
                      controller.hidePass.value = !controller.hidePass.value;
                    },
                    child: controller.hidePass.value == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                controller: controller.rePasswordController.value),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              width: Get.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  controller.handleRegister();
                },
                child: const Text("Đăng ký"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
