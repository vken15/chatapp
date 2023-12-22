import 'package:chatapp/src/presentations/chat/chat_screen.dart';
import 'package:chatapp/src/presentations/phonebook/phonebook_screen.dart';
import 'package:chatapp/src/presentations/profile/profile_screen.dart';
import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTabBar extends GetWidget<HomeController> {
  const AppTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: controller.isSearch.value
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    controller.isSearch.value = false;
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search, color: Colors.white,),
                  onPressed: () {
                    controller.isSearch.value = true;
                    controller.searchTextFocus.requestFocus();
                  },
                ),
          title: TextFormField(
              controller: controller.searchContent.value,
              focusNode: controller.searchTextFocus,
              onTap: () {
                controller.isSearch.value = true;
              },
              onTapOutside: (event) {
                if (controller.searchTextFocus.hasFocus == true) {
                  controller.searchTextFocus.unfocus();
                  //controller.isSearch.value = false;
                }
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white,),
              onPressed: () {
                Get.toNamed(AppRouter.settingScreen);
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
            ),
          ),
        ),
        body: controller.isSearch.value
            ? const Center()
            : TabBarView(
                controller: controller.tabController,
                children: const [
                  HomeScreen(),
                  PhoneBookScreen(),
                  ProfileScreen(),
                ],
              ),
        bottomNavigationBar: TabBar(
          controller: controller.tabController,
          tabs: controller.tabs,
          indicatorColor: Colors.white,
          onTap: (value) {
            //controller.isSearch.value = false;
          },
        ),
      ),
    );
  }
}
