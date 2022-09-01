import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Service/routine_request_api.dart';

class RoutineNotifier extends StateNotifier<List<RoutineData>> {
  RoutineNotifier([List<RoutineData>? initialRoutine])
      : super(initialRoutine ?? []) {
    log("루틴데이터가져오기실행");
    getRoutineData();
  }

  getRoutineData() async {
    List<RoutineData> routinedata = await readRoutineJson();
    if (routinedata.isNotEmpty) {
      state = routinedata;
      log(routinedata[0].name.toString());
      log("루틴데이터를 받아옴.");
    }
  }

  changeRoutineOrder(data) {
    log("루틴데이터 순서 변경");
    log(data.toString());
    state = data;
  }

  addRoutineData(List<RoutineData> data) {
    log("루틴데이터 추가.");
    state = [...state, ...data];
  }

  deleteRoutineData(index) {
    log("루틴데이터 삭제.");
    state.removeAt(index); //이것도 바꿔야될듯.
  }

  editRoutineData({index, required String props, required int value}) {
    log("루틴데이터 편집.");
    RoutineData routine = state[index];
    switch (props) {
      case "time":
        routine.time = (routine.time ?? 0) + value;
        log(routine.time.toString());
        break;
      case "weight":
        routine.weight = (routine.weight ?? 0) + value;
        break;
      case "set":
        routine.set = (routine.set ?? 0) + value;
        break;
      case "num":
        routine.num = (routine.num ?? 0) + value;
        break;
    }
    state = [
      for (final item in state)
        if (item.name == routine.name) routine else item
    ];
  }
}

//루틴리스트변경
//루틴추가
//루틴삭제
//루틴순서변경
//루틴세부항목 변경
final RoutineNotifierProvider =
    StateNotifierProvider<RoutineNotifier, List<RoutineData>>((ref) {
  log("RoutineNotifierProvider실행");
  return RoutineNotifier();
});
