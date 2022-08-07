import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/models.dart';

Future<UserInfo> UserCreateRequest(username, password, name, nickname,
    phoneNumber, BuildContext context) async {
  print('SignUp attempt: $username with $password');
  var url = Uri.parse('https://api.be-healthy.life/users');
  var response = await http.post(url, body: {
    "username": username.toString(), //아디디
    "password": password.toString(),
    "name": name.toString(),
    "nickname": nickname.toString(),
    "phoneNumber": phoneNumber.toString()
  });

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$name님 회원가입되셨습니다."),
    ));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
    print("회원가입완료.");

    return UserInfo(
        username: username.toString(),
        name: name.toString(),
        nickname: nickname.toString(),
        phoneNumber: phoneNumber.toString());
  } else {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)["message"].toString()),
    ));
    throw Exception(response.body);
  }
}

Future<UserInfo> LoginRequest(username, password, context) async {
  print('login attempt: $username with $password');
  var url = Uri.parse('https://api.be-healthy.life/auth/login');
  var response = await http.post(url, body: {
    "username": username.toString(), //아이디
    "password": password.toString(),
  });
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$username님 로그인되었습니다."),
    ));
    print("로그인완료.");
    return UserInfo(username: username);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)["message"].toString()),
    ));
    print(response.body);
    throw Exception(response.body);
  }
}

Future<UserInfo> UserProfileRequest(username) async {
  var url = Uri.parse('https://api.be-healthy.life/users/${username}');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    log("회원정보가져오기 완료");
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
