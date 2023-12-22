import 'dart:io';
import 'dart:typed_data';

import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:chatapp/src/presentations/profile/controllers/profile_controller.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChangePhotoController extends GetxController {
  final storage = const FlutterSecureStorage();
  Rx<File?> selectedImage = File('').obs;
  Rx<double> scale = 1.0.obs;
  Rx<double> previousScale = (-1.0).obs;
  ScrollController scrollController = ScrollController();
  Rx<AppState> screenState = AppState.initial.obs;
  double imageDisplay = 0;
  img.Image? image;
  RxBool scrollVertical = true.obs;

  void saveImage() async {
    // khởi tạo biến và tìm thư mục để lưu trữ
    screenState(AppState.loading);
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final String path = appDocumentDir.path;
    var uid = await storage.read(key: "userId");
    var userDao = UserDao();
    final user = await userDao.getById(int.parse(uid!));
    Uint8List bytes = File(selectedImage.value!.path).readAsBytesSync();
    image = img.decodeImage(bytes);

    // resize
    await resizeImage();

    // tính toán và cắt ảnh
    double muti = image!.height /
        (imageDisplay + scrollController.position.maxScrollExtent);
    int size = (image!.width).round();
    int x = 0;
    int y = 0;
    if (image!.width < image!.height) {
      y = (scrollController.position.pixels * muti).round();
    } else {
      x = (scrollController.position.pixels * muti).round();
    }
    image = img.copyCrop(image!, x: x, y: y, width: size, height: size);

    // print("${image.width} : $x");
    // print(muti);
    // print("${image.height} : $y");
    // print(imageDisplay);
    // print(savePath);

    // xóa file ảnh cũ nếu tồn tại
    if (user.photo != null) {
      File(user.photo!).delete();
      File(selectedImage.value!.path).delete();
    }

    // lưu file ảnh mới
    final savePath =
        '$path/${uid}_$x${y}_${basename(selectedImage.value!.path)}';
    final encodedImage =
        img.encodeNamedImage(selectedImage.value!.path, image!)!;
    File(savePath).writeAsBytesSync(encodedImage);
    user.photo = savePath;
    Get.find<ProfileController>().user.value.photo = savePath;
    await userDao.insertOrUpdate(user);

    // Gửi ảnh mới lên server
    try {
      var client = UserClient();
      client.updateUserProfile(
          imageName:
              '${uid}_$x${y}_${basenameWithoutExtension(selectedImage.value!.path)}',
          encodedImage: encodedImage);
    } catch (e) {
      print(e);
    }

    Get.offAndToNamed(AppRouter.homeScreen);
  }

  resizeImage() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final String path = appDocumentDir.path;
    Uint8List bytes = File(selectedImage.value!.path).readAsBytesSync();
    image = img.decodeImage(bytes);
    int resize = Get.width.toInt() - 20;
    if (image!.width < image!.height) {
      image = img.copyResize(image!, width: resize);
    } else {
      image = img.copyResize(image!, height: resize);
    }
    final savePath =
        '$path/${resize}x${resize}_${basename(selectedImage.value!.path)}';
    final encodedImage =
        img.encodeNamedImage(selectedImage.value!.path, image!)!;
    File(savePath).writeAsBytesSync(encodedImage);
    selectedImage(File(savePath));
  }

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments;
    selectedImage(File(args['image'].toString()));
    Uint8List bytes = File(selectedImage.value!.path).readAsBytesSync();
    image = img.decodeImage(bytes);
    if (image!.width > image!.height) scrollVertical(false);
    //await resizeImage();
    super.onInit();
  }
}
