import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:chatapp/src/presentations/tab/controllers/tabbar_controller.dart';
import 'package:get/get.dart';

class TabBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TabBarController());
    Get.put(HomeController());
    Get.put(ProfileController());
  }
}
