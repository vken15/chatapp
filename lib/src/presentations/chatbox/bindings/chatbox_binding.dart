import 'package:chatapp/src/presentations/chatbox/controllers/chatbox_controller.dart';
import 'package:get/get.dart';

class ChatBoxBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatBoxController());
  }
}
