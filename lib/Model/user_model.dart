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
