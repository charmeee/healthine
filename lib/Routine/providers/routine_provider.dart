import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/routine_models.dart';
import 'package:healthin/Routine/services/myRoutine_api.dart';

import '../test.dart';

/*
* 1. myroutinelist를 조회] => List<String?> 요일별 루틴 id값을 저장함
* 2. 만약 이미 그요일에 루틴이있으면
*
*
*
*
* */

class MyRoutinePreviewNotifier extends StateNotifier<List<MyRoutine>> {
  MyRoutinePreviewNotifier() : super([]) {
    log("내 루틴데이터 가져오기 실행");
    getRoutineData();
  }
  getRoutineData() async {
    List<MyRoutine> routineData =
        myRoutineListEx.map((e) => MyRoutine.liteFromJson(e)).toList();
    if (routineData.isNotEmpty) {
      state = routineData;
    }
  }

  // 걍 get루틴 postroutine 정도만있어도될듯
  editRoutineData() async {
    // 루틴 수정 patch ->get
  }
}

//루틴리스트변경
//루틴추가
//루틴삭제
//루틴순서변경
//루틴세부항목 변경
final userRoutinePreviewProvider =
    StateNotifierProvider<MyRoutinePreviewNotifier, List<MyRoutine>>((ref) {
  log("RoutineNotifierProvider실행");
  return MyRoutinePreviewNotifier();
});

final todayRoutineProvider = Provider<String?>((ref) {
  List<String?> dayOfWeek = ref.watch(dayOfWeekRoutineProvider);
  DateTime today = DateTime.now();
  String? todayRoutineId = dayOfWeek[today.weekday - 1];
  if (todayRoutineId == null) {
    return;
  }
  //MyRoutine todayRoutine = get요청 api
});

final dayOfWeekRoutineProvider = StateProvider<List<String?>>((ref) {
  final routine = ref.watch(userRoutinePreviewProvider);
  List<String?> dayOfWeek = List.generate(7, (index) => null);
  for (int i = 0; i < routine.length; i++) {
    for (int j = 0; j < 7; j++) {
      //여기에 숫자대신 id를 넣는식으로다가..
      routine[i].days[j] == 1 ? dayOfWeek[j] = routine[i].id : null;
    }
  }
  return dayOfWeek;
});
