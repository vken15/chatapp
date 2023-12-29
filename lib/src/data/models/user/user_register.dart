class UserRegister {
  String? fullName;
  String? username;
  String? password;

  UserRegister({this.fullName, this.username, this.password});

  UserRegister.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
