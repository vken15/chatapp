import 'dart:convert';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/data/models/user/user_register.dart';
import 'package:http/http.dart' as http;

class RegisterClient extends BaseClient {
  Future<UserInfo> register(
      {required String fullName, required String username, required String password}) async {
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.REGISTER_URL}";
    var data = UserRegister(fullName: fullName, username: username, password: password);
    //var response = await http.post(url, data.toJson());
    var response = await http.post(Uri.parse(url), body: data.toJson());
    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Tên người dùng đã tồn tại!");
    }
  }
}
