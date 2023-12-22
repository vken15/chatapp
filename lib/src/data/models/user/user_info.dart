class UserInfo {
  int? id;
  bool? success;
  String? token;
  String? message;
  String? fullName;
  String? username;
  String? photo;
  String? lastOnline;
  bool photoStored = false;

  UserInfo(
      {
      this.id,
      this.success,
      this.token,
      this.message,
      this.fullName,
      this.username,
      this.photo,
      this.lastOnline,
      this.photoStored = false,
      });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    success = json['success'];
    token = json['token'];
    message = json['message'];
    fullName = json['fullName'];
    username = json['username'];
    photo = json['photo'];
    lastOnline = json['lastOnline'];
    photoStored = json['photoStored'] ?? photoStored;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['success'] = success;
    data['token'] = token;
    data['message'] = message;
    //data['RefreshToken'] = refreshToken;
    data['fullName'] = fullName;
    data['username'] = username;
    data['photo'] = photo;
    data['lastOnline'] = lastOnline;
    data['photoStored'] = photoStored;
    return data;
  }
}
