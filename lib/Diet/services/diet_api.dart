import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:image_picker/image_picker.dart';

import '../models/diet_model.dart';

Future<DietPhotoResult> getDietDataByAi(XFile image) async {
  try {
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(image.path)});
    log(formData.toString() + 'formData');
    log(formData.runtimeType.toString() + 'formData');
    final response = await dio.post("/meals/inspect",
        options: Options(headers: {"Authorization": "true"}), data: formData);

    if (response.statusCode == 201) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      log(data.toString() + 'foodData from ai');
      return DietPhotoResult.fromJson(data);
    } else {
      log("식단 정보가져오기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> postDietData(DayDiet diet) async {
  await dio.post("/meals",
      options: Options(headers: {"Authorization": "true"}),
      data: jsonEncode(diet.toJson()));
  return;
}
