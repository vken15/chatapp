import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/user/friend_request.dart';
import 'package:chatapp/src/data/socket/socket_methods.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestController extends GetxController 
  with GetSingleTickerProviderStateMixin{
  RxList<FriendRequest> sended = <FriendRequest>[].obs;
  RxList<FriendRequest> received = <FriendRequest>[].obs;
  Rx<AppState> sendedState = AppState.initial.obs;
  Rx<AppState> receivedState = AppState.initial.obs;
  late TabController tabController;
  SocketMethods socketMethods = Get.find<ChatController>().socketMethods;

  acceptFriend(int id) async {
    socketMethods.friendRequest(id, 2);
  }

  rejectFriend(int id) async {
    socketMethods.friendRequest(id, -1);
  }

  cancelFriend(int id) async {
    socketMethods.friendRequest(id, -2);
  }

  getSFR() async {
    try {
      sendedState(AppState.loading);
      var client = UserClient();
      var response = await client.getAllSendedFriendRequestStatus();
      sendedState(AppState.loaded);
      var list = <FriendRequest>[];
      for (var e in response) {
        if (e.status != 2) {
          list.add(e);
        }
      }
      sended(list);
    } catch (e) {
      sendedState(AppState.error);
    }
  }

  getRFR() async {
    try {
      var client = UserClient();
      var response = await client.getAllReceivedFriendRequestStatus();
      var list = <FriendRequest>[];
      for (var e in response) {
        if (e.status != 2) {
          list.add(e);
        }
      }
      received(list);
    } catch (e) {
      sendedState(AppState.error);
    }
  }

  @override
  Future<void> onInit() async {
    getRFR();
    getSFR();
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }
}