class FriendRequest {
  int? id;
  String? fullName;
  String? photo;
  bool photoStored = false;
  int status = 0;

  FriendRequest(
      {
      this.id,
      this.fullName,
      this.photo,
      this.photoStored = false,
      this.status = 0,
      });

  FriendRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    photo = json['photo'];
    photoStored = json['photoStored'] ?? photoStored;
    status = json['Friend']['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['photo'] = photo;
    data['photoStored'] = photoStored;
    data['status'] = status;
    return data;
  }
}
