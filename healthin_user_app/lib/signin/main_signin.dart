import 'package:flutter/material.dart';
import '../mainstructure.dart';
import 'email_signin.dart';
import 'signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainSignIn extends StatelessWidget {
  const MainSignIn({Key? key}) : super(key: key);
  Future<void> googleSignIn(context) async {
    final _googleSignIn = GoogleSignIn(
        clientId:
            '812774997300-qmjr67kjsue5up5vupt9f9teicnq49r9.apps.googleusercontent.com');
    try {
      var googleLoginResult = await _googleSignIn.signIn();
      print(googleLoginResult!.email);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyHome()));
    } catch (e) {
      print("\nfail iuhiuhuh\n");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("로그인 실패")));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15)),
              icon: Icon(Icons.email),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmailSignIn()));
              },
              label: Text("이메일로 로그인"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15)),
              icon: Icon(Icons.g_mobiledata_rounded),
              onPressed: () {
                googleSignIn(context);
              },
              label: Text("구글로 로그인"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15)),
              icon: Icon(Icons.message),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("로그인 실패")));
              },
              label: Text("카카오톡으로 로그인"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text("회원가입하기"),
            ),
          ],
        ),
      ),
    );
  }
}
