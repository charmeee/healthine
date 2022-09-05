class RoutineData {
  String name;
  String type;
  bool doing = false;
  String? img;

  //유산소
  int totalTime; //분단뒤 유산소일때 사용

  //근력운동
  int totalSet; //전체세트
  int numPerSet; //세트당 횟수
  int weight; //근력운동일때만 사용

  RoutineData(
      {required this.name,
      required this.type,
      this.totalSet = 3,
      this.numPerSet = 10,
      this.weight = 10,
      this.totalTime = 10,
      this.doing = false,
      this.img});
  RoutineData.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        type = json['type'] ?? "",
        totalSet = json['set'] ?? 3,
        numPerSet = json['num'] ?? 10,
        weight = json['weight'] ?? 10,
        totalTime = json['time'] ?? 10,
        doing = json['doing'] ?? false,
        img = json['img'];

  // RoutineData.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       type = json['type'],
  //       totalSet = json['set'],
  //       numPerSet = json['num'],
  //       weight = json['weight'],
  //       totalTime = json['time'],
  //       doing = json['doing'] ?? false,
  //       img = json['img'];

  putAerobicRoutine({name, type, totalTime, img}) {
    //유산소일때
    this.name = name;
    this.type = type;
    this.totalTime = totalTime ?? 10;
    this.img = img;
  }

  putWeightRoutine({name, type, totalSet, numPerSet, weight, img}) {
    //근력운동일때
    this.name = name;
    this.type = type;
    this.totalSet = totalSet ?? 3;
    this.numPerSet = numPerSet ?? 10;
    this.weight = weight ?? 10;
    this.img = img;
  }
}
