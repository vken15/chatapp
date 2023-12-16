class UserInfo {
  int? id;
  bool? success;
  String? token;
  String? message;
  String? fullName;
  String? username;

  UserInfo(
      {
      this.id,
      this.success,
      this.token,
      this.message,
      this.fullName,
      this.username,
      });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    success = json['success'];
    token = json['token'];
    message = json['message'];
    fullName = json['fullName'];
    username = json['username'];
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
    return data;
  }
}
