import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  final List<Tab> tabs = <Tab>[
    const Tab(icon: Icon(Icons.grid_on, size: 28)),
    const Tab(icon: Icon(Icons.person_pin_outlined, size: 32)),
  ];
  late TabController tabController;
  Rx<UserInfo> user = UserInfo().obs;
  //Rx<File?> selectedImage = null.obs;

  void getUser() async {
    var uid = await storage.read(key: "userId");
    try {
      user.value = await UserDao().getById(int.parse(uid!));
    } catch (e) {
      print("User not exist!");
    }
  }

  Future pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        //selectedImage.value = File(image.path);
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
