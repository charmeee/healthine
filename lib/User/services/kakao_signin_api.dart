import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'auth_request_api.dart';
import 'social_api.dart';

final storage = FlutterSecureStorage();
List<String> serviceTerms = ['account_email', 'gender', 'age_range'];

class KakaoLogin implements SocialLogin {
  @override
  Future<LoginState> login() async {
    try {
      if (await isKakaoTalkInstalled()) {
        try {
          final kakaoTalkToken = await UserApi.instance
              .loginWithKakaoTalk(serviceTerms: serviceTerms);
          log("kakaoTalkToken: ${kakaoTalkToken.accessToken}");
          return await sendVendorToken(kakaoTalkToken.accessToken, "kakao");
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            print('디바이스 권한 요청 화면에서 로그인을 취소한 경우');
            return LoginState(isLogin: false, isFreshman: false);
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인ㅌ
          try {
            final kakaoToken = await UserApi.instance.loginWithKakaoAccount();
            log("kakaoToken: ${kakaoToken.accessToken}");
            return await sendVendorToken(
                kakaoToken.accessToken.toString(), "kakao");
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
            return LoginState(isLogin: false, isFreshman: false);
          }
        }
      } else {
        try {
          print('카카오계정으로 로그인 성공');
          final kakaoToken = await UserApi.instance.loginWithKakaoAccount();
          return await sendVendorToken(
              kakaoToken.accessToken.toString(), "kakao");
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return LoginState(isLogin: false, isFreshman: false);
        }
      }
    } catch (e) {
      print(e);
      return LoginState(isLogin: false, isFreshman: false);
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
