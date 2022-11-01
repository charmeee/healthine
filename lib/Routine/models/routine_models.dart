import 'package:flutter/foundation.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum ManualType {
  targetNumber,
  setNumber,
  weight, //무산소
  speed,
  playMinute
}

enum ExerciseType {
  back,
  chest,
  shoulder,
  arm,
  leg,
  abs,
  cardio,
  etc;

  factory ExerciseType.fromName(String name) {
    switch (name) {
      case 'back':
        return ExerciseType.back;
      case 'chest':
        return ExerciseType.chest;
      case 'shoulder':
        return ExerciseType.shoulder;
      case 'arm':
        return ExerciseType.arm;
      case 'leg':
        return ExerciseType.leg;
      case 'abs':
        return ExerciseType.abs;
      case 'cardio':
        return ExerciseType.cardio;
      default:
        return ExerciseType.etc;
    }
  }
}

enum routineStatus {
  before,
  doing,
  done;

  factory routineStatus.getByString(String str) {
    return routineStatus.values
        .firstWhere((value) => value == str, orElse: () => routineStatus.doing);
  }
}

class MyRoutine {
  String id;
  String title;
  List<int> days;
  List<String> types;
  List<RoutineManual>? routineManuals;

  MyRoutine({
    required this.id,
    required this.title,
    required this.days,
    required this.types,
    this.routineManuals,
  });
  factory MyRoutine.copyWith(MyRoutine myRoutine) {
    return MyRoutine(
      id: myRoutine.id,
      title: myRoutine.title,
      days: myRoutine.days,
      types: myRoutine.types,
      routineManuals: myRoutine.routineManuals,
    );
  }
  factory MyRoutine.liteFromJson(Map<String, dynamic> json) {
    return MyRoutine(
      id: json['id'],
      title: json['title'],
      days: json['days'].map<int>((e) => e as int).toList(),
      types: json['types'].map<String>((e) => e.toString()).toList() ?? [],
    );
  }

  factory MyRoutine.fromJson(Map<String, dynamic> json) {
    return MyRoutine(
      id: json['id'],
      title: json['title'],
      days: json['days'].map<int>((e) => e as int).toList(),
      types: json['types'].map<String>((e) => e.toString()).toList() ?? [],
      routineManuals: (json['routineManuals'] as List<dynamic>)
          .map((e) => RoutineManual.fromJson(e))
          .toList(),
    );
  }
  factory MyRoutine.fromReferenceRoutine(ReferenceRoutine referencerRoutine) {
    return MyRoutine(
      id: "",
      title: referencerRoutine.title,
      days: [0, 0, 0, 0, 0, 0, 0],
      types: referencerRoutine.types,
      routineManuals: referencerRoutine.routineManuals,
    );
  }

  factory MyRoutine.init(String routineTitle) {
    return MyRoutine(
      id: "",
      title: routineTitle,
      days: [0, 0, 0, 0, 0, 0, 0],
      types: [],
      routineManuals: [],
    );
  }
  Map<String, dynamic> newRoutineToJson() {
    return {
      "title": title,
      "days": days,
    };
  }

  Map<String, dynamic> dayToJson() {
    return {
      "days": days,
    };
  }

  Map<String, dynamic> titleToJson() {
    return {
      "title": title,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "days": days,
      "types": types,
      "routineManuals": routineManuals == null
          ? []
          : routineManuals!.map((e) => e.toJson()).toList(),
    };
  }
}

class ReferenceRoutine {
  String id;
  String title;
  String description; //
  String author; //
  int likesCount;
  List<String> types;
  List<RoutineManual>? routineManuals;

  ReferenceRoutine({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.likesCount,
    required this.types,
    this.routineManuals,
  });

  factory ReferenceRoutine.init() {
    return ReferenceRoutine(
      id: "",
      title: "",
      description: "",
      author: "",
      likesCount: 0,
      types: [],
      routineManuals: [],
    );
  }

  factory ReferenceRoutine.liteFromJson(Map<String, dynamic> json) {
    return ReferenceRoutine(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      likesCount: json['likesCount'] ?? 0,
      types: json['types'].map<String>((e) => e.toString()).toList() ?? [],
    );
  }

  factory ReferenceRoutine.fromJson(Map<String, dynamic> json) {
    return ReferenceRoutine(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      likesCount: json['likesCount'] ?? 0,
      types: json['types'].map<String>((e) => e.toString()).toList() ?? [],
      routineManuals: (json['routineManuals'] as List<dynamic>)
          .map((e) => RoutineManual.fromJson(e))
          .toList(),
    );
  }
}

class RoutineManual {
  String manualId;
  String routineManualId;
  String manualTitle;
  int targetNumber;
  int setNumber;
  int weight;
  int speed;
  int playMinute;
  int order;
  String type;

  bool get isCardio => type == describeEnum(ExerciseType.cardio);

  RoutineManual({
    required this.manualId,
    required this.routineManualId,
    required this.manualTitle,
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
      manualTitle: json['manualTitle'],
      targetNumber: json['targetNumber'] ?? 0,
      setNumber: json['setNumber'] ?? 0,
      weight: json['weight'] ?? 0,
      speed: json['speed'] ?? 0,
      playMinute: json['playMinute'] ?? 0,
      order: json['order'],
      type: json['type'],
    );
  }

  factory RoutineManual.init() {
    return RoutineManual(
      manualId: "",
      routineManualId: "",
      manualTitle: "",
      targetNumber: 10,
      setNumber: 3,
      weight: 10,
      speed: 4,
      playMinute: 10,
      order: 0,
      type: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "manualId": manualId,
      "routineManualId": routineManualId,
      "manualTitle": manualTitle,
      "targetNumber": targetNumber,
      "setNumber": setNumber,
      "weight": weight,
      "speed": speed,
      "playMinute": playMinute,
      "order": order,
      "type": type,
    };
  }

  Map<String, dynamic> weightToJson() {
    return {
      "targetNumber": targetNumber,
      "setNumber": setNumber,
      "weight": weight,
      "order": order,
    };
  }

  Map<String, dynamic> cardioToJson() {
    return {
      "speed": speed,
      "playMinute": playMinute,
      "order": order,
    };
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
