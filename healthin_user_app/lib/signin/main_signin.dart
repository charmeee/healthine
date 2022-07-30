import 'package:flutter/material.dart';
import 'package:healthin/signin/social_signup_get_info.dart';
import '../main_layout.dart';
import 'email_signin.dart';
import 'signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signup_util.dart';

class MainSignIn extends StatelessWidget {
  const MainSignIn({Key? key}) : super(key: key);
  Future<void> googleSignIn(context) async {
    final _googleSignIn = GoogleSignIn(
      clientId:
          "812774997300-qmjr67kjsue5up5vupt9f9teicnq49r9.apps.googleusercontent.com",
    );
    try {
      var googleLoginResult = await _googleSignIn.signIn();
      if (googleLoginResult != null) {
        var ggauth = await googleLoginResult.authentication;
        if (ggauth != null) {
          print("----ggauth를받았다!");
          print(ggauth.accessToken);
          print(ggauth.idToken);
        }
        print("----시작----");
        print(googleLoginResult.email);
        print(googleLoginResult.displayName);
        print("----완료----");
        //SignInRequest(googleLoginResult.email, "fiowfef", context);
      }
    } catch (e) {
      print("\n---LoginFailed\n");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("로그인 실패")));
      print(e);
    }
  }

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
                onPressed: () {
                  googleSignIn(context);
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
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("로그인 실패")));
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
