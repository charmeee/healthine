class UserInfo {
  String? id;
  String? username;
  String? name;
  String? nickname;
  String? phoneNumber;
  String? avatarImage;
  String? accessToken;
  UserInfo({
    this.id,
    this.username,
    this.name,
    this.nickname,
    this.phoneNumber,
    this.avatarImage,
    this.accessToken,
  });
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        name = json['name'],
        nickname = json['nickname'],
        phoneNumber = json['phoneNumber'],
        avatarImage = json['avatarImage'],
        accessToken = json['accessToken'];
}
