import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final List<Tab> tabs = <Tab>[
    const Tab(icon: Icon(Icons.chat_outlined), iconMargin: EdgeInsets.zero,),
    const Tab(icon: Icon(Icons.people_alt_outlined), iconMargin: EdgeInsets.zero,),
    const Tab(icon: Icon(Icons.person_outline_sharp), iconMargin: EdgeInsets.zero,),
  ];

  late TabController tabController;

  // Future<void> hasNetwork() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }
  // }

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    //hasNetwork();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
