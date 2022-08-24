import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Service/dictionary_api.dart';

class DictionaryNotifier extends StateNotifier<List<DictionaryData>> {
  DictionaryNotifier([List<DictionaryData>? initialDictionary])
      : super(initialDictionary ?? []) {
    log("사전데이터가져오기실행");
    getDictionary();
  }

  getDictionary() async {
    List<DictionaryData> routinedata = await readDictionaryJson();
    if (routinedata.isNotEmpty) {
      state = routinedata;
      log(routinedata[0].name.toString());
      log("사전데이터를 받아옴.");
    }
  }

  changeDictionaryOrder(data) {
    log("사전데이터 순서 변경");
    log(data.toString());
    state = data;
  }

  addDictionary(List<DictionaryData> data) {
    log("사전데이터 추가.");
    state = [...state, ...data];
  }

  deleteDictionary(index) {
    log("사전데이터 삭제.");
    state.removeAt(index); //이것도 바꿔야될듯.
  }

  // editDictionary({index, required String props, required int value}) {
  //   log("사전데이터 편집.");
  //   Dictionary routine = state[index];
  //   switch (props) {
  //     case "time":
  //       routine.time = (routine.time ?? 0) + value;
  //       log(routine.time.toString());
  //       break;
  //     case "weight":
  //       routine.weight = (routine.weight ?? 0) + value;
  //       break;
  //     case "set":
  //       routine.set = (routine.set ?? 0) + value;
  //       break;
  //     case "num":
  //       routine.num = (routine.num ?? 0) + value;
  //       break;
  //   }
  //   state = [
  //     for (final item in state)
  //       if (item.name == routine.name) routine else item
  //   ];
  // }
}

//사전리스트변경
//루틴추가
//루틴삭제
//루틴순서변경
//루틴세부항목 변경
final DictionaryNotifierProvider =
    StateNotifierProvider<DictionaryNotifier, List<DictionaryData>>((ref) {
  log("DictionaryNotifierProvider실행");
  return DictionaryNotifier();
});
