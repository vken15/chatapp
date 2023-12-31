import 'package:chatapp/src/core/utils/show_snack_bar.dart';
import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/message/message_client.dart';
import 'package:chatapp/src/data/local/dao/message_dao.dart';
import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/models/message/send_message.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/data/socket/socket_methods.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatBoxController extends GetxController {
  Rx<TextEditingController> messageController = Rx(TextEditingController());
  Rx<AppState> screenState = AppState.initial.obs;
  RxInt id = (-1).obs;
  RxString title = "".obs;
  RxString photo = "".obs;
  RxInt offset = 1.obs;
  RxList<ReceivedMessage> messages = <ReceivedMessage>[].obs;
  RxList<ReceivedMessage> msgList = <ReceivedMessage>[].obs;
  int userId = Get.find<ChatController>().userId.value;
  Rx<UserInfo> receiver = UserInfo().obs;
  ScrollController scrollController = ScrollController();
  SocketMethods socketMethods = Get.find<ChatController>().socketMethods;

  String msgTime(String time) {
    DateTime messageTime = DateTime.parse(time).toLocal();
    return DateFormat.Hm().format(messageTime);
  }

  String msgDateTime(String time) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(time).toLocal();
    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return "${DateFormat.Hm().format(messageTime)} Hôm nay";
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return "${DateFormat.Hm().format(messageTime)} Hôm qua";
    } else {
      return "${DateFormat.Hm().format(messageTime)} ${DateFormat.yMd().format(messageTime)}";
    }
  }

  bool changeDate(int index) {
    if (index + 1 < messages.length) {
      DateTime messageTime = DateTime.parse(messages[index].updatedAt.toString()).toLocal();
      DateTime messageTime2 = DateTime.parse(messages[index+1].updatedAt.toString()).toLocal();
      if (messageTime2.year != messageTime.year ||
          messageTime2.month != messageTime.month ||
          messageTime2.day != messageTime.day) {
        return true;
      }
    }
    if (index + 1 == messages.length) {
        return true;
    }
    return false;
  }

  void sendMessage(String content, int chatId, int receiverId, int senderId) {
    if (content.isNotEmpty) {
      SendMessage model =
          SendMessage(content: content, receiverId: receiverId, chatId: chatId);
      var client = MessageClient();
      client.sendMessage(model).then((response) {
        var emmission = response[2];
        socketMethods.newMessageEvent(emmission);
        //socketMethods.sendStopTypingEvent(id.value);
        messageController.value.clear();
        messages.insert(0, response[1]);
        Get.find<ChatController>().chatList.forEach((chat) {
          if (chat.id == response[1].chatId) {
            chat.latestMessage = response[1];
          }
        });
        Get.find<ChatController>().chatList.refresh();
        client.sendNotify(model);
      }).catchError((e) {
        ShowSnackBar.showSnackBar("Không thể gửi tin nhắn");
      });
    }
  }

  //Lấy dữ liệu lần đầu
  void getMessages() async {
    var messageDao = MessageDao();
    screenState(AppState.loading);
    var data = await messageDao.getAllByIdSortedByLatest(id.value, 1);
    if (data.isNotEmpty) {
      messages.assignAll(data);
      screenState(AppState.loaded);
    }
    try {
      var client = MessageClient();
      var response = await client.getMessages(id.value, 1);
      if (response.isEmpty) {
        screenState(AppState.empty);
      } else {
        screenState(AppState.loaded);
        messages.assignAll(response);
        for (var message in messages) {
          messageDao.insertOrUpdate(message);
        }
      }
    } catch (e) {
      ShowSnackBar.showSnackBar("Không có kết nối");
      if (messages.isEmpty) {
        screenState(AppState.error);
      }
    }
  }

  //Lấy dữ liệu những lần tiếp theo
  void getMoreMessages() async {
    var messageDao = MessageDao();
    try {
      var client = MessageClient();
      var response = await client.getMessages(id.value, offset.value);
      messages.insertAll(messages.length, response);
      for (var message in messages) {
        messageDao.insertOrUpdate(message);
      }
    } catch (e) {
      var data =
          await messageDao.getAllByIdSortedByLatest(id.value, offset.value);
      if (data.isNotEmpty) {
        messages.insertAll(messages.length, data);
      } else {
        ShowSnackBar.showSnackBar("Không có kết nối");
      }
    }
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

  // void startTyping() {
  //   socketMethods.sendTypingEvent(id.value);
  // }

  // void stopTyping() {
  //   socketMethods.sendStopTypingEvent(id.value);
  // }

  String lastOnlineCalc(String time) {
    List<int> onlineList = Get.find<ChatController>().online;
    if (onlineList.contains(receiver.value.id)) {
      return "Đang hoạt động";
    } else {
      DateTime now = DateTime.now();
      DateTime lastOnline = DateTime.parse(time).toLocal();

      if (now.year == lastOnline.year &&
          now.month == lastOnline.month &&
          now.day == lastOnline.day) {
        if (now.hour == lastOnline.hour) {
          return "Hoạt động ${now.minute - lastOnline.minute} phút trước";
        } else {
          return "Hoạt động ${now.hour - lastOnline.hour} giờ trước";
        }
      } else if (now.year == lastOnline.year &&
          now.month == lastOnline.month &&
          now.day - lastOnline.day == 1) {
        return "Truy cập hôm qua";
      } else {
        return "Truy cập ${DateFormat.yMd().format(lastOnline)}";
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    id.value = args['id'];
    title.value = args['title'];
    photo.value = args['photo'];
    receiver.value = args['receiver'];
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
