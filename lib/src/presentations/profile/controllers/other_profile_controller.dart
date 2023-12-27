import 'package:chatapp/src/data/apiClient/chat/chat_client.dart';
import 'package:chatapp/src/data/models/chat/create_chat.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class OtherProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<UserInfo> user = UserInfo().obs;

  addFriend() {}

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

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments;
    user.value = args['user'];
    super.onInit();
  }
}
