class DictionaryData {
  int? id;
  String? name;
  String? enName;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;

  DictionaryData(
      {this.id,
      this.name,
      this.enName,
      this.type,
      this.difficulty,
      this.content,
      this.precautions});
  DictionaryData.fromJson(Map<String, dynamic> json)
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

class CommunityBoardData {
  String id;
  String nickname;
  String title;
  String content;
  List comment = [];
  String? type = "all";
  CommunityBoardData(
      {required this.id,
      required this.nickname,
      required this.title,
      required this.content,
      required this.comment,
      this.type});
  CommunityBoardData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        title = json['title'],
        content = json['content'],
        comment = json['comments'] ?? [],
        type = json['type'];
}

class CommunityBoardsList {
  //id list ,page,
  String id;
  String nickname;
  String title;
  String? type = "all";
  CommunityBoardsList(
      {required this.id,
      required this.nickname,
      required this.title,
      this.type = "all"});
  CommunityBoardsList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        title = json['title'],
        type = json['type'];
}

class RoutineData {
  String name;
  String type;
  int? set;
  int? num;
  int? weight;
  int? time; //분단뒤
  bool? doing = false;
  String? img;
  RoutineData(
      {required this.name,
      required this.type,
      this.set,
      this.num,
      this.weight,
      this.time,
      this.doing,
      this.img});
  RoutineData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        set = json['set'],
        num = json['num'],
        weight = json['weight'],
        time = json['time'],
        doing = json['doing'],
        img = json['img'];
}
