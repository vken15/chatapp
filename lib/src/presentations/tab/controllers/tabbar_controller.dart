import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController with GetSingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  Rx<String> userToken = "".obs;
  Rx<bool> isSearch = false.obs;
  Rx<TextEditingController> searchContent = Rx(TextEditingController());
  
  final FocusNode searchTextFocus = FocusNode();

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Home'),
    const Tab(text: 'Profile'),
  ];

  late TabController tabController;

  Future<void> getToken() async {
    var token = await storage.read(key: "UserToken");
    userToken(token);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    getToken();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}