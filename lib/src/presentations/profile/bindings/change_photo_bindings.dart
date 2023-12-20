import 'package:chatapp/src/presentations/profile/controllers/change_photo_controller.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ChangePhotoBindings extends Bindings {
  @override
  void dependencies() {
    Get.put((ProfileController()));
    Get.put((ChangePhotoController()));
  }
}
