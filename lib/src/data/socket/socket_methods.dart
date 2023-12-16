import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/socket/socket_client.dart';
import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
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
      _socketClient.on(
          'online-users',
          (userId) => {
                    Get.find<HomeController>().online.replaceRange(
                        0, Get.find<HomeController>().online.length, [userId])
              });
    });

    _socketClient.on('typing', (status) {
      Get.find<HomeController>().typing.value = true;
    });

    _socketClient.on('not typing', (status) {
      Get.find<HomeController>().typing.value = false;
    });

    _socketClient.on('message received', (newMessageReceived) {
      ReceivedMessage receivedMessage =
          ReceivedMessage.fromJson(newMessageReceived);
      sendStopTypingEvent(receivedMessage.chatId!);
      if (receivedMessage.senderId != userId) {
        //messages!.insert(0, receivedMessage);
      }
    });
  }

  

  void newMessageEvent(Map<String, dynamic> emmission) {
    _socketClient.emit('new message', emmission);
  }

  void sendTypingEvent(int id) {
    _socketClient.emit('typing', id);
  }

  void sendStopTypingEvent(int id) {
    _socketClient.emit('stop typing', id);
  }

  void joinChat(int id) {
    _socketClient.emit('join chat', id);
  }
}
