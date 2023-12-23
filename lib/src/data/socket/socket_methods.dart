import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/socket/socket_client.dart';
import 'package:chatapp/src/presentations/chatbox/controllers/chatbox_controller.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  late Socket _socketClient;

  Socket get socketClient => _socketClient;

  void initClient(int userId) {
    _socketClient = SocketClient.instance.socket!;
    _socketClient.connect();
    _socketClient.emit("setup", userId);
    _socketClient.onConnect((_) {
      print("Connected!");
    });

    _socketClient.on('online-user-list', (users) {
      Get.find<ChatController>().online.addAll(users.cast<int>());
      Get.find<ChatController>().chatList.refresh();
    });

    _socketClient.on('online-user', (userId) {
      var i = Get.find<ChatController>().online.indexOf(userId);
      if (i < 0) {
        Get.find<ChatController>().online.add(userId);
      }
      Get.find<ChatController>().chatList.refresh();
    });

    _socketClient.on('offline-user', (userId) {
      var i = Get.find<ChatController>().online.indexOf(userId);
      if (i >= 0) {
        Get.find<ChatController>().online.remove(userId);
      }
      Get.find<ChatController>().chatList.refresh();
    });

    _socketClient.on('typing', (status) {
      Get.find<ChatController>().typing.value = true;
    });

    _socketClient.on('not typing', (status) {
      Get.find<ChatController>().typing.value = false;
    });

    _socketClient.on('message received', (newMessageReceived) {
      ReceivedMessage receivedMessage =
          ReceivedMessage.fromJson(newMessageReceived);
      sendStopTypingEvent(receivedMessage.chatId!);
      if (receivedMessage.senderId != userId) {
        Get.find<ChatController>().chatList.forEach((chat) {
          if (chat.id == receivedMessage.chatId) {
            chat.latestMessage = receivedMessage;
          }
        });
        Get.find<ChatController>().chatList.refresh();
        try {
          Get.find<ChatBoxController>().messages.insert(0, receivedMessage);
        } catch (e) {
          print("không ở trong boxchat");
        }
      }
    });

    //TODO:
    _socketClient.on('accept friend', (data) {});
  }

  //emits
  void newMessageEvent(Map<String, dynamic> emmission) {
    _socketClient.emit('new message', emmission);
  }

  void sendTypingEvent(int id) {
    _socketClient.emit('typing', id);
  }

  void sendStopTypingEvent(int id) {
    _socketClient.emit('stop typing', id);
  }

  void joinChat(List<int> listId) {
    _socketClient.emit('join chat', listId);
  }

  //TODO:
  void sendFriendRequest(int senderId, int receiverId) {
    _socketClient.emit('friend request', {senderId, receiverId});
  }

  // void updateProfilePhoto(int id,Uint8List encodedImage) {
  //   _socketClient.emit('update profile photo', {id, encodedImage});
  // }
}
