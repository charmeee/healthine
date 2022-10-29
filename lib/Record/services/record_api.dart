import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:healthin/Common/dio/dio_main.dart';

import '../models/exerciserecord_model.dart';

//get routineLogByDay /routine-logs/{date}
Future<List<Record>> getRoutineLogByDay(String date) async {
  final response = await dio.get("/routine-logs/$date",
      options: Options(headers: {"Authorization": "true"}));
  log("루틴로그 조회 완료");
  log(response.data.toString());
  try {
    return (response.data as List).map((e) => Record.fromJson(e)).toList();
  } catch (e) {
    log("루틴로그 조회 오류");
    throw Exception(e);
  }
}

//post routineLog /routine-logs
Future<Record> postRoutineLog(Record recode) async {
  final response = await dio.post("/routine-logs",
      options: Options(headers: {"Authorization": "true"}),
      data: recode.toJson());
  log("루틴로그 생성 완료");
  log(response.data.toString());
  try {
    return response.data;
  } catch (e) {
    log("루틴로그 생성 오류");
    throw Exception(e);
  }
}

//patch routineLog /routine-logs/{routineLogId}
Future<void> patchRoutineLog(
    //세트수만 수정가능
    String routineLogId,
    String routineId,
    int setData,
    int playMinute) async {
  final response = await dio.patch("/routine-logs/$routineLogId",
      options: Options(headers: {"Authorization": "true"}),
      data: {
        "setNumber": setData,
        "playMinute": playMinute,
      });
  log("루틴로그 수정 완료");
  log(response.data.toString());
}

//여기서부턴 일단 안쓰는것들
//delete routineLog /routine-logs/{routineLogId}
Future<dynamic> deleteRoutineLog(String routineLogId) async {
  final response = await dio.delete("/routine-logs/$routineLogId",
      options: Options(headers: {"Authorization": "true"}));
  log("루틴로그 삭제 완료");
  log(response.data.toString());
  try {
    return response.data;
  } catch (e) {
    log("루틴로그 삭제 오류");
    throw Exception(e);
  }
}
