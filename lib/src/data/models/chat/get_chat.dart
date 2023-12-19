import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';

class GetChats {
  int? id;
  String? chatName;
  bool? isGroupChat;
  ReceivedMessage? latestMessage;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<UserInfo>? users;

  GetChats({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.latestMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  GetChats.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    chatName = json["chatName"];
    isGroupChat = json["isGroupChat"];
    latestMessage = List<ReceivedMessage>.from(
                    json["Messages"].map((x) => ReceivedMessage.fromJson(x)))
                .length ==
            1
        ? List<ReceivedMessage>.from(
            json["Messages"].map((x) => ReceivedMessage.fromJson(x))).first
        : null;
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
    users = List<UserInfo>.from(json["Users"].map((x) => UserInfo.fromJson(x)));
  }

  GetChats.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    chatName = json["chatName"];
    isGroupChat = json["isGroupChat"];
    latestMessage = json["latestMessage"] != null
        ? ReceivedMessage.fromJson(json["latestMessage"])
        : null;
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
    users = List<UserInfo>.from(json["Users"].map((x) => UserInfo.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "latestMessage": latestMessage?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}