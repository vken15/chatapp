import 'package:chatapp/src/presentations/home/home_screen.dart';
import 'package:chatapp/src/presentations/setting/setting_screen.dart';
import 'package:chatapp/src/presentations/tabs/controllers/tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTabBar extends GetWidget<TabBarController> {
  const AppTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: controller.isSearch.value
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    controller.isSearch.value = false;
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
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
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.orange, Colors.yellow]),
            ),
          ),
        ),
        body: controller.isSearch.value
            ? Center()
            : TabBarView(
                controller: controller.tabController,
                children: const [
                  HomeScreen(),
                  SettingScreen(),
                ],
              ),
        bottomNavigationBar: ColoredBox(
          color: Colors.blue,
          child: TabBar(
            controller: controller.tabController,
            tabs: controller.tabs,
            indicatorColor: Colors.white,
            onTap: (value) {
              //controller.isSearch.value = false;
            },
          ),
        ),
      ),
    );
  }
}
