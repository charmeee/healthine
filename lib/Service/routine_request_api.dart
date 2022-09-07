import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:healthin/Model/routine_models.dart';

Future<List<RoutineData>> readRoutineJson() async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  //print(response.runtimeType);w
  Map<String, dynamic> _alldata = await jsonDecode(response);
  log("키들 :" + _alldata.keys.toString());
  // List<RoutineData> _data = [
  //   ..._alldata["routineData"].map((item) => RoutineData.fromJson(item))
  // ];
  // log(_alldata.keys.toString());
  // log(_data[0].toString());
  List<RoutineData> _routineList = [];
  _routineList = [
    ..._alldata["routineData"].map((item) => RoutineData.fromJson(item))
  ];
  return _routineList;
}
