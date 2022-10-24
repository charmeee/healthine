import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/diet_model.dart';

Future<DietAiPhotoAnalysis> getDietDataByAi(XFile image) async {
  try {
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(image.path)});
    log('formData) ${formData}');
    final response = await dio.post("/meals/inspect",
        options: Options(headers: {"Authorization": "true"}), data: formData);
    Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
    log('${data}foodData from ai');
    return DietAiPhotoAnalysis.fromJson(data);
  } catch (e) {
    log("식단 정보가져오기 오류");
    throw Exception(e);
  }
}

Future<void> postDiet(DietDetailResult diet) async {
  await dio.post("/meals",
      options: Options(headers: {"Authorization": "true"}),
      data: jsonEncode(diet.toJson()));
  return;
}

Future<void> getDietById(int id) async {
  await dio.delete("/meals/$id",
      options: Options(headers: {"Authorization": "true"}));
  return;
}

Future<DayDietStatistics> getDietStatistics(DateTime date) async {
  String formattedDate = DateFormat("yyyy-MM-dd").format(date);
  try {
    final response = await dio.get("/meals/$formattedDate",
        options: Options(headers: {"Authorization": "true"}));
    log("식단 통계 조회 완료");
    log(response.data.toString());
    try {
      return DayDietStatistics.fromJson(response.data);
    } catch (e) {
      log("식단 통계 조회 오류");
      throw Exception(e);
    }
    return DayDietStatistics.fromJson(response.data);
  } catch (e) {
    log("식단 통계 조회 오류");
    throw Exception(e);
  }
}
