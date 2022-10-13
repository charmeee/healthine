import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/routine_models.dart';
import 'package:healthin/User/models/user_model.dart';

import '../services/auth_request_api.dart';

//로그인 여부
final loginStateProvider = StateProvider<bool>((ref) => false);

//userno

class UserProfileNotifier extends StateNotifier<UserInfo> {
  final Ref ref;
  UserProfileNotifier({required this.ref}) : super(UserInfo()) {
    log("userProfile 초기화");
  }

  getUserProfile() async {
    log("******userProfile 받아오기******");
    UserInfo userInfo = await userProfileRequest();
    state = userInfo;
    log(state.id.toString());
    log(state.username.toString());
    log(state.nickname.toString());
    log("*****************************");
  }

  Future<bool> updateUserProfile(String nickname) async {
    UserInfo userInfo = UserInfo(
        id: state.id,
        username: state.username,
        nickname: nickname,
        userEmail: state.userEmail,
        ageRange: state.ageRange,
        gender: state.gender);
    bool result = await UserUpdateRequest(userInfo);
    if (result) {
      state = userInfo;
      log("$nickname로 닉넴 변경 ");
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    await logoutRequest();
    state = UserInfo.init();
    ref.read(loginStateProvider.notifier).state = false;
  }

  deleteUserProfile() async {
    log("회원탈퇴");
    state = UserInfo.init();
    ref.read(loginStateProvider.notifier).state = false;
  }
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, UserInfo>((ref) {
  // ref.watch(loginStateProvider) == true
  //     ? UserProfileNotifier().getUserProfile()
  //     : null;
  return UserProfileNotifier(ref: ref);
});
