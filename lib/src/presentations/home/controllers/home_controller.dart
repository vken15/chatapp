import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/chat/chat_client.dart';
import 'package:chatapp/src/data/models/chat/get_chat.dart';
import 'package:chatapp/src/data/socket/socket_methods.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  RxList<GetChats> chatList = <GetChats>[].obs;
  Rx<AppState> screenState = AppState.initial.obs;
  RxInt userId = (-1).obs;
  RxList<String> online = <String>[].obs;
  RxBool typing = false.obs;

  Future<void> getUserId() async {
    var uid = await storage.read(key: "userId");
    userId(int.parse(uid!));
  }

  final _socketMethod = SocketMethods();

  SocketMethods get socketMethods => _socketMethod;

  getChats() async {
    var client = ChatClient();
    screenState(AppState.loading);
    var response = await client.getConversations();
    screenState(AppState.loaded);
    chatList.assignAll(response);
  }

  String msgTime(String time) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(time).toLocal();

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserId().then((_) => socketMethods.initClient(userId.value));
    getChats();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _socketMethod.socketClient.dispose();
  }
}
