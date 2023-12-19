class InitialChat {
  int id;

  InitialChat({
    required this.id,
  });

  factory InitialChat.fromJson(Map<String, dynamic> json) => InitialChat(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
