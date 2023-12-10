class UserRegister {
  String? fullName;
  String? username;
  String? password;

  UserRegister({this.username, this.password, required String fullName});

  UserRegister.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullName;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
