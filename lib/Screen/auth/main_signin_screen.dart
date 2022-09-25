import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/user_provider.dart';
import 'package:healthin/Service/social_api.dart';
//import 'package:healthin/auth/social_signup_get_info.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'email_signin_widget.dart';
import 'package:healthin/Service/google_signin_api.dart';
import 'package:healthin/Service/kakao_signin_api.dart';
import 'signup_screen.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';
import 'package:healthin/Service/auth_request_api.dart';

class MainSignIn extends ConsumerWidget {
  MainSignIn({Key? key}) : super(key: key);

  SocialLogin kakaoLogin = KakaoLogin();

  SocialLogin googleLogin = GoogleLogin();

  // Future<void> googleSignIn(context) async {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //bool isLogined = ref.watch(loginStateProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // EmailSignIn(),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15)),
                icon: Icon(
                  Icons.g_mobiledata_rounded,
                  color: Colors.white,
                ),
                onPressed: () async {
                  ref.read(loginStateProvider.notifier).state =
                      await googleLogin.login();
                },
                label: Text("구글로 로그인", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.yellowAccent,
                    padding: EdgeInsets.symmetric(vertical: 15)),
                icon: Icon(
                  Icons.message,
                  color: Colors.black,
                ),
                onPressed: () async {
                  ref.read(loginStateProvider.notifier).state =
                      await kakaoLogin.login();
                  if (ref.read(loginStateProvider.notifier).state) {
                    User user = await UserApi.instance.me();
                    log("카카오 유저아이디" + user.id.toString());
                  }
                },
                label:
                    Text("카카오톡으로 로그인", style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.yellowAccent,
                    padding: EdgeInsets.symmetric(vertical: 15)),
                icon: Icon(
                  Icons.message,
                  color: Colors.black,
                ),
                onPressed: () async {
                  ref.read(loginStateProvider.notifier).state =
                      await kakaoLogin.login();
                  if (ref.read(loginStateProvider.notifier).state) {
                    User user = await UserApi.instance.me();
                    log("카카오 유저아이디" + user.id.toString());
                  }
                },
                label:
                    Text("카카오톡으로 로그인", style: TextStyle(color: Colors.black)),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextButton(
              //   style: TextButton.styleFrom(
              //       backgroundColor: Colors.black54,
              //       padding: EdgeInsets.all(20)),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => SignUp()));
              //   },
              //   child: Text("회원가입하기", style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
