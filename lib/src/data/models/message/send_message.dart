class SendMessage {
    int senderId;
    String content;
    int receiverId;
    int chatId;

    SendMessage({
        required this.senderId,
        required this.content,
        required this.receiverId,
        required this.chatId,
    });

    factory SendMessage.fromJson(Map<String, dynamic> json) => SendMessage(
        senderId: json["senderId"],
        content: json["content"],
        receiverId: json["receiverId"],
        chatId: json["chatId"],
    );

    Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "content": content,
        "receiverId": receiverId,
        "chatId": chatId,
    };
}