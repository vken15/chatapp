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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
            onTap: () {
              Get.toNamed(AppRouter.searchScreen);
            },
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  "Tìm kiếm",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed(AppRouter.settingScreen);
            },
          ),
        ],
        titleSpacing: 18,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: context.isDarkMode ? [const Color.fromARGB(96, 43, 42, 42), const Color.fromARGB(96, 43, 42, 42)] : 
                [const Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          HomeScreen(),
          PhoneBookScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: context.isDarkMode ? const Color.fromARGB(95, 109, 104, 104) : Colors.white.withOpacity(0.5),
        child: TabBar(
          controller: controller.tabController,
          tabs: controller.tabs,
          indicatorColor: Colors.white,
        ),
      ),
    );
  }
}
