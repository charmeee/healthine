import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  var client = http.Client();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 150)),
            Center(
              child: Image.asset(
                "assets/splashicon.png",
                height: 100,
              ),
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
                padding: EdgeInsets.all(40),
                child: Column(
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
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.all(20),
                        ),
                        child: Text("로그인하기",
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
