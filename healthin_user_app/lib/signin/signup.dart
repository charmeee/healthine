import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var client = http.Client();

  SignUpRequest(username, password, name, nickname, phoneNumber) async {
    var url = Uri.parse('https://api.be-healthy.life/users');
    var response = await http.post(url,
        body: json.encode({
          "username": '$username',
          "password": '$password',
          "name": '$name',
          "nickname": '$nickname',
          "phoneNumber": '$phoneNumber'
        }));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$name님 회원가입되셨습니다."),
      ));

      print("로그인되었습니다.");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$name님 회원가입되셨습니다."),
      ));
    }
    print(response.statusCode);
    print(response.body);
  }

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nicknameController = TextEditingController();

  void _performLogin() {
    String username = _idController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;
    String nickname = _nicknameController.text;
    SignUpRequest(username, password, name, nickname, phoneNumber);
    //print('login attempt: $username with $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "회원가입하기",
          style: TextStyle(color: Colors.white),
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
                      controller: _idController,
                      decoration: InputDecoration(labelText: '아이디를 입력해주세요'),
                      keyboardType: TextInputType.text,
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
                      height: 10,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: '성함을 입력해주세요'),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: '전화번호를 입력해주세요'),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(labelText: '닉네임을 입력해주세요'),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          _performLogin();
                        },
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