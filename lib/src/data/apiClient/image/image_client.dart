import 'dart:typed_data';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ImageClient extends BaseClient {
  Future<Uint8List> getImage({required String imageURL}) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url =
        '${AppEndpoint.APP_URL}/image/users/${basenameWithoutExtension(imageURL)}.png';
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Lỗi ${response.statusCode}");
    }
  }
}
