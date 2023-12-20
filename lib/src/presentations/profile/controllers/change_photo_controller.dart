import 'dart:io';

import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChangePhotoController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<File?> selectedImage = File('').obs;

  void saveImage() async {
    // getting a directory path for saving
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final String path = appDocumentDir.path;
    var uid = await storage.read(key: "userId");
    var userDao = UserDao();
    final user = await userDao.getById(int.parse(uid!));
    // copy the file to a new path
    final File newImage =
        await selectedImage.value!.copy('$path/${basename(selectedImage.value!.path)}');
    print(basename(newImage.path));
    user.photo = newImage.path;
    Get.find<ProfileController>().user.value.photo = newImage.path;
    await userDao
        .insertOrUpdate(user)
        .then((value) => Get.offAndToNamed(AppRouter.tabScreen));
  }

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments;
    selectedImage.value = File(args['image'].toString());
    super.onInit();
  }
}
