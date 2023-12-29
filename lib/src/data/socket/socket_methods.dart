import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/models/user/friend_request.dart';
import 'package:chatapp/src/data/socket/socket_client.dart';
import 'package:chatapp/src/presentations/chatbox/controllers/chatbox_controller.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:chatapp/src/presentations/phonebook/controllers/friend_request_controller.dart';
import 'package:chatapp/src/presentations/phonebook/controllers/phonebook_controller.dart';
import 'package:chatapp/src/presentations/profile/controllers/other_profile_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  late Socket _socketClient;

  Socket get socketClient => _socketClient;

  Future<void> initClient(int userId) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    _socketClient = SocketClient.instance.socket!;
    _socketClient.connect();
    _socketClient.emit('authenticate', token);
    _socketClient.onConnect((_) {
      print("Connected!");
    });

    _socketClient.on('online-user-list', (users) {
      if (Get.isRegistered<ChatController>() == true) {
        Get.find<ChatController>().online.addAll(users.cast<int>());
        Get.find<ChatController>().chatList.refresh();
      }
      if (Get.isRegistered<PhoneBookController>() == true) {
        Get.find<PhoneBookController>().online.addAll(users.cast<int>());
        Get.find<PhoneBookController>().getOnlineFriend();
      }
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

    /// status:
    /// {-2: cancel/delete}
    /// {-1: reject}
    /// {0: default}
    /// {1: create}
    /// {2: accept}
    _socketClient.on('update friend request', (data) {
      var response = FriendRequest.fromJson2(data);
      if (response.status == -2) {
        response.status = 0;
      }
      if (Get.isRegistered<FriendRequestController>() == true) {
        Get.find<FriendRequestController>().getRFR();
        Get.find<FriendRequestController>().getSFR();
      }
      if (Get.isRegistered<OtherProfileController>() == true) {
        if (Get.find<OtherProfileController>().user.value.id == response.id) {
          Get.find<OtherProfileController>().friendStatus(response.status);
        }
      }
    });
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

  /// status:
  /// {-2: cancel/delete}
  /// {-1: reject}
  /// {0: default}
  /// {1: create}
  /// {2: accept}
  void friendRequest(int receiverId, int status) {
    _socketClient
        .emit('friend request', {'receiverId': receiverId, 'status': status});
  }

  // void updateProfilePhoto(int id,Uint8List encodedImage) {
  //   _socketClient.emit('update profile photo', {id, encodedImage});
  // }
}
