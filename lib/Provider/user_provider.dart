import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Service/auth_request_api.dart';

//로그인 여부
final loginStateProvider = StateProvider<bool>((ref) => false);

//userno

class UserProfileNotifier extends StateNotifier<UserInfo> {
  UserProfileNotifier([UserInfo? initialUser])
      : super(initialUser ?? UserInfo()) {
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

  deleteUserProfile() async {
    log("회원탈퇴");
    state = UserInfo(
        id: null,
        nickname: null,
        username: null,
        userEmail: null,
        ageRange: null,
        gender: null);
  }
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, UserInfo>((ref) {
  // ref.watch(loginStateProvider) == true
  //     ? UserProfileNotifier().getUserProfile()
  //     : null;
  return UserProfileNotifier();
});
