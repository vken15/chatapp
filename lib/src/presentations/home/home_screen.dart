import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/presentations/home/controllers/home_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.screenState.value == AppState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.screenState.value == AppState.error) {
          return const Center(child: Text("Error"));
        } else if (controller.screenState.value == AppState.empty) {
          return const Center(child: Text("No chat avaliable"));
        } else {
          return _buildChatList();
        }
      }),
    );
  }

  ListView _buildChatList() {
    return ListView.builder(
      itemCount: controller.chatList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Get.toNamed(AppRouter.chatboxScreen, arguments: {
            'title': controller.chatList[index].chatName!,
            'id': controller.chatList[index].id!,
            'photo': "",
            'users': controller.chatList[index].users!
                .map((user) => user.id!)
                .toList()
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            leading: CircleAvatar(
              radius: 20,
              //backgroundImage: ,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.chatList[index].chatName!),
                Text(
                  controller.chatList[index].latestMessage!.content!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.msgTime(controller
                    .chatList[index].latestMessage!.updatedAt
                    .toString())),
                //Text(controller.chatList[index].latestMessage!.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
