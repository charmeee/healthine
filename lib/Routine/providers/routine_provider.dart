import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Routine/services/myRoutine_api.dart';

class MyRoutinePreviewNotifier extends StateNotifier<List<MyRoutine>> {
  MyRoutinePreviewNotifier() : super([]) {
    log("내 루틴데이터 가져오기 실행");
    getRoutineData();
  }
  getRoutineData() async {
    List<MyRoutine> routineData = await getMyRoutineList();
    state = routineData;
  }

  // 걍 get루틴 postroutine 정도만있어도될듯
  editRoutineData() async {
    // 루틴 수정 patch ->get
  }
  sendRoutineManuals(List<RoutineManual> beforeManuals,
      List<RoutineManual> nowManuals, String routineId) {
    log('sendRoutineManuals');
    nowManuals.map((e) async {
      int index = beforeManuals.indexWhere(
          (element) => element.routineManualId == e.routineManualId);
      if (index > -1) {
        //값이있는것.patch를 날릴 것.
        beforeManuals.removeAt(index);
        //patch e
      } else {
        await postMyRoutineManual(e, routineId);
        //post e
      }
    });
    if (beforeManuals.isNotEmpty) {
      beforeManuals.map((e) async {
        //delete e
        await deleteMyRoutineManual(e.routineManualId);
      });
    }
    getRoutineData();
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

final todayRoutineProvider = FutureProvider<MyRoutine?>((ref) async {
  List<String?> dayOfWeek = ref.watch(dayOfWeekRoutineProvider);
  DateTime today = DateTime.now();
  String? todayRoutineId = dayOfWeek[today.weekday - 1];
  log("todayRoutineId : $todayRoutineId");
  if (todayRoutineId != null) {
    return await getMyRoutineById(todayRoutineId);
  }
  return null;
  //MyRoutine todayRoutine = get요청 api
});

//날마다 해당루틴 id를 넣는다.
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
