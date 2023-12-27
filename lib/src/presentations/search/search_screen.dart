import 'dart:io';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/presentations/search/controllers/search_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetWidget<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: TextField(
          controller: controller.searchContent.value,
          focusNode: controller.searchTextFocus,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(color: Colors.white),
          ),
          onSubmitted: (value) {
            controller.search();
            print("search");
          },
          onChanged: (value) {
            controller.search();
            print("change");
          },
        ),
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.result.length,
          itemBuilder: (context, index) {
            return controller.result[index].id != controller.userId.value ? InkWell(
              onTap: () {
                Get.toNamed(AppRouter.otherProfileScreen, 
                arguments: {
                  'user': controller.result[index],
                });
              },
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: controller.result[index].photo == null
                      ? null
                      : controller.result[index].photoStored == true
                          ? FileImage(File(controller.result[index].photo!))
                              as ImageProvider<Object>
                          : NetworkImage(
                              "${AppEndpoint.APP_URL}${AppEndpoint.USER_PHOTO_API}/${controller.result[index].photo!}.png"),
                ),
                title: Text(controller.result[index].fullName!),
              ),
            ) : const SizedBox();
          },
        ),
      ),
    );
  }
}
