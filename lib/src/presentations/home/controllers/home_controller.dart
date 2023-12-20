import 'package:chatapp/src/components/show_snack_bar.dart';
import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/chat/chat_client.dart';
import 'package:chatapp/src/data/local/dao/chat_dao.dart';
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
  RxList<int> online = <int>[].obs;
  RxBool typing = false.obs;

  Future<void> getUserId() async {
    var uid = await storage.read(key: "userId");
    userId(int.parse(uid!));
  }

  final _socketMethod = SocketMethods();

  SocketMethods get socketMethods => _socketMethod;

  getChats() async {
    var chatDao = ChatDao();
    screenState(AppState.loading);
    var data = await chatDao.getAll();
    if (data.isNotEmpty) {
      chatList.assignAll(data);
      screenState(AppState.loaded);
    }
    try {
      var client = ChatClient();
      var response = await client.getConversations();
      if (response.isEmpty) {
        screenState(AppState.empty);
      } else {
        screenState(AppState.loaded);
        chatList.assignAll(response);
        List<int> chatIdList = [];
        for (var chat in chatList) {
          chatDao.insertOrUpdate(chat);
          chatIdList.add(chat.id!);
        }
        socketMethods.joinChat(chatIdList);
      }
    } catch (e) {
      ShowSnackBar.showSnackBar("Không có kết nối");
      if (chatList.isEmpty) {
        screenState(AppState.error);
      }
    }
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
      return "Hôm qua";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserId().then((_) {
      socketMethods.initClient(userId.value);
    });
    getChats();
  }

  @override
  void onClose() {
    super.onClose();
    _socketMethod.socketClient.dispose();
  }
}
