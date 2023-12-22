import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ChatController());
    Get.put(ProfileController());
  }
}
