import 'dart:convert';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/data/models/user/user_payload.dart';
import 'package:http/http.dart' as http;

class AuthClient extends BaseClient {
  Future<UserInfo> login(
      {required String username, required String password}) async {
    var url = "${AppEndpoint.PRODUCT_URL}${AppEndpoint.authURL}";
    var user = UserPayload(username: username, password: password);
    var response = await http.post(Uri.parse(url), body: user.toJson());
    print("B2");
    if (response.statusCode == 200) {
      print("B3");
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      print("Faild");
      throw Exception("Username or password don't exist");
    }
  }
}
