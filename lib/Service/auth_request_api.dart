import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/user_provider.dart';
import 'package:http/http.dart' as http;
import '../Model/models.dart';

//밑의 api를 다 provider에 넣어가지고

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
    print(response.body.toString());
    return UserInfo(
        username: username,
        accessToken: jsonDecode(response.body)["accessToken"]);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)["message"].toString()),
    ));
    print(response.body);
    throw Exception(response.body);
  }
}

Future<UserInfo> UserProfileRequest(accessToken) async {
  var url = Uri.parse('https://api.be-healthy.life/auth/profile');
  log("access: $accessToken");
  final response =
      await http.get(url, headers: {"Authorization": "Bearer $accessToken"});
  if (response.statusCode == 200) {
    var _userData = json.decode(response.body);
    log("회원정보가져오기 완료");
    return UserInfo.fromJson(_userData);
  } else {
    log("회원정보가져오기 오류");
    throw Exception(response.body);
  }
}
