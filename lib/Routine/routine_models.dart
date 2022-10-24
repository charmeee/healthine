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

class Routine {
  String id;
  String title;
  String description;
  List<int> day;
  String access;
  String author;
  String owner;
  List<String> type;
  List<RoutineManual> routineManuals;

  Routine({
    required this.id,
    required this.title,
    required this.description,
    required this.day,
    required this.access,
    required this.author,
    required this.owner,
    required this.type,
    required this.routineManuals,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      day: json['day'],
      access: json['access'],
      author: json['author'],
      owner: json['owner'],
      type: json['type'],
      routineManuals: (json['routineManuals'] as List<dynamic>)
          .map((e) => RoutineManual.fromJson(e))
          .toList(),
    );
  }
}

class RoutineManual {
  String manualId;
  String routineManualId;
  int targetNumber;
  int setNumber;
  int weight;
  int speed;
  int playMinute;
  int order;
  String type;

  RoutineManual({
    required this.manualId,
    required this.routineManualId,
    required this.targetNumber,
    required this.setNumber,
    this.weight = 0,
    required this.speed,
    required this.playMinute,
    required this.order,
    required this.type,
  });

  factory RoutineManual.fromJson(Map<String, dynamic> json) {
    return RoutineManual(
      manualId: json['manualId'],
      routineManualId: json['routineManualId'],
      targetNumber: json['targetNumber'],
      setNumber: json['setNumber'],
      weight: json['weight'],
      speed: json['speed'],
      playMinute: json['playMinute'],
      order: json['order'],
      type: json['type'],
    );
  }
}

// class RoutineData {
//   var id = uuid.v1();
//   String name;
//   String type;
//   routineStatus status = routineStatus.before;
//   String? img;
//
//   //유산소
//   int totalTime; //분단뒤 유산소일때 사용
//
//   //근력운동
//   int totalSet; //전체세트
//   int numPerSet; //세트당 횟수
//   int weight; //근력운동일때만 사용
//
//   RoutineData({
//     required this.name,
//     required this.type,
//     this.totalSet = 3,
//     this.numPerSet = 10,
//     this.weight = 10,
//     this.totalTime = 10,
//     this.img,
//     this.status = routineStatus.before,
//   });
//   RoutineData.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         name = json['name'] ?? "",
//         type = json['type'] ?? "",
//         totalSet = json['set'] ?? 3,
//         numPerSet = json['num'] ?? 10,
//         weight = json['weight'] ?? 10,
//         totalTime = json['time'] ?? 10,
//         img = json['img'];
//
//   putAerobicRoutine({name, type, totalTime, img}) {
//     //유산소일때
//     this.name = name;
//     this.type = type;
//     this.totalTime = totalTime ?? 10;
//     this.img = img;
//   }
//
//   putWeightRoutine({name, type, totalSet, numPerSet, weight, img}) {
//     //근력운동일때
//     this.name = name;
//     this.type = type;
//     this.totalSet = totalSet ?? 3;
//     this.numPerSet = numPerSet ?? 10;
//     this.weight = weight ?? 10;
//     this.img = img;
//   }
// }
