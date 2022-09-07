//import 'dart:developer';

import 'routine_models.dart';

class UserExerciseData extends RoutineData {
  //운동기록이랑 운동 시계에서 ㅆㅁ
  //time 단위는 초
  int doingTime = 0; //한 시간 !

  //근력
  int doingSet = 1; //진행중인 세트 !
  int restTime = 3; //휴식 시간 !
  int countInterver = 3; //운동 횟수 속도 !
  int doingNum = 1; //한 횟수 !

  UserExerciseData(
      {required RoutineData routineData, //유산소
      this.doingSet = 1,
      this.restTime = 3,
      this.countInterver = 3,
      this.doingTime = 0,
      this.doingNum = 1 //한총개수
      })
      : super(
            name: routineData.name,
            type: routineData.type,
            totalSet: routineData.totalSet,
            numPerSet: routineData.numPerSet,
            totalTime: routineData.totalTime);

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
