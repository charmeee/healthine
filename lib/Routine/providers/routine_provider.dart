import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/routine_models.dart';
import 'package:healthin/Routine/services/routine_request_api.dart';

import '../test.dart';

//순서는 index

class RoutineNotifier extends StateNotifier<List<Routine>> {
  final Ref ref;
  RoutineNotifier({required this.ref}) : super([]) {
    log("내 루틴데이터 가져오기 실행");
    getRoutineData();
  }
  getRoutineData() async {
    List<Routine> routinedata =
        routineTest.map((e) => Routine.fromJson(e)).toList();
    if (routinedata.isNotEmpty) {
      state = routinedata;
    }
  }

  editDayOfWeek(String id, int index, bool value) {
    /*
    null false =>경우자체가 존재할 수 없다.
    null true
    그값을 1로 만들어주고 provider에 id 를 넣어준다..
    id false
    그값을 0으로 만들어주고 provider에 null을 넣어준다.
    id true
    그값을 1로만들어주고 id에있는 해당 day index를 0으로 만들어준다.
    그리고 provider에 id를넣어준다
     */
    List<Routine> temp = [...state];
    final weekRoutineId = ref.watch(dayOfWeekRoutineProvider);
    if (value) {
      if (weekRoutineId != null) {
        temp.map((e) {
          //그전 요일에있던루틴을 없애준다.
          if (e.id == weekRoutineId[index]) {
            e.day[index] = 0;
          }
          return e;
        });
      }
      ref.watch(dayOfWeekRoutineProvider.notifier).state[index] = id;
    } else {
      ref.watch(dayOfWeekRoutineProvider.notifier).state[index] = null;
    }
    int change = value ? 1 : 0;
    temp.map((e) {
      if (e.id == id) {
        e.day[index] = change;
      }
      return e;
    });
  }
}

//루틴리스트변경
//루틴추가
//루틴삭제
//루틴순서변경
//루틴세부항목 변경
final userRoutineListProvider =
    StateNotifierProvider<RoutineNotifier, List<Routine>>((ref) {
  log("RoutineNotifierProvider실행");
  return RoutineNotifier(ref: ref);
});

final todayRoutineProvider = Provider((ref) {
  List<Routine> routineList = ref.watch(userRoutineListProvider);
  DateTime today = DateTime.now();
  return routineList
      .firstWhere((element) => element.day[today.weekday - 1] == 1);
});

final dayOfWeekRoutineProvider = StateProvider<List<String?>>((ref) {
  final routine = ref.watch(userRoutineListProvider);
  List<String?> dayOfWeek = List.generate(7, (index) => null);
  for (int i = 0; i < routine.length; i++) {
    for (int j = 0; j < 7; j++) {
      //여기에 숫자대신 id를 넣는식으로다가..
      routine[i].day[j] == 1 ? dayOfWeek[j] = routine[i].id : null;
    }
  }
  return dayOfWeek;
});
