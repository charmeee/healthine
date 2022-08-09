import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Provider/user_provider.dart';
import 'package:healthin/Service/routine_request_api.dart';

class RoutineNotifier extends StateNotifier<List<RoutineData>> {
  RoutineNotifier([List<RoutineData>? initialRoutine])
      : super(initialRoutine ?? []) {
    log("루틴데이터가져오기실행");
    getRoutineData();
  }

  getRoutineData() async {
    List<RoutineData> _routinedata = await readRoutineJson();
    if (_routinedata.isNotEmpty) {
      state = _routinedata;
      log(_routinedata[0].name.toString());
      log("루틴데이터 추가됨.");
    }
  }

  changeRoutineOrder(data) {
    log("루틴데이터 바뀜");
    log(data.toString());
    state = data;
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
