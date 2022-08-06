class Exercise {
  int? id;
  String? name;
  String? enName;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;

  Exercise(this.id, this.name, this.enName, this.type, this.difficulty,
      this.content, this.precautions);
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
    this.id,
    this.username,
    this.password,
    this.name,
    this.nickname,
    this.phoneNumber,
    this.avatarImage,
  );
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        name = json['name'],
        nickname = json['nickname'],
        phoneNumber = json['phoneNumber'],
        avatarImage = json['avatarImage'];
}

class UserExerciseData {
  //time 단위는 초
  String name;
  int numPerSet;
  int totalSet;
  int doingSet;
  int restTime; //단위 초
  int countInterver; //단위 초
  int totalTime;
  int totalnum;

  UserExerciseData(
      {this.name = '',
      this.numPerSet = 3, //세트당 개수
      this.totalSet = 3,
      this.doingSet = 1,
      this.restTime = 3,
      this.countInterver = 3,
      this.totalTime = 0,
      this.totalnum = 0 //한총개수
      });
}
