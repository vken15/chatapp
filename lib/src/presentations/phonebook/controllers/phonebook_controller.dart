import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:get/get.dart';

class PhoneBookController extends GetxController {
  RxList<UserInfo> friendList = <UserInfo>[].obs;
  RxList<UserInfo> onlinefriendList = <UserInfo>[].obs;
  List<int> online = [];
  RxBool show = false.obs;

  void getListFriend() async {
    try {
      var client = UserClient();
      var response = await client.getFriendList();
      friendList.assignAll(response);
      getOnlineFriend();
    } catch (e) {
      print(e);
    }
  }

  void getOnlineFriend() {
    onlinefriendList(<UserInfo>[]);
    for (var friend in friendList) {
      if (online.contains(friend.id)) {
        onlinefriendList.add(friend);
      }
    }
  }

  @override
  void onInit() {
    getListFriend();
    super.onInit();
  }
}