class RoutineData {
  String name;
  String type;
  int? totalSet; //전체세트
  int? numPerSet; //세트당 횟수
  int? weight; //근력운동일때만 사용
  int? totalTime; //분단뒤 유산소일때 사용
  bool? doing = false;
  String? img;
  RoutineData(
      {required this.name,
      required this.type,
      this.totalSet,
      this.numPerSet,
      this.weight,
      this.totalTime,
      this.doing,
      this.img});
  RoutineData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        totalSet = json['set'],
        numPerSet = json['num'],
        weight = json['weight'],
        totalTime = json['time'],
        doing = json['doing'],
        img = json['img'];
}
