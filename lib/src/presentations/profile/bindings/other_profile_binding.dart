import 'package:chatapp/src/presentations/profile/controllers/other_profile_controller.dart';
import 'package:get/get.dart';

class OtherProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put((OtherProfileController()));
  }
}
