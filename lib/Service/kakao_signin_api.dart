import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';

import 'social_api.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
          return true;
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            print('디바이스 권한 요청 화면에서 로그인을 취소한 경우');
            return false;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오계정으로 로그인 성공');
            return true;
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
            return false;
          }
        }
      } else {
        try {
          print('카카오계정으로 로그인 성공');
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    // TODO: implement logout
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
