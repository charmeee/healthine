import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/User/models/user_model.dart';


import '../providers/user_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpScreen> {
  final _nicknameController = TextEditingController();

  Future<void> _performLogin(BuildContext context) async {
    String nickname = _nicknameController.text;
    try {
      final result = await ref
          .read(userProfileNotifierProvider.notifier)
          .updateUserProfile(nickname);
      if (result) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('닉네임 변경 실패'),
          ),
        );
      }
      //fetch user nickname
    } catch (e) {
      print("회원가입실패");
    }

    //print('login attempt: $username with $password');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(userProfileNotifierProvider.notifier).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = ref.watch(userProfileNotifierProvider);
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
            Padding(padding: EdgeInsets.only(top: 100)),
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
    );
  }
}
