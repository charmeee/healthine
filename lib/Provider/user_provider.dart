import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Service/auth_request_api.dart';

//로그인 여부
final loginStateProvider = StateProvider<bool>((ref) => false);

//사용자 정보
final userStateProvider = StateProvider<UserInfo>((ref) {
  log("userState 변경");
  return UserInfo();
});

//userno

class UserProfileNotifier extends StateNotifier<UserInfo> {
  UserProfileNotifier([UserInfo? initialUser])
      : super(initialUser ?? UserInfo()) {
    log("userProfile 초기화");
  }

  getUserProfile() async {
    log("userProfile 받아오기");
    state = await UserProfileRequest();
  }

  updateUserProfile(String nickname) async {
    UserInfo userInfo = state;
    userInfo.nickname = nickname;
    log("닉넴 변경");
    UserUpdateRequest(userInfo);
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

final UserProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, UserInfo>((ref) {
  if (ref.watch(loginStateProvider) == true) {
    UserProfileNotifier().getUserProfile();
  }
  return UserProfileNotifier();
});
