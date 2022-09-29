import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:http/http.dart' as http;

import 'package:healthin/Model/routine_models.dart';

import 'dio/dio_main.dart';

//게시글 목록 조회
Future<List<CommunityBoardList>> getCommunityBoardList(
    int page, int limit, String boardId) async {
  try {
    final response =
        await dio.get("/boards/$boardId/posts?page=$page&limit=$limit");
    if (response.statusCode == 200) {
      log("게시글 목록 조회 완료");
      List<CommunityBoardList> communityBoardList = [];
      try {
        communityBoardList = [
          ...response.data.map((item) => CommunityBoardList.fromJson(item))
        ];
        return communityBoardList;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      log("커뮤니티 정보가져오기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}

//커뮤니티 분류 정보
Future<List<CommunityBoardsType>> getCommunityBoardsType() async {
  try {
    final response = await dio.get("/boards");
    if (response.statusCode == 200) {
      log("커뮤니티 분류 정보가져오기 완료");
      List<CommunityBoardsType> communityBoardsTypeList = [];
      try {
        communityBoardsTypeList = [
          ...response.data.map((item) => CommunityBoardsType.fromJson(item))
        ];
        return communityBoardsTypeList;
      } catch (e) {
        throw Exception(e);
      }
      //return _communityList;
    } else {
      log("커뮤니티 정보가져오기 오류");
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<CommunityBoardList> readCommmunityDataJson(String id) async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  Map<String, dynamic> _alldata = await jsonDecode(response);
  CommunityBoardList alldata;
  alldata = CommunityBoardList.fromJson(_alldata["community"].firstWhere(
      (item) => item["id"] == id,
      orElse: () => Exception("맞는 id 값이 없음")));
  return alldata;
}

Future<List<CommunityBoardsType>> readCommmunityListJson() async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  Map<String, dynamic> _alldata = await jsonDecode(response);
  List<CommunityBoardsType> alldata = [];
  alldata = [
    ..._alldata["communityList"]
        .map((item) => CommunityBoardsType.fromJson(item))
  ];

  return alldata;
}
