import 'package:chatapp/src/presentations/phonebook/controllers/friend_request_controller.dart';
import 'package:get/get.dart';

class FriendRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.put((FriendRequestController()));
  }
}
