import 'dart:convert';
import 'dart:typed_data';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/user/user_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserClient extends BaseClient {
  Future<String> updateUserProfile(
      {required String imageName, required Uint8List encodedImage}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.USER_UPLOAD_PHOTO_URL}";
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
}
