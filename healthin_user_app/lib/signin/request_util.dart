import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthin/main_layout.dart';
import 'package:http/http.dart' as http;

import '../models.dart';
import 'social_signup_get_info.dart';

SignUpRequest(username, password, name, nickname, phoneNumber,
    BuildContext context) async {
  print('SignUp attempt: $username with $password');
  var url = Uri.parse('https://api.be-healthy.life/users');
  var response = await http.post(url, body: {
    "username": username.toString(),
    "password": password.toString(),
    "name": name.toString(),
    "nickname": nickname.toString(),
    "phoneNumber": phoneNumber.toString()
  });

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$name님 회원가입되셨습니다."),
    ));
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
    print("회원가입완료.");
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)["message"].toString()),
    ));
  }
  print(response.body);
}

SignInRequest(username, password, context) async {
  print('login attempt: $username with $password');
  var url = Uri.parse('https://api.be-healthy.life/auth/login');
  var response = await http.post(url, body: {
    "username": username.toString(),
    "password": password.toString(),
  });
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$username님 로그인되었습니다."),
    ));

    print("로그인완료.");
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)["message"].toString()),
    ));
    print(response.body);
  }
}

UserdataRequest() {}
