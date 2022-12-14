import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:healthin/User/services/social_api.dart';
import 'package:healthin/User/widgets/email_signin_widget.dart';
//import 'package:healthin/User/social_signup_get_info.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:healthin/User/services/google_signin_api.dart';
import 'package:healthin/User/services/kakao_signin_api.dart';
import 'signup_screen.dart';
import 'dart:developer';

class MainSignIn extends ConsumerWidget {
  MainSignIn({Key? key}) : super(key: key);

  SocialLogin kakaoLogin = KakaoLogin();
  SocialLogin googleLogin = GoogleLogin();

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future<void> googleSignIn(context) async {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2)),
              Center(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 100,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 150)),
              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //       backgroundColor: Colors.blueAccent,
              //       padding: EdgeInsets.symmetric(vertical: 15)),
              //   icon: Icon(
              //     Icons.g_mobiledata_rounded,
              //     color: Colors.white,
              //   ),
              //   onPressed: () async {
              //     LoginState loginState = await googleLogin.login();
              //     ref.read(loginStateProvider.notifier).state =
              //         loginState.isLogin;
              //     if (loginState.isFreshman) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => SignUpScreen(),
              //         ),
              //       );
              //     }
              //   },
              //   label: Text("????????? ?????????", style: TextStyle(color: Colors.white)),
              // ),
              //EmailSignIn(),
              SizedBox(
                height: 200,
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
                  //util????????? ???????????? ??????????
                  LoginState loginState = await ref
                      .read(userProfileNotifierProvider.notifier)
                      .venderLogin(Vender.kakao);
                  if (loginState.isLogin == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('????????? ????????? ??????'),
                      ),
                    );
                  }
                  if (loginState.isFreshman) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  }
                },
                label:
                    Text("?????????????????? ?????????", style: TextStyle(color: Colors.black)),
              ),

              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //       backgroundColor: Colors.black,
              //       padding: EdgeInsets.symmetric(vertical: 15)),
              //   icon: Icon(
              //     Icons.apple,
              //     color: Colors.white,
              //   ),
              //   onPressed: () async {
              //     // ref.read(loginStateProvider.notifier).state =
              //     //     await kakaoLogin.login();
              //     // if (ref.read(loginStateProvider.notifier).state) {
              //     //   User user = await UserApi.instance.me();
              //     //   log("????????? ???????????????" + user.id.toString());
              //     // }
              //   },
              //   label: Text("APPLE??? ?????????", style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//vender ,
