import 'package:chatapp/src/components/app_button.dart';
import 'package:chatapp/src/core/enum/login_status.dart';
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
        foregroundColor: context.isDarkMode ? Colors.white : Colors.black,
        title: const Text("ĐĂNG KÝ"),
      ),
      body: Obx(
        () => Column(
          children: [
            TextFieldCustom(
                labelText: "Họ và tên",
                controller: controller.fullNameController.value,
                validate: controller.fullNameValidate.value,
                errorText: "Vui lòng nhập họ và tên",
                onChanged: (value) {
                  controller.fullNameValidate.value = false;
                }),
            TextFieldCustom(
                labelText: "Tên tài khoản",
                controller: controller.usernameController.value,
                validate: controller.usernameValidate.value,
                errorText: "Vui lòng nhập tên tài khoản",
                onChanged: (value) {
                  controller.usernameValidate.value = false;
                }),
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
                controller: controller.passwordController.value,
                validate: controller.passwordValidate.value,
                errorText: "Vui lòng nhập mật khẩu",
                onChanged: (value) {
                  controller.passwordValidate.value = false;
                }),
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
                controller: controller.rePasswordController.value,
                validate: controller.rePasswordValidate.value,
                errorText: "Vui lòng nhập lại mật khẩu",
                onChanged: (value) {
                  controller.rePasswordValidate.value = false;
                }),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              width: Get.width,
              child: ButtonCustom(
                  text: "Đăng ký",
                  onPressed: () {
                    controller.handleRegister();
                  },
                  loading: controller.status.value == LoginStatus.loading,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
