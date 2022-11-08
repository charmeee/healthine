import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:healthin/User/services/social_api.dart';

//import 'package:http/http.dart' as http;

class EmailSignIn extends ConsumerStatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends ConsumerState<EmailSignIn> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    onPressed: () async {
                      LoginState loginState = await ref
                          .read(userProfileNotifierProvider.notifier)
                          .nativeLogin(
                              _idController.text, _passwordController.text);
                      if (loginState.isLogin == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('카카오 로그인 실패'),
                          ),
                        );
                      }
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
