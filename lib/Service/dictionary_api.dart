import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:healthin/Model/dictionary_model.dart';
import 'package:healthin/Model/routine_models.dart';

import 'dio/dio_main.dart';

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

Future<List<DictionaryData>> getDicionaryList() async {
  //Future<List<DictionaryData>>
  try {
    final response = await dio.get(
      "/manuals",
    );
    if (response.statusCode == 200) {
      log("사전 메뉴얼 정보가져오기 완료");
      log(response.data.toString());
      List<DictionaryData> dictionaryDataList = [];
      try {
        for (var item in response.data) {
          dictionaryDataList.add(DictionaryData.fromJson(item));
        }
        log(dictionaryDataList[0].description!.length.toString());
        return dictionaryDataList;
      } catch (e) {
        throw Exception(e);
      }
      //return _communityList;
    } else {
      log("사전 메뉴얼 정보가져오기 오류");
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<List<DictionaryData>> getDicionaryListByEquipmentId(
    String equipmentId) async {
  //Future<List<DictionaryData>>
  try {
    final response = await dio.get(
      "/manuals/equipment/$equipmentId",
    );
    if (response.statusCode == 200) {
      log("기구ID로  메뉴얼 정보가져오기 완료");
      log(response.data.toString());
      List<DictionaryData> dictionaryDataList = [];
      try {
        for (var item in response.data) {
          dictionaryDataList.add(DictionaryData.fromJson(item));
        }
        log(dictionaryDataList[0].description!.length.toString());
        return dictionaryDataList;
      } catch (e) {
        throw Exception(e);
      }
      //return _communityList;
    } else {
      log("사전 메뉴얼 정보가져오기 오류");
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception(e);
  }
}
