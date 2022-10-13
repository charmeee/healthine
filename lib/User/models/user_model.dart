class UserInfo {
  String? id;
  String? username;
  String? nickname;
  String? userEmail;
  String? ageRange;
  String? gender;
  UserInfo(
      {this.id,
      this.username,
      this.nickname,
      this.userEmail,
      this.ageRange,
      this.gender});
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        nickname = json['nickname'],
        userEmail = json['userEmail'],
        ageRange = json['ageRange'],
        gender = json['gender'];

  UserInfo.init() {
    id = null;
    username = null;
    nickname = null;
    userEmail = null;
    ageRange = null;
  }
}
