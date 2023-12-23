import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:get/get.dart';

class PhoneBookController extends GetxController {
  RxList<UserInfo> friendList = <UserInfo>[].obs;

}