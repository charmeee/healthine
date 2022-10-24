//import 'dart:developer';

// {
// "routineId": "string",
// "manualId": "string",
// "startedAt": "2022-10-24T10:57:33.892Z",
// "endedAt": "2022-10-24T10:57:33.892Z",
// "targetNumber": 0,
// "setNumber": 0,
// "weight": 0,
// "speed": 0,
// "playMinute": 0
// }
class Record {
  String id;
  String routineId;
  String manualId;
  DateTime startedAt;
  DateTime endedAt;
  int targetNumber;
  int setNumber;
  int weight;
  int speed;
  int playMinute;

  Record({
    required this.id,
    required this.routineId,
    required this.manualId,
    required this.startedAt,
    required this.endedAt,
    required this.targetNumber,
    required this.setNumber,
    required this.weight,
    required this.speed,
    required this.playMinute,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      routineId: json['routineId'],
      manualId: json['manualId'],
      startedAt: DateTime.parse(json['startedAt']),
      endedAt: DateTime.parse(json['endedAt']),
      targetNumber: json['targetNumber'],
      setNumber: json['setNumber'],
      weight: json['weight'],
      speed: json['speed'],
      playMinute: json['playMinute'],
    );
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
