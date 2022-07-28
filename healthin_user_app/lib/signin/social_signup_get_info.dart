import 'package:flutter/material.dart';

import 'signup_util.dart';

class GetInfo extends StatelessWidget {
  GetInfo({Key? key, required this.userEmail}) : super(key: key);
  // todo: 나중에 assess key를 비번대신 주면될듯^~^

  var userEmail;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nicknameController = TextEditingController();

  void _performLogin(BuildContext context) {
    String username = userEmail;
    String password = "fiowfef"; //accesstoken위치
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;
    String nickname = _nicknameController.text;
    SignUpRequest(username, password, name, nickname, phoneNumber, context);
    //print('login attempt: $username with $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40)),
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            _performLogin(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: EdgeInsets.all(20),
                          ),
                          child: Text("시작하기!",
                              style: TextStyle(color: Colors.white)))
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
