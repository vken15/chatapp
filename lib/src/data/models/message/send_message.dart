class SendMessage {
  String content;
  int receiverId;
  int chatId;

  SendMessage({
    required this.content,
    required this.receiverId,
    required this.chatId,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) => SendMessage(
        content: json["content"],
        receiverId: json["receiverId"],
        chatId: json["chatId"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "receiverId": receiverId,
        "chatId": chatId,
      };
}
