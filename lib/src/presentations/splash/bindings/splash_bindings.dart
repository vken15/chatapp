import 'package:get/get.dart';
import 'package:chatapp/src/presentations/splash/controllers/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
