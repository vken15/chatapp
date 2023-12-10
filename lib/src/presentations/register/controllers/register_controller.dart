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
  Rx<bool> hidePass = true.obs;
  Rx<String> messages = "".obs;

  handleRegister() async {
    print("Register");
    if (!fullNameController.value.text.isNotEmpty ||
        !usernameController.value.text.isNotEmpty ||
        !passwordController.value.text.isNotEmpty ||
        !rePasswordController.value.text.isNotEmpty) {
      messages("Vui lòng nhập đầy đủ thông tin");
    }
    if (passwordController.value.text != rePasswordController.value.text) {
      messages("Mật khẩu nhập lại không đúng");
    }
    if (messages.isNotEmpty) {
      // Fluttertoast.showToast(
      //   msg: mess,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    } else {
      var client = RegisterClient();
      try {
        var response = await client.register(
            fullName: fullNameController.value.text,
            username: usernameController.value.text,
            password: passwordController.value.text);
        messages(response.message);
        if (response.success!) {
          Get.toNamed(AppRouter.loginScreen);
        }
        //Print
      } catch (e) {
        messages(e.toString());
        //rethrow;
      }
    }
  }
}
