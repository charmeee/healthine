class Exercise {
  int? id;
  String? name;
  String? enName;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;

  Exercise(
      {this.id,
      this.name,
      this.enName,
      this.type,
      this.difficulty,
      this.content,
      this.precautions});
  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        enName = json['enName'],
        type = json['type'],
        difficulty = json['difficulty'],
        content = json['content'],
        precautions = json['precautions'];
}

class UserInfo {
  String? id;
  String? username;
  String? name;
  String? password;
  String? nickname;
  String? phoneNumber;
  String? avatarImage;

  UserInfo(
      {this.id,
      this.username,
      this.password,
      this.name,
      this.nickname,
      this.phoneNumber,
      this.avatarImage});
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      nickname: json['nickname'],
      phoneNumber: json['phoneNumber'],
      avatarImage: json['avatarImage'],
    );
  }
}

class UserExercised {
  String? exercisename;
  String? count;
  String? set;

  UserExercised({
    this.exercisename,
    this.count,
    this.set,
  });
}
