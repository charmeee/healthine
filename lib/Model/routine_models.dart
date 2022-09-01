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
