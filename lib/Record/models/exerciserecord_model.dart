//import 'dart:developer';

// {
// "id": "string",
// "routineTitle": "string",
// "targetNumber": 0,
// "setNumber": 0,
// "weight": 0,
// "speed": 0,
// "playMinute": 0,
// "startedAt": "2022-10-26T20:50:54.316Z",
// "endedAt": "2022-10-26T20:50:54.316Z",
// "createdAt": "2022-10-26T20:50:54.316Z",
// "manualId": "string"
// }

import 'package:intl/intl.dart';

import '../../Routine/models/routine_models.dart';

class Record {
  String id;
  String routineTitle;
  String routineId;
  String manualId; //루틴메뉴얼 아이디
  DateTime startedAt;
  DateTime endedAt;
  DateTime? createdAt;
  int targetNumber;
  int setNumber;
  int weight;
  int speed;
  int playMinute;

  Record({
    required this.id,
    required this.routineTitle,
    required this.routineId,
    required this.manualId,
    required this.startedAt,
    required this.endedAt,
    this.createdAt,
    required this.targetNumber,
    required this.setNumber,
    required this.weight,
    required this.speed,
    required this.playMinute,
  });
  factory Record.init(
      RoutineManual routineManual, String routineTitle, String routineId) {
    return Record(
      id: "",
      manualId: routineManual.routineManualId,
      routineId: routineId,
      routineTitle: routineTitle,
      startedAt: DateTime.now(),
      endedAt: DateTime.now(),
      targetNumber: 0,
      setNumber: 0,
      weight: routineManual.weight,
      speed: routineManual.speed,
      playMinute: 0,
    );
  }
  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      manualId: json['manualId'],
      routineId: json['routineId'],
      routineTitle: json['routineTitle'],
      startedAt: DateTime.parse(json['startedAt']),
      endedAt: DateTime.parse(json['endedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      targetNumber: json['targetNumber'],
      setNumber: json['setNumber'],
      weight: json['weight'],
      speed: json['speed'],
      playMinute: json['playMinute'],
    );
  }
  // "routineId": "string",
  // "manualId": "string",
  // "startedAt": "2022-10-27T07:43:26.809Z",
  // "endedAt": "2022-10-27T07:43:26.809Z",
  // "targetNumber": 0,
  // "setNumber": 0,
  // "weight": 0,
  // "speed": 0,
  // "playMinute": 0

  toPostJson() {
    return {
      "routineId": routineId,
      "manualId": manualId,
      //startedAt: "2022-10-29T11:09:27.922Z",
      "startedAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(startedAt),
      "endedAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(endedAt),
      "targetNumber": targetNumber,
      "setNumber": setNumber,
      "weight": weight,
      "speed": speed,
      "playMinute": playMinute,
    };
  }

  toPatchJson() {
    return {
      // "routineId": routineId,
      // "manualId": manualId,
      //startedAt: "2022-10-29T11:09:27.922Z",
      "startedAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(startedAt),
      "endedAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(endedAt),
      "targetNumber": targetNumber,
      "setNumber": setNumber,
      "weight": weight,
      "speed": speed,
      "playMinute": playMinute,
    };
  }
}
