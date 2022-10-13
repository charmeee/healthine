import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Community/models/community_model.dart';

import '../models/diet_model.dart';

Future<List<DietResult>> getDietData(imagePath) async {
  try {
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(imagePath)});
    final response = await dio.post("/meals/inspect",
        options: Options(headers: {"Authorization": "true"}), data: formData);

    if (response.statusCode == 200) {
      log("식단 정보 조회 완료");
      log(response.data.toString());
      return DietModel.fromJson(response.data).results;
    } else {
      log("식단 정보가져오기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}
