import 'dart:convert';
import 'dart:typed_data';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/user/friend_request.dart';
import 'package:chatapp/src/data/models/user/user_image.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserClient extends BaseClient {
  Future<String> updateUserProfile(
      {required String imageName, required Uint8List encodedImage}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.USER_UPLOAD_PHOTO_API}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var userImage = UserImage(
        imageName: imageName, encodedImage: base64Encode(encodedImage));
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(userImage.toJson()),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<List<UserInfo>> getFriendList() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.FRIEND_API}/";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return List<UserInfo>.from(json.decode(response.body).map((x) => UserInfo.fromJson(x)));
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<List<UserInfo>> getListUserByName({required String searchValue}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.USER_SEARCH_API}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map<String, dynamic> body = <String, dynamic>{};
    body["searchValue"] = searchValue;
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return List<UserInfo>.from(json.decode(response.body).map((x) => UserInfo.fromJson(x)));
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<int> getFriendRequestStatus({required int id}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.FRIEND_API}/$id";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<List<FriendRequest>> getAllSendedFriendRequestStatus() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.FRIEND_API}/sended";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers
    );
    if (response.statusCode == 200) {
      return List<FriendRequest>.from(json.decode(response.body).map((x) => FriendRequest.fromJson(x)));
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<List<FriendRequest>> getAllReceivedFriendRequestStatus() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.FRIEND_API}/received";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers
    );
    if (response.statusCode == 200) {
      return List<FriendRequest>.from(json.decode(response.body).map((x) => FriendRequest.fromJson(x)));
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }

  Future<String> storeToken(
      {required String fCMToken}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}/api/notify/store";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map<String, dynamic> body = <String, dynamic>{};
    body["token"] = fCMToken;
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }
}
