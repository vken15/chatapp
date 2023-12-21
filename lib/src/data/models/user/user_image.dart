class UserImage {
  String? imageName;
  String? encodedImage;

  UserImage({
    this.imageName,
    this.encodedImage,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        imageName: json["imageName"],
        encodedImage: json["encodedImage"],
      );

  Map<String, dynamic> toJson() => {
        "imageName": imageName,
        "encodedImage": encodedImage,
      };
}
