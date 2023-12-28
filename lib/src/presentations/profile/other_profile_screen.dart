import 'dart:io';

import 'package:chatapp/src/components/profile_appbar.dart';
import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/presentations/profile/controllers/other_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO:
class OtherProfileScreen extends GetWidget<OtherProfileController> {
  const OtherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileAppBar(
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                expandedHeight: 250,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                        backgroundImage: controller.user.value.photo == null
                            ? const AssetImage(
                                "assets/images/blank-profile.png")
                            : controller.user.value.photoStored == true
                                ? FileImage(File(controller.user.value.photo!))
                                    as ImageProvider<Object>
                                : NetworkImage(
                                    "${AppEndpoint.APP_URL}${AppEndpoint.USER_PHOTO_API}/${controller.user.value.photo}.png"),
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
                    ? const AssetImage("assets/images/blank-profile.png")
                    : controller.user.value.photoStored == true
                        ? FileImage(File(controller.user.value.photo!))
                            as ImageProvider<Object>
                        : NetworkImage(
                            "${AppEndpoint.APP_URL}${AppEndpoint.USER_PHOTO_API}/${controller.user.value.photo}.png"),
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.friendStatus.value == 0
                      ? ElevatedButton(
                          onPressed: () {
                            controller.addFriend();
                          },
                          child: const Text("Kết bạn"),
                        )
                      : controller.friendStatus.value == 1
                          ? ElevatedButton(
                              onPressed: () {
                                //controller.addFriend();
                              },
                              child: const Text("Thu hồi"),
                            )
                          : controller.friendStatus.value == 2 ? ElevatedButton(
                              onPressed: () {
                                //controller.addFriend();
                              },
                              child: const Text("Hủy kết bạn"),
                            ) : const SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      controller.accessChat();
                    },
                    child: const Text("Nhắn tin"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
