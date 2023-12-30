import 'dart:io';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/models/user/friend_request.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/presentations/phonebook/controllers/friend_request_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestScreen extends GetWidget<FriendRequestController> {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lời mời kết bạn"),
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Obx(
                () => TabBar(
                  controller: controller.tabController,
                  tabs: <Tab>[
                    Tab(
                        text:
                            "Đã nhận ${controller.received.isEmpty ? "" : "${controller.received.length}"}"),
                    Tab(
                        text:
                            "Đã gửi ${controller.sended.isEmpty ? "" : "${controller.sended.length}"}"),
                  ],
                  unselectedLabelColor:
                      context.isDarkMode ? Colors.white54 : Colors.black54,
                  labelColor: context.isDarkMode ? Colors.white : Colors.black,
                  indicatorColor:
                      context.isDarkMode ? Colors.white : Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 550,
                ),
                child: Obx(
                  () => TabBarView(
                    controller: controller.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildFriendRequestView(controller.received, false),
                      _buildFriendRequestView(controller.sended, true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildFriendRequestView(RxList<FriendRequest> list, bool sender) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              var user = UserInfo(
                id: list[index].id,
                fullName: list[index].fullName,
                photo: list[index].photo,
                photoStored: list[index].photoStored,
              );
              Get.toNamed(AppRouter.otherProfileScreen, arguments: {
                'user': user,
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: list[index].photo == null
                      ? const AssetImage("assets/images/blank-profile.png")
                      : list[index].photoStored == true
                          ? FileImage(File(list[index].photo!))
                              as ImageProvider<Object>
                          : NetworkImage(
                              "${AppEndpoint.APP_URL}${AppEndpoint.USER_PHOTO_API}/${list[index].photo!}.png"),
                ),
                title: Text(list[index].fullName!),
                trailing: sender
                    ? ElevatedButton(
                        onPressed: () {
                          controller.cancelFriend(list[index].id!);
                        },
                        child: const Text("Thu hồi"))
                    : ElevatedButton(
                        onPressed: () {
                          controller.acceptFriend(list[index].id!);
                        },
                        child: const Text("Đồng ý")),
              ),
            ),
          );
        });
  }
}
