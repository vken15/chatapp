import 'dart:io';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/presentations/phonebook/controllers/phonebook_controller.dart';
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
              onTap: () {},
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Tất cả")),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Mới truy cập")),
                ],
              ),
            ),
            const Divider(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.friendList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: controller.friendList[index].photo == null
                          ? null
                          : controller.friendList[index].photoStored == true
                              ? FileImage(File(controller.friendList[index].photo!))
                                  as ImageProvider<Object>
                              : NetworkImage(
                                  "${AppEndpoint.APP_URL}${AppEndpoint.USER_PHOTO_API}/${controller.friendList[index].photo!}.png"),
                      ),
                      title: Text(controller.friendList[index].fullName!),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
