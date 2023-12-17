import 'package:chatapp/src/components/app_button.dart';
import 'package:chatapp/src/core/enum/login_status.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/components/app_textfield.dart';
import 'package:chatapp/src/presentations/auth/controllers/auth_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const SizedBox(height: 8),
              TextFieldCustom(
                labelText: "Tên người dùng",
                controller: controller.usernameController.value,
                validate: controller.usernameValidate.value,
                errorText: "Vui lòng nhập tên người dùng",
                onChanged: (value) {
                  controller.usernameValidate.value = false;
                },
              ),
              //const SizedBox(height: 8),
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
                },
              ),
              //const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                width: Get.width,
                child: ButtonCustom(
                  text: "Đăng nhập",
                  onPressed: () {
                    controller.handleLogin();
                  },
                  loading: controller.status.value == LoginStatus.loading,
                ),
              ),
              Wrap(
                children: [
                  Text.rich(
                    TextSpan(
                      text:
                          "Bạn quên mật khẩu ư? ", //"Bạn quên tên đăng nhập ư? ",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                            text: "Nhận trợ giúp đăng nhập.",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(24),
                width: Get.width,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(width: 1, color: Colors.blue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRouter.registerScreen);
                  },
                  child: const Text("Tạo tài khoản mới"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
