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
        latestMessage = ReceivedMessage.fromJson(json["Message"]);
        createdAt = DateTime.parse(json["createdAt"]);
        updatedAt = DateTime.parse(json["updatedAt"]);
        users = List<UserInfo>.from(json["Users"].map((x) => UserInfo.fromJson(x)));
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "latestMessage": latestMessage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Users": List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

// class User {
//     int? id;
//     String? fullName;
//     String? username;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     User({
//         required this.id,
//         required this.fullName,
//         required this.username,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     User.fromJson(Map<String, dynamic> json) {
//         id = json["id"];
//         fullName = json["fullName"];
//         username = json["username"];
//         createdAt = DateTime.parse(json["createdAt"]);
//         updatedAt = DateTime.parse(json["updatedAt"]);
//     }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "fullName": fullName,
//         "username": username,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//     };
// }