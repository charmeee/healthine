import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/routine_models.dart';
import 'package:healthin/Routine/services/routine_request_api.dart';

//순서는 index

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

  changeRoutineStatus(int index, routineStatus status) {
    List<RoutineData> routineList = [...state];
    routineList = routineList.asMap().entries.map((e) {
      if (e.key == index) {
        e.value.status = status;
      }
      // else {
      //   e.value.doing = false;
      // }
      return e.value;
    }).toList();
    state = routineList;
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
    state.removeAt(index);
  }

  editRoutineDataByIndex({index, required String props, required int value}) {
    log("루틴데이터 편집.");
    RoutineData routine = state[index];
    switch (props) {
      case "time":
        routine.totalTime = (routine.totalTime) + value;
        log(routine.totalTime.toString());
        break;
      case "weight":
        routine.weight = (routine.weight) + value;
        break;
      case "set":
        routine.totalSet = (routine.totalSet) + value;
        break;
      case "num":
        routine.numPerSet = (routine.numPerSet) + value;
        break;
    }
    state = [
      for (final item in state)
        if (item.id == routine.id) routine else item
    ];
  }

  editRoutineDataById(
      {required var routineId, required String props, required int value}) {
    log("루틴데이터 편집.");
    RoutineData routine =
        state.firstWhere((element) => element.id == routineId);

    switch (props) {
      case "time":
        routine.totalTime = (routine.totalTime) + value;
        log(routine.totalTime.toString());
        break;
      case "weight":
        routine.weight = (routine.weight) + value;
        break;
      case "set":
        routine.totalSet = (routine.totalSet) + value;
        break;
      case "num":
        routine.numPerSet = (routine.numPerSet) + value;
        break;
    }
    state = [
      for (final item in state)
        if (item.id == routine.id) routine else item
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
