import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final storage = const FlutterSecureStorage();
  logout() {
    storage.delete(key: "UserToken");
    Get.toNamed(AppRouter.loginScreen);
  }
}