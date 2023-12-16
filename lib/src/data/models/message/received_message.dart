class ReceivedMessage {
    int? id;
    String? content;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? senderId;
    int? receiverId;
    int? chatId;

    ReceivedMessage({
        required this.id,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
        required this.senderId,
        required this.receiverId,
        required this.chatId,
    });

    factory ReceivedMessage.fromJson(Map<String, dynamic> json) => ReceivedMessage(
        id: json["id"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        chatId: json["chatId"],
    );
}