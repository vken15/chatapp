import 'dart:io';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/presentations/phonebook/controllers/phonebook_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneBookScreen extends GetWidget<PhoneBookController> {
  const PhoneBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: () {
                Get.toNamed(AppRouter.friendRequestScreen);
              },
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                leading: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text("Lời mời kết bạn"),
              ),
            ),
            Container(
                color: context.isDarkMode
                    ? Colors.black
                    : const Color.fromARGB(255, 240, 239, 239),
                height: 10),
            Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Row(
                  children: [
                    _buildButtonCustom(
                      context,
                      "Tất cả ${controller.friendList.length}",
                      () {
                        controller.show(false);
                      },
                      !controller.show.value,
                    ),
                    const SizedBox(width: 12),
                    _buildButtonCustom(
                      context,
                      "Mới truy cập ${controller.onlinefriendList.length}",
                      () {
                        controller.show(true);
                      },
                      controller.show.value,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: Obx(
                () => controller.show.value
                    ? _buildListFriend(controller.onlinefriendList)
                    : _buildListFriend(controller.friendList),
              ),
            )
          ],
        ),
      ),
    );
  }

  OutlinedButton _buildButtonCustom(BuildContext context, String text, Function()? onPressed, bool select) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: context.isDarkMode ? Colors.white : Colors.black,
          backgroundColor: select == true ? const Color.fromARGB(95, 109, 104, 104) : null,
        ),
        onPressed: onPressed,
        child: Text(text));
  }

  ListView _buildListFriend(List<UserInfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
        );
      },
    );
  }
}
