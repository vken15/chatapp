import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<String> userToken = "".obs;

  Future<void> getToken() async {
    var token = await storage.read(key: "UserToken");
    userToken(token);
    Future.delayed(
        const Duration(seconds: 3),
        () => {
              if (token == null)
                {Get.toNamed(AppRouter.loginScreen)}
              else
                {Get.toNamed(AppRouter.tabScreen)}
            });
  }

  @override
  void onReady() {
    super.onReady();
    getToken();
  }
}
