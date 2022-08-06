import 'package:flutter/material.dart';

import 'request_util.dart';
//import 'package:http/http.dart' as http;

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 150)),
        Center(
          child: Image.asset(
            "assets/splashicon.png",
            height: 100,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Form(
            child: Theme(
          data: ThemeData(
              primaryColor: Colors.indigo,
              inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(
                color: Colors.indigo,
                fontSize: 15,
              ))),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: '아이디를 입력해주세요'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호를 입력해주세요'),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      LoginRequest(_idController.text, _passwordController.text,
                          context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: EdgeInsets.all(20),
                    ),
                    child: Text("로그인하기", style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        )),
      ],
    );
  }
}
