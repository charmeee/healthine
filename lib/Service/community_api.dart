import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:healthin/Model/models.dart';

//Future<List<CommunityData>>
void getComunnityData(accessToken) async {
  var url = Uri.parse('https://api.be-healthy.life/auth/boards');

  final response =
      await http.get(url, headers: {"Authorization": "Bearer $accessToken"});
  if (response.statusCode == 200) {
    var _communityData = json.decode(response.body);
    log("커뮤니티 정보가져오기 완료");
    List<CommunityBoardData> _communityList = [];
    try {
      _communityList = [
        ..._communityData["routineData"]
            .map((item) => RoutineData.fromJson(item))
      ];
    } catch (e) {
      print(e);
    }
    //return _communityList;
  } else {
    log("커뮤니티 정보가져오기 오류");
    throw Exception(response.body);
  }
}

Future<CommunityBoardData> readCommmunityDataJson(String id) async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  Map<String, dynamic> _alldata = await jsonDecode(response);
  CommunityBoardData alldata;
  // var temp = _alldata["community"].firstWhere((item) => item["id"] == id,
  //     orElse: () => Exception("맞는 id 값이 없음"));
  // log(temp.runtimeType.toString());
  // log(temp);
  // alldata = temp.map((data) => CommunityBoardData.fromJson(data));
  alldata = CommunityBoardData.fromJson(_alldata["community"].firstWhere(
      (item) => item["id"] == id,
      orElse: () => Exception("맞는 id 값이 없음")));
  return alldata;
}

Future<List<CommunityBoardsList>> readCommmunityListJson() async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  Map<String, dynamic> _alldata = await jsonDecode(response);
  List<CommunityBoardsList> alldata = [];
  alldata = [
    ..._alldata["communityList"]
        .map((item) => CommunityBoardsList.fromJson(item))
  ];
  return alldata;
}
