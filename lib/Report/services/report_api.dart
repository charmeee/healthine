import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:healthin/Common/dio/dio_main.dart';

import '../models/report_model.dart';

// post /reports
Future<Report> createNewReport() async {
  Report report = Report.init();
  final response = await dio.post("/reports",
      options: Options(headers: {"Authorization": "true"}),
      data: report.toJson());
  log("리포트 생성 완료");
  log(response.data.toString());
  try {
    return Report.fromJson(response.data);
  } catch (e) {
    log("리포트 생성 오류");
    throw Exception(e);
  }
}
// Future<Record> postRoutineLog(Record recode) async {
//   final response = await dio.post("/routine-logs",
//       options: Options(headers: {"Authorization": "true"}),
//       data: recode.toPostJson());
//   log("루틴로그 생성 완료");
//   log(response.data.toString());
//   try {
//     return Record.fromJson(response.data);
//   } catch (e) {
//     log("루틴로그 생성 오류");
//     throw Exception(e);
//   }
// }
