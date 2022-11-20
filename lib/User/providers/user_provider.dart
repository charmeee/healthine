import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/User/models/user_model.dart';

import '../services/auth_request_api.dart';
import '../services/kakao_signin_api.dart';
import '../services/social_api.dart';

enum Vender { kakao, google, apple }

//로그인 여부
final loginStateProvider = StateProvider<bool>((ref) => false);

//userno

class UserProfileNotifier extends StateNotifier<UserInfo> {
  final Ref ref;
  UserProfileNotifier({required this.ref}) : super(UserInfo()) {
    getUserProfile();
    log("userProfile 초기화");
  }

  getUserProfile() async {
    log("******userProfile 받아오기******");
    try {
      UserInfo userInfo = await userProfileRequest();
      state = userInfo;
      log(state.id.toString());
      log(state.username.toString());
      log(state.nickname.toString());
      log("*****************************");
      ref.read(loginStateProvider.notifier).state = true;
    } catch (e) {
      logout();
    }
  }

  Future<LoginState> venderLogin(Vender vender) async {
    switch (vender) {
      case Vender.kakao:
        log("카카오 로그인");
        SocialLogin kakaoLogin = KakaoLogin();
        LoginState isKaKaoLogin = await kakaoLogin.login();
        if (isKaKaoLogin.isLogin) {
          await getUserProfile();
        }
        return isKaKaoLogin;
      //loginstate를반환 freshman 이면 리턴 freshman아니면 프로필 로딩.
      case Vender.google:
        log("구글 로그인");
        return LoginState(isLogin: false, isFreshman: false);
      case Vender.apple:
        log("애플 로그인");
        return LoginState(isLogin: false, isFreshman: false);
    }
  }

  Future<LoginState> nativeLogin(String username, String password) async {
    log("nativeLogin");
    LoginState isLogin = await nativeLoginRequest(username, password);
    if (isLogin.isLogin) {
      await getUserProfile();
    }
    return isLogin;
  }

  Future<bool> updateUserProfile(UserInfo newUserInfo) async {
    UserInfo userInfo = UserInfo(
        id: state.id,
        username: newUserInfo.username,
        nickname: newUserInfo.nickname,
        userEmail: newUserInfo.userEmail,
        ageRange: newUserInfo.ageRange,
        gender: newUserInfo.gender);
    bool result = await UserUpdateRequest(userInfo);
    if (result) {
      state = userInfo;
      log("$newUserInfo.nickname로 닉넴 변경 ");
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
    if (state.id != null) {
      await deleteUser(state.id!);
      state = UserInfo.init();
      ref.read(loginStateProvider.notifier).state = false;
    }
  }
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, UserInfo>((ref) {
  return UserProfileNotifier(ref: ref);
});
