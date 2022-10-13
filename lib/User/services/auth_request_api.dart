import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Database/secureStorage.dart';
import 'package:healthin/Common/dio/dio_main.dart';

import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:healthin/User/services/social_api.dart';
import 'package:http/http.dart' as http;

//밑의 api를 다 provider에 넣어가지고

Future<LoginState> sendVendorToken(
    String venderAccessToken, String vendor) async {
  try {
    final response = await dio.post("/auth/login",
        data: {"accessToken": venderAccessToken, "vendor": vendor});
    log("kakaoTalkToken{ data:${response.data}, statusCode:${response.statusCode} }");
    if (response.statusCode == 201) {
      log("access token 발급 완료  ${response.data["accessToken"]}");
      storage.delete(key: "accessToken");
      storage.write(key: "accessToken", value: response.data["accessToken"]);
      if (response.data["isFreshman"] == true) {
        return LoginState(isLogin: true, isFreshman: true);
      }
      return LoginState(isLogin: true, isFreshman: false);
    } else {
      log("server cant login");
      return LoginState(isLogin: false, isFreshman: false);
    }
  } catch (e) {
    log("kakaoTalkToken{ error:$e }");
    return LoginState(isLogin: false, isFreshman: false);
  }
}

Future<UserInfo> userProfileRequest() async {
  try {
    final response = await dio.get("/auth/profile",
        options: Options(headers: {"Authorization": "true"}));
    if (response.statusCode == 200) {
      return UserInfo(
        id: response.data["id"],
        username: response.data["username"],
        nickname: response.data["nickname"],
        userEmail: response.data["userEmail"],
        gender: response.data["gender"],
        ageRange: response.data["ageRange"],
      );
    } else {
      throw Exception("회원정보가져오기 오류코드${response.data}");
    }
  } catch (e) {
    throw Exception("회원정보가져오기 오류코드${e}");
  }
}

Future<void> refreshTokenRequest() async {
  try {
    final response = await dio.patch("/auth/refresh", data: {});
    if (response.statusCode == 200) {
      log("refresh token 발급 완료  ${response.data["accessToken"]}");
      storage.delete(key: "accessToken");
      storage.write(key: "accessToken", value: response.data["accessToken"]);
    } else {
      log("server cant refresh");
    }
  } catch (e) {
    log("refreshTokenRequest{ error:$e }");
  }
}

Future<void> logoutRequest() async {
  try {
    final response = await dio.delete("/auth/logout",
        options: Options(headers: {"Authorization": "true"}));
    if (response.statusCode == 200) {
      log("logoutRequest{ data:${response.data}, statusCode:${response.statusCode} }");
      storage.delete(key: "accessToken");
    } else {
      log("server cant logout");
    }
  } catch (e) {
    log("logoutRequest{ error:$e }");
  }
}

Future<bool> UserUpdateRequest(UserInfo userInfo) async {
  //type, value
  try {
    final response = await dio.patch("/users/${userInfo.id}",
        options: Options(headers: {"Authorization": "true"}),
        data: {"nickname": userInfo.nickname});
    if (response.statusCode != 200) {
      throw Exception("UserUpdateRequest 오류코드${response.data}");
    } else {
      return true;
    }
  } catch (e) {
    throw Exception("UserUpdateRequest 오류코드${e}");
  }
}
