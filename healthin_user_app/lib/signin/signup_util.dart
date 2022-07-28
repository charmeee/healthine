import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

SignUpRequest(username, password, name, nickname, phoneNumber,
    BuildContext context) async {
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
      content: Text("에러코드 : ${response.statusCode}\n오류가 생겼습니다"),
    ));
  }
  print(response.statusCode);
  print(response.body);
}
