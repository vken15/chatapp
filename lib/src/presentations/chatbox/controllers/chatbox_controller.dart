import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/message/message_client.dart';
import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/models/message/send_message.dart';
import 'package:chatapp/src/data/socket/socket_methods.dart';
import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBoxController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<TextEditingController> messageController = Rx(TextEditingController());
  Rx<AppState> screenState = AppState.initial.obs;
  RxInt id = (-1).obs;
  RxString title = "".obs;
  RxString photo = "".obs;
  RxList<int> users = <int>[].obs;
  RxInt offset = 1.obs;
  RxList<ReceivedMessage> messages = <ReceivedMessage>[].obs;
  RxList<ReceivedMessage> msgList = <ReceivedMessage>[].obs;
  int userId = Get.find<HomeController>().userId.value;
  int receiverId = 0;
  ScrollController scrollController = ScrollController();
  SocketMethods socketMethods = Get.find<HomeController>().socketMethods;

  void sendMessage(String content, int chatId, int receiverId, int senderId) {
    if (content.isNotEmpty) {
      SendMessage model = SendMessage(
          senderId: senderId,
          content: content,
          receiverId: receiverId,
          chatId: chatId);
      var client = MessageClient();
      client.sendMessage(model).then((response) {
        var emmission = response[2];
        socketMethods.newMessageEvent(emmission);
        socketMethods.sendStopTypingEvent(id.value);
        messageController.value.clear();
        messages.insert(0, response[1]);
      });
    }
  }

  //Lấy dữ liệu lần đầu
  void getMessages() async {
    var client = MessageClient();
    screenState(AppState.loading);
    var response = await client.getMessages(id.value, offset.value);
    screenState(AppState.loaded);
    messages.assignAll(response);
  }

  //Lấy dữ liệu những lần tiếp theo
  void getMoreMessages() async {
    var client = MessageClient();
    var response = await client.getMessages(id.value, offset.value);
    messages.insertAll(messages.length, response);
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.hasClients) {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          print("loading...");
          if (messages.length >= (12 * offset.value)) {
            offset++;
            getMoreMessages();
          }
        }
      }
    });
  }

  void startTyping() {
    socketMethods.sendTypingEvent(id.value);
  }

  void stopTyping() {
    socketMethods.sendStopTypingEvent(id.value);
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;

    id.value = args['id'];
    title.value = args['title'];
    //photo.value = args['photo'];
    users.value = args['users'];
    receiverId = users.firstWhere((id) => id != userId);
    getMessages();
    handleNext();
  }

  @override
  void onClose() {
    scrollController.dispose();
    messageController.value.dispose();
    super.onClose();
  }
}
