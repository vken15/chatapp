import 'package:chatapp/src/presentations/tab/controllers/tabbar_controller.dart';
import 'package:get/get.dart';

class TabBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TabBarController());
  }
}