class CreateChat {
  int userId;

  CreateChat({
    required this.userId,
  });

  factory CreateChat.fromJson(Map<String, dynamic> json) => CreateChat(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}
