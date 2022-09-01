import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:healthin/Model/dictionary_model.dart';
import 'package:healthin/Model/routine_models.dart';

Future<List<DictionaryData>> readDictionaryJson() async {
  //json파일 읽어오기
  final String response =
      await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  Map<String, dynamic> _alldata = await jsonDecode(response);
  List<DictionaryData> alldata = [];
  alldata = [
    ..._alldata["exerciseType"].map((item) => DictionaryData.fromJson(item))
  ];
  return alldata;
}
