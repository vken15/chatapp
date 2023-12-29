import 'dart:convert';

import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:chatapp/src/data/apiClient/base_client.dart';
import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/models/message/send_message.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessageClient extends BaseClient {

  ///
  Future<List<dynamic>> sendMessage(SendMessage model) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.MESSAGE_API}";
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
      ReceivedMessage message = ReceivedMessage.fromJson(jsonDecode(response.body));
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      return [true, message, responseBody];
    } else {
      return [false];
    }
  }

  ///
  Future<List<ReceivedMessage>> getMessages(int chatId, int offset) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}${AppEndpoint.MESSAGE_API}/$chatId?page=$offset";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return List<ReceivedMessage>.from(json.decode(response.body).map((x) => ReceivedMessage.fromJson(x)));
    } else {
      throw Exception("Failded to load messages");
    }
  }

  Future<bool> sendNotify(SendMessage model) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "UserToken");
    var url = "${AppEndpoint.APP_URL}/api/notify/send";
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
      return true;
    } else {
      return false;
    }
  }
}
