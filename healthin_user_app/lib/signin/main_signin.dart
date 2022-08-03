import 'package:flutter/material.dart';
import 'package:healthin/signin/social_api.dart';
//import 'package:healthin/signin/social_signup_get_info.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'email_signin.dart';
import 'google_signin_api.dart';
import 'kakao_signin_api.dart';
import 'signup.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';
import 'signup_util.dart';

class MainSignIn extends StatefulWidget {
  MainSignIn({Key? key, required this.changeStatus}) : super(key: key);
  final Function() changeStatus;

  @override
  State<MainSignIn> createState() => _MainSignInState();
}

class _MainSignInState extends State<MainSignIn> {
  SocialLogin kakaoLogin = KakaoLogin();

  SocialLogin googleLogin = GoogleLogin();

  bool isLogined = false;

  // Future<void> googleSignIn(context) async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EmailSignIn(),
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
                  isLogined = await googleLogin.login();
                  if (isLogined) {
                    widget.changeStatus();
                  }
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
                  isLogined = await kakaoLogin.login();
                  if (isLogined) {
                    User user = await UserApi.instance.me();
                    log("카카오 유저아이디" + user.id.toString());
                    widget.changeStatus();
                  }
                },
                label:
                    Text("카카오톡으로 로그인", style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: EdgeInsets.all(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text("회원가입하기", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
