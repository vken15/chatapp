import 'dart:convert';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/chat/create_chat.dart';
import 'package:chatapp/src/data/models/chat/get_chat.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatClient extends BaseClient {

  ///
  Future<GetChats> accessChat(CreateChat model) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.CHAT_API}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(model.toJson())
    );

    if (response.statusCode == 200) {
      return GetChats.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception("Failded to access chat");
    }
  }

  ///
  Future<List<GetChats>> getConversations() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.CHAT_API}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return List<GetChats>.from(json.decode(response.body).map((x) => GetChats.fromJson(x)));
    } else {
      throw Exception("Failded to load chats");
    }
  }
}
