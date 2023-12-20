import 'dart:io';

import 'package:chatapp/src/components/profile_appbar.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileAppBar(
                  expandedHeight: 250,
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red,
                          backgroundImage: controller.user.value.photo == null
                              ? null
                              : FileImage(File(controller.user.value.photo!)),
                        ),
                      ),
                      Text(
                        controller.user.value.fullName ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundImage: Image.network(
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    fit: BoxFit.cover,
                  ),
                  avatarImage: controller.user.value.photo == null
                              ? null
                              : FileImage(File(controller.user.value.photo!)),
                  onAvatarTap: () {
                    controller.pickImage();
                  }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 55),
                child: Center(
                  child: Text(
                    controller.user.value.fullName ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                controller: controller.tabController,
                tabs: controller.tabs,
                unselectedLabelColor:
                    context.isDarkMode ? Colors.white54 : Colors.black54,
                labelColor: context.isDarkMode ? Colors.white : Colors.black,
                indicatorColor:
                    context.isDarkMode ? Colors.white : Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 550,
                ),
                child: TabBarView(
                  controller: controller.tabController,
                  children: const [
                    Center(),
                    Center(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
