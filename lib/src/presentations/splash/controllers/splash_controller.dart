import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<String> userToken = "".obs;

  Future<void> getToken() async {
    var token = await storage.read(key: "UserToken");
    userToken(token);
    if (token == null) {
      Get.offAndToNamed(AppRouter.loginScreen);
    } else {
      Get.offAndToNamed(AppRouter.homeScreen);
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getToken();
  }
}
