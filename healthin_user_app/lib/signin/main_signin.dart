import 'package:flutter/material.dart';
import 'email_signin.dart';
import 'signup.dart';

class MainSignIn extends StatelessWidget {
  const MainSignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () {},
            label: Text("구글로 로그인"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15)),
            icon: Icon(Icons.message),
            onPressed: () {},
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
    );
  }
}
