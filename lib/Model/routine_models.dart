import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum routineStatus {
  before,
  doing,
  done;

  factory routineStatus.getByString(String str) {
    return routineStatus.values
        .firstWhere((value) => value == str, orElse: () => routineStatus.doing);
  }
}

class RoutineData {
  var id = uuid.v1();
  var userExerciseId;
  String name;
  String type;
  routineStatus status = routineStatus.before;
  String? img;

  //유산소
  int totalTime; //분단뒤 유산소일때 사용

  //근력운동
  int totalSet; //전체세트
  int numPerSet; //세트당 횟수
  int weight; //근력운동일때만 사용

  RoutineData({
    required this.name,
    required this.type,
    this.totalSet = 3,
    this.numPerSet = 10,
    this.weight = 10,
    this.totalTime = 10,
    this.img,
    this.userExerciseId,
    this.status = routineStatus.before,
  });
  RoutineData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? "",
        type = json['type'] ?? "",
        totalSet = json['set'] ?? 3,
        numPerSet = json['num'] ?? 10,
        weight = json['weight'] ?? 10,
        totalTime = json['time'] ?? 10,
        img = json['img'];

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
