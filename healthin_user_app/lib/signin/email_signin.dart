import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailSignIn extends StatelessWidget {
  const EmailSignIn({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(labelText: 'Enter email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Enter password'),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      //todo:로그인요청보내고 하는등의 기능작업안함
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
    ;
  }
}
