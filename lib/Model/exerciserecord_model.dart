//import 'dart:developer';

import 'routine_models.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class UserExerciseData extends RoutineData {
  //운동기록이랑 운동 시계에서 ㅆㅁ
  //time 단위는 초
  var id = uuid.v1();
  int doingTime = 0; //한 시간 !

  //근력
  int doingSet = 1; //진행중인 세트 !
  int doingNum = 1; //한 횟수 !

  //근력 시계용
  int restTime = 3; //휴식 시간 !
  int countInterver = 3; //운동 횟수 속도 !

  UserExerciseData(
      {required routineData,
      this.doingSet = 1,
      this.restTime = 3,
      this.countInterver = 3,
      this.doingTime = 0,
      this.doingNum = 1 //한총개수
      })
      : super(
          name: routineData.name,
          type: routineData.type,
          status: routineData.status,
          //유산소
          totalTime: routineData.totalTime,
          //근력운동
          totalSet: routineData.totalSet,
          numPerSet: routineData.numPerSet,
          weight: routineData.weight,
        );

  putAerobicWatchData({doingTime}) {
    // TODO: implement putAerobicRoutine
    this.doingTime = doingTime;
  }

  putWeightWatchData({doingTime, doingSet, doingNum, restTime, countInterver}) {
    // TODO: implement putAerobicRoutine
    this.doingTime = doingTime;
    this.doingSet = doingSet;
    this.doingNum = doingNum;
    this.restTime = restTime;
    this.countInterver = countInterver;
  }
}
