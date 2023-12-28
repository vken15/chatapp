import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/user/friend_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestController extends GetxController 
  with GetSingleTickerProviderStateMixin{
  RxList<FriendRequest> sended = <FriendRequest>[].obs;
  RxList<FriendRequest> received = <FriendRequest>[].obs;
  Rx<AppState> sendedState = AppState.initial.obs;
  Rx<AppState> receivedState = AppState.initial.obs;
  late TabController tabController;

  getSFR() async {
    try {
      sendedState(AppState.loading);
      var client = UserClient();
      var response = await client.getAllSendedFriendRequestStatus();
      sendedState(AppState.loaded);
      sended(response);
    } catch (e) {
      sendedState(AppState.error);
    }
  }

  getRFR() async {
    try {
      var client = UserClient();
      var response = await client.getAllReceivedFriendRequestStatus();
      received(response);
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