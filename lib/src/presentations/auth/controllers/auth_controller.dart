import 'package:chatapp/src/core/utils/show_snack_bar.dart';
import 'package:chatapp/src/data/apiClient/auth/auth_client.dart';
import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/core/enum/login_status.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<TextEditingController> usernameController = Rx(TextEditingController());
  Rx<TextEditingController> passwordController = Rx(TextEditingController());
  RxBool usernameValidate = false.obs;
  RxBool passwordValidate = false.obs;
  Rx<bool> hidePass = true.obs;
  //Rx<String> messages = "".obs;

  Rx<LoginStatus> status = LoginStatus.init.obs;

  handleLogin() async {
    print("Login");
    usernameValidate.value = usernameController.value.text.isEmpty;
    passwordValidate.value = passwordController.value.text.isEmpty;
    if (!usernameValidate.value && !passwordValidate.value) {
      status(LoginStatus.loading);
      var client = AuthClient();
      try {
        var response = await client.login(
            username: usernameController.value.text,
            password: passwordController.value.text);
        if (response.success!) {
          await storage.write(key: "UserToken", value: response.token);
          await storage.write(key: "userId", value: response.id.toString());
          var userDao = UserDao();
          await userDao.insertOrUpdate(response);
          Get.offAndToNamed(AppRouter.homeScreen);
          status(LoginStatus.success);
        } else {
          status(LoginStatus.faild);
          //messages(response.message);
          ShowSnackBar.showSnackBar(response.message);
        }
      } catch (e) {
        status(LoginStatus.faild);
        //messages(e.toString());
        ShowSnackBar.showSnackBar(e.toString());
        //rethrow;
      }
    }
  }

}
