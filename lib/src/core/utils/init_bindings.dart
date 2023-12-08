import 'package:chatapp/src/presentations/setting/controllers/setting_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SettingController());
  }
}