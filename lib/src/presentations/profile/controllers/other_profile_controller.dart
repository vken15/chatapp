import 'package:chatapp/src/data/apiClient/chat/chat_client.dart';
import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/chat/create_chat.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/data/socket/socket_methods.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class OtherProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<UserInfo> user = UserInfo().obs;
  Rx<int> friendStatus = (-1).obs;
  SocketMethods socketMethods = Get.find<ChatController>().socketMethods;

  addFriend() async {
    socketMethods.friendRequest(user.value.id!, 1);
  }

  cancelFriend() async {
    socketMethods.friendRequest(user.value.id!, -2);
  }

  accessChat() async {
    try {
      var client = ChatClient();
      var createChat = CreateChat(userId: user.value.id!);
      var response = await client.accessChat(createChat);
      if (Get.isRegistered<ChatController>()) {
        Get.find<ChatController>().getChats();
      }
      Get.toNamed(AppRouter.chatboxScreen, arguments: {
        'title': response.chatName!.isEmpty
            ? user.value.fullName
            : response.chatName,
        'id': response.id,
        'photo': "",
        'receiver': response.users?.firstWhere((u) => u.id == user.value.id),
      });
    } catch (e) {
      print(e);
    }
  }

  init() async {
    Map<String, dynamic> args = Get.arguments;
    user.value = args['user'];
    try {
      var client = UserClient();
      var response = await client.getFriendRequestStatus(id: user.value.id!);
      friendStatus(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
