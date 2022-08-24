import 'dart:convert';
import 'dart:developer';
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
    List<CommunityData> _communityList = [];
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
