import 'package:chatapp/src/core/utils/show_snack_bar.dart';
import 'package:chatapp/src/core/enum/login_status.dart';
import 'package:chatapp/src/data/apiClient/auth/register_client.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<TextEditingController> fullNameController = Rx(TextEditingController());
  Rx<TextEditingController> usernameController = Rx(TextEditingController());
  Rx<TextEditingController> passwordController = Rx(TextEditingController());
  Rx<TextEditingController> rePasswordController = Rx(TextEditingController());
  RxBool fullNameValidate = false.obs;
  RxBool usernameValidate = false.obs;
  RxBool passwordValidate = false.obs;
  RxBool rePasswordValidate = false.obs;
  Rx<bool> hidePass = true.obs;
  //Rx<String> messages = "".obs;
  Rx<LoginStatus> status = LoginStatus.init.obs;

  handleRegister() async {
    print("Register");
    fullNameValidate.value = fullNameController.value.text.isEmpty;
    usernameValidate.value = usernameController.value.text.isEmpty;
    passwordValidate.value = passwordController.value.text.isEmpty;
    rePasswordValidate.value = rePasswordController.value.text.isEmpty;
    if (!fullNameValidate.value &&
        !usernameValidate.value &&
        !passwordValidate.value &&
        !rePasswordValidate.value) {
      if (passwordController.value.text != rePasswordController.value.text) {
        ShowSnackBar.showSnackBar("Mật khẩu nhập lại không đúng");
      } else {
        status(LoginStatus.loading);
        var client = RegisterClient();
        try {
          var response = await client.register(
              fullName: fullNameController.value.text,
              username: usernameController.value.text,
              password: passwordController.value.text);
          //messages(response.message);
          if (response.success!) {
            status(LoginStatus.success);
            Get.toNamed(AppRouter.loginScreen);
          } else {
            status(LoginStatus.faild);
            ShowSnackBar.showSnackBar(response.message);
          }
        } catch (e) {
          status(LoginStatus.faild);
          ShowSnackBar.showSnackBar(e.toString());
          //rethrow;
        }
      }
    }
  }
}
