import 'dart:io';

import 'package:chatapp/src/data/apiClient/image/image_client.dart';
import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  final List<Tab> tabs = <Tab>[
    const Tab(icon: Icon(Icons.grid_on, size: 28)),
    const Tab(icon: Icon(Icons.person_pin_outlined, size: 32)),
  ];
  late TabController tabController;
  Rx<UserInfo> user = UserInfo().obs;

  void getUser() async {
    var uid = await storage.read(key: "userId");
    try {
      user.value = await UserDao().getById(int.parse(uid!));
      loadImage();
    } catch (e) {
      print("User not exist!");
    }
  }

  loadImage() async {
    if (user.value.photo != null) {
      var appDocumentDir = await getApplicationDocumentsDirectory();
      final String path = appDocumentDir.path;
      final savePath = '$path/${basename(user.value.photo!)}';
      if (await File(savePath).exists() == false) {
        var client = ImageClient();
        var response = await client.getImage(imageURL: user.value.photo!);
        File(savePath).writeAsBytesSync(response);
        user.value.photo = savePath;
        user.value.photoStored = true;
        await UserDao().insertOrUpdate(user.value);
      } else if ('$path/${basename(user.value.photo!)}' != user.value.photo!) {
        user.value.photo = savePath;
        user.value.photoStored = true;
        await UserDao().insertOrUpdate(user.value);
      }
    }
  }

  Future pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        Get.toNamed(AppRouter.changePhotoScreen,
            arguments: {'image': image.path});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    getUser();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
