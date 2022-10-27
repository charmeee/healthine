// import 'dart:developer';
//
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';

import '../../Routine/test.dart';
// import 'package:healthin/Routine/routine_models.dart';
// import 'package:healthin/User/models/user_model.dart';

class RecordNotifier extends StateNotifier<List<Record>> {
  RecordNotifier() : super([]) {
    getRecordData();
  }

  //먼저 오늘의 운동기록을 조회한다
  getRecordData() async {
    List<Record> recorddata =
        recordTestEx.map((e) => Record.fromJson(e)).toList();
    if (recorddata.isNotEmpty) {
      state = recorddata;
    }
  }

  updateRecordData(List<Record> data) {
    state = data;
  }
}

final todayRecordProvider = StateNotifierProvider<RecordNotifier, List<Record>>(
    (ref) => RecordNotifier());
//기록에서 시간이랑 세트수로 운동여부와 등등을 알려줌.
//세트수와 targetnum 이 둘다 0이면 운동안한거
//이상이면 운동을 시작한거
//타겟넘버와 세트가 꽉차면 운동을 끝낸거

// //사용자가 한 운동
// //루틴 순서대로 인덱스가 들어감
// class UserExercisedNotifier extends StateNotifier<List<UserExerciseData>> {
//   //var ref;
//   //[List<UserExerciseData>? initialUserExerciseData]
//   //initialUserExerciseData ??
//   UserExercisedNotifier() : super([]);
//   //initialUserExerciseData 나중에
//   void add(UserExerciseData data) {
//     state = [...state, data];
//     log("추가됨");
//     log(state.length.toString());
//     //post요청도넣으면 될듯.
//   }
//
//   void replace(UserExerciseData data, var id) {
//     List<UserExerciseData> temp = [...state];
//     temp.map((e) {
//       if (e.id == id) {
//         return e = data;
//       }
//       return e;
//     });
//     state = temp;
//     log("교체됨");
//     log(state.length.toString());
//   }
// }
//
// final UserExercisedNotifierProvider =
//     StateNotifierProvider<UserExercisedNotifier, List<UserExerciseData>>((ref) {
//   return UserExercisedNotifier();
// });
//
// //var UserExercisedState = ref.watch(UserExercisedNotifierProvider); state 보기
// //final UserExercisedRead =
// //         ref.read(UserExercisedNotifierProvider.notifier); //함수들
