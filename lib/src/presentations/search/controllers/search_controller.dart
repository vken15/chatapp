import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<bool> isSearch = false.obs;
  Rx<TextEditingController> searchContent = Rx(TextEditingController());
  RxList<UserInfo> result = <UserInfo>[].obs;
  RxInt userId = 0.obs;
  final FocusNode searchTextFocus = FocusNode();

  Future search() async {
    if (searchContent.value.text == "") return;
    try {
      var client = UserClient();
      var response = await client.getListUserByName(searchValue: searchContent.value.text);
      result.assignAll(response);
      result.refresh();
      print(result.first.fullName);
    }
    catch (e) {
      print(e);
    }
  }

  void getUserId() async {
    var uid = await storage.read(key: "userId");
    userId(int.parse(uid!));
  }

  @override
  void onInit() {
    super.onInit();
    getUserId();
    searchTextFocus.requestFocus();
  }
}
