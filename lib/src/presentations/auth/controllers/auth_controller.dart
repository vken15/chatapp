import 'package:chatapp/src/data/apiClient/auth/auth_client.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/core/enum/login_status.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<TextEditingController> usernameController = Rx(TextEditingController());
  Rx<TextEditingController> passwordController = Rx(TextEditingController());
  Rx<bool> hidePass = true.obs;
  Rx<String> messages = "".obs;

  // Rx<TextEditingController> fullName = Rx(TextEditingController());
  // Rx<TextEditingController> rePassword = Rx(TextEditingController());

  Rx<LoginStatus> status = LoginStatus.init.obs;

  handleLogin() async {
    print("Login");
    status(LoginStatus.loading);
    var client = AuthClient();
    try {
      var response = await client.login(
          username: usernameController.value.text,
          password: passwordController.value.text);
      if (response.success!) {
        await storage.write(key: "UserToken", value: response.token);
        Get.toNamed(AppRouter.tabScreen);
        status(LoginStatus.success);
      } else {
        status(LoginStatus.faild);
        messages(response.message);
        //Print
      }
    } catch (e) {
      status(LoginStatus.faild);
      messages(e.toString());
      //rethrow;
    }
  }

  // Fluttertoast.showToast(
  //   msg: "Tên đăng nhập hoặc mật khẩu không đúng",
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.CENTER,
  //   timeInSecForIosWeb: 1,
  //   backgroundColor: Colors.red,
  //   textColor: Colors.white,
  //   fontSize: 16.0,
  // );
}
