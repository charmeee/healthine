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

class CommunityData {
  int id;
  String nickname;
  String title;
  Map<String, String?> content = {"text": null, "img": null};
  List? comment;
  String? type = "all";
  CommunityData(
      {required this.id,
      required this.nickname,
      required this.title,
      required this.content,
      this.comment,
      this.type});
}
