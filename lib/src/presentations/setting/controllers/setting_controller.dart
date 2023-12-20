import 'package:chatapp/src/data/local/dao/chat_dao.dart';
import 'package:chatapp/src/data/local/dao/message_dao.dart';
import 'package:chatapp/src/data/local/dao/user_dao.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final storage = const FlutterSecureStorage();
  logout() async {
    storage.delete(key: "UserToken");
    storage.delete(key: "userId");
    await UserDao().deleteAll();
    await ChatDao().deleteAll();
    await MessageDao().deleteAll();
    Get.offAndToNamed(AppRouter.loginScreen);
  }
}