import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';

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
