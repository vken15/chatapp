import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController with GetSingleTickerProviderStateMixin {
  Rx<bool> isSearch = false.obs;
  Rx<TextEditingController> searchContent = Rx(TextEditingController());
  
  final FocusNode searchTextFocus = FocusNode();

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Home'),
    const Tab(text: 'Profile'),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}