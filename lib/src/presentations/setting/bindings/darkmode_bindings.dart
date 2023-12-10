import 'package:chatapp/src/presentations/setting/controllers/darkMode_controller.dart';
import 'package:get/get.dart';

class DarkModeSettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DarkModeSettingController());
  }
}
