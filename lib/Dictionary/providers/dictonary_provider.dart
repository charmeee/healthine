import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Dictionary/services/dictionary_api.dart';

final searchBynameProvider = StateProvider<String?>((ref) => null);
final searchBytypeProvider = StateProvider<String?>((ref) => null);

final filteredDictionaryDatas = Provider<List<ManualData>?>((ref) {
  final String? filterName = ref.watch(searchBynameProvider); //string으로 들어감.
  final String? filterType = ref.watch(searchBytypeProvider); //string으로 들어갈것.
  final List<ManualData> dictionarys =
      ref.watch(dictionaryNotifierProvider); //전체 데이타
  if (dictionarys.isEmpty) return null;
  Set<ManualData> filteredDictionarys = {};
  if (filterName == null && filterType == null) {
    return dictionarys;
  } else {
    if (filterName != null) {
      filteredDictionarys.addAll(dictionarys.where((data) =>
          data.title.toLowerCase().contains(filterName.toLowerCase())));
    }
    if (filterType != null) {
      filteredDictionarys
          .addAll(dictionarys.where((element) => element.type == filterType));
    }
    return filteredDictionarys.toList();
  }
});

class DictionaryNotifier extends StateNotifier<List<ManualData>> {
  DictionaryNotifier([List<ManualData>? initialDictionary])
      : super(initialDictionary ?? []) {
    log("사전데이터가져오기실행");
    getDictionary();
  }

  getDictionary() async {
    List<ManualData> dictionaryData = await getDicionaryList();
    if (dictionaryData.isNotEmpty) {
      state = dictionaryData;
      log(state[0].title.toString());
      log("사전데이터를 받아옴.");
    }
  }

  String? getDictionaryNameById(String id) {
    return state.firstWhere((element) => element.id == id).title;
  }

  addDictionary(List<ManualData> data) {
    log("사전데이터 추가.");
    state = [...state, ...data];
  }

  deleteDictionary(index) {
    log("사전데이터 삭제.");
    state.removeAt(index); //이것도 바꿔야될듯.
  }
}

//사전리스트변경
//루틴추가
//루틴삭제
//루틴순서변경
//루틴세부항목 변경
final dictionaryNotifierProvider =
    StateNotifierProvider<DictionaryNotifier, List<ManualData>>((ref) {
  log("DictionaryNotifierProvider실행");
  return DictionaryNotifier();
});
