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
  String manualId;
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
      manualId: routineManual.manualId,
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
      routineId: "",
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

  toJson() {
    return {
      "routineId": routineId,
      "manualId": manualId,
      //startedAt: "2022-10-29T11:09:27.922Z",
      "startedAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(startedAt),
      "endedAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(endedAt),
      "targetNumber": targetNumber,
      "setNumber": setNumber,
      "weight": weight,
      "speed": speed,
      "playMinute": playMinute,
    };
  }
}

// {
// "id": "string",
// "routineTitle": "string",
// "targetNumber": 0,
// "setNumber": 0,
// "weight": 0,
// "speed": 0,
// "playMinute": 0,
// "startedAt": "2022-10-24T18:16:02.764Z",
// "endedAt": "2022-10-24T18:16:02.764Z",
// "createdAt": "2022-10-24T18:16:02.764Z"
// }

// class UserExerciseData {
//   //운동기록이랑 운동 시계에서 ㅆㅁ
//   //time 단위는 초
//   var id = uuid.v1();
//   int doingTime = 0; //한 시간 !
//
//   //근력
//   int doingSet = 1; //진행중인 세트 !
//   int doingNum = 1; //한 횟수 !
//
//   //근력 시계용
//   int restTime = 3; //휴식 시간 !
//   int countInterver = 3; //운동 횟수 속도 !
//
//   RoutineData routineData;
//
//   UserExerciseData(
//       {required this.routineData,
//       this.doingSet = 1,
//       this.restTime = 3,
//       this.countInterver = 3,
//       this.doingTime = 0,
//       this.doingNum = 1 //한총개수
//       });
//
//   putAerobicWatchData({doingTime}) {
//     // TODO: implement putAerobicRoutine
//     this.doingTime = doingTime;
//   }
//
//   putWeightWatchData({doingTime, doingSet, doingNum, restTime, countInterver}) {
//     // TODO: implement putAerobicRoutine
//     this.doingTime = doingTime;
//     this.doingSet = doingSet;
//     this.doingNum = doingNum;
//     this.restTime = restTime;
//     this.countInterver = countInterver;
//   }
// }
