import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';

//사용자가 한 운동
class UserExercisedNotifier extends StateNotifier<List<UserExerciseData>> {
  //var ref;
  //[List<UserExerciseData>? initialUserExerciseData]
  //initialUserExerciseData ??
  UserExercisedNotifier() : super([]);
  //initialUserExerciseData 나중에
  void add(UserExerciseData data) {
    state = [...state, data];
    log("추가됨");
    log(state.length.toString());
    //post요청도넣으면 될듯.
  }
}

final UserExercisedNotifierProvider =
    StateNotifierProvider<UserExercisedNotifier, List<UserExerciseData>>((ref) {
  return UserExercisedNotifier();
});

//var UserExercisedState = ref.watch(UserExercisedNotifierProvider); state 보기
//final UserExercisedRead =
//         ref.read(UserExercisedNotifierProvider.notifier); //함수들
