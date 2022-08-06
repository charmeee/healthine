import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';

final isLoginedProvider = StateProvider<bool>((ref) => false);

//사용자가 한 운동
//사용자가 해야할 루틴틴
class UserExercisedNotifier extends StateNotifier<List<UserExerciseData>> {
  //var ref;

  UserExercisedNotifier([List<UserExerciseData>? initialUserExerciseData])
      : super(initialUserExerciseData ?? []);
  //initialUserExerciseData 나중에
  void add(UserExerciseData data) {
    state = [...state, data];
    log("추가됨");
    log(state[0].name.toString());
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
