import 'package:flutter/material.dart';

import 'package:healthin/Service/auth_request_api.dart';

class GetInfo extends StatefulWidget {
  GetInfo({Key? key, required this.userEmail}) : super(key: key);
  // todo: 나중에 assess key를 비번대신 주면될듯^~^

  var userEmail;

  @override
  State<GetInfo> createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _nicknameController = TextEditingController();

  void _performLogin(BuildContext context) async {
    String username = widget.userEmail;
    String password = "fiowfef"; //accesstoken위치
    String name = await _nameController.text;
    String phoneNumber = await _phoneController.text;
    String nickname = await _nicknameController.text;
    await await UserCreateRequest(
        username, password, name, nickname, phoneNumber, context);
    //print('login attempt: $username with $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 40)),
                Center(
                  child: Image.asset(
                    "assets/splashicon.png",
                    height: 100,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
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
                          decoration:
                              InputDecoration(labelText: '전화번호를 입력해주세요'),
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
      ),
    );
  }
}
