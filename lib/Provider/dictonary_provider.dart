import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/dictionary_model.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Service/dictionary_api.dart';

final searchBynameProvider = StateProvider<String?>((ref) => null);
final searchBytypeProvider = StateProvider<String?>((ref) => null);

final filteredDatas = Provider<List<DictionaryData>>((ref) {
  final String? filtername = ref.watch(searchBynameProvider); //string으로 들어감.
  final String? filtertype = ref.watch(searchBytypeProvider); //string으로 들어갈것.
  final List<DictionaryData> dictionarys =
      ref.watch(DictionaryNotifierProvider); //전체 데이타
  Set<DictionaryData> filteredDictionarys = {};
  if (filtername == null && filtertype == null) {
    return dictionarys;
  } else {
    if (filtername != null) {
      filteredDictionarys.addAll(dictionarys.where((data) =>
          data.name!.toLowerCase().contains(filtername.toLowerCase())));
    }
    if (filtertype != null) {
      filteredDictionarys
          .addAll(dictionarys.where((element) => element.type == filtertype));
    }
    return filteredDictionarys.toList();
  }
});

class DictionaryNotifier extends StateNotifier<List<DictionaryData>> {
  DictionaryNotifier([List<DictionaryData>? initialDictionary])
      : super(initialDictionary ?? []) {
    log("사전데이터가져오기실행");
    getDictionary();
  }

  getDictionary() async {
    List<DictionaryData> dictionaryData = await readDictionaryJson();
    if (dictionaryData.isNotEmpty) {
      state = dictionaryData;
      log(state[0].name.toString());
      log("사전데이터를 받아옴.");
    }
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
  //   Dictionary dictionaryData = state[index];
  //   switch (props) {
  //     case "time":
  //       dictionaryData.time = (dictionaryData.time ?? 0) + value;
  //       log(dictionaryData.time.toString());
  //       break;
  //     case "weight":
  //       dictionaryData.weight = (dictionaryData.weight ?? 0) + value;
  //       break;
  //     case "set":
  //       dictionaryData.set = (dictionaryData.set ?? 0) + value;
  //       break;
  //     case "num":
  //       dictionaryData.num = (dictionaryData.num ?? 0) + value;
  //       break;
  //   }
  //   state = [
  //     for (final item in state)
  //       if (item.name == dictionaryData.name) dictionaryData else item
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
