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
    var uid = await storage.read(key: "userId");
    socketMethods.sendFriendRequest(int.parse(uid!), user.value.id!);
  }

  accessChat() async {
    try {
      var client = ChatClient();
      var createChat = CreateChat(userId: user.value.id!);
      var response = await client.accessChat(createChat);
      Get.toNamed(AppRouter.chatboxScreen, arguments: {
          'title': response.chatName!.isEmpty ? user.value.fullName : response.chatName,
          'id': response.id,
          'photo': "",
          'receiver': user.value,
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
