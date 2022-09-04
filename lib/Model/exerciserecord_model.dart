import 'routine_models.dart';

class UserExerciseData extends RoutineData {
  //운동기록이랑 운동 시계에서 ㅆㅁ
  //time 단위는 초

  int? doingSet; //진행중인 세트 !
  int? restTime; //휴식 시간 !
  int? countInterver; //운동 횟수 속도 !
  int doingTime; //한 시간 !
  int? doingNum; //한 횟수 !

  UserExerciseData(
      {name,
      type,
      totalSet,
      numPerSet,
      totalTime, //유산소
      this.doingSet = 1,
      this.restTime = 3,
      this.countInterver = 3,
      this.doingTime = 0,
      this.doingNum = 0 //한총개수
      })
      : super(
            name: name,
            type: type,
            totalSet: totalSet,
            numPerSet: numPerSet,
            totalTime: totalTime);
}
