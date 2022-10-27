import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Routine/models/routine_models.dart';

//todo: 내루틴 {리스트 get} {get,post,delete,patch}
//todo: 참조루틴 {리스트 get} {get,post,delete,patch}

//get myRoutine list
Future<List<MyRoutine>> getMyRoutineList() async {
  //dio로 get 요청 /routines/my-routines
  final response = await dio.get("/routines/my-routines",
      options: Options(headers: {"Authorization": "true"}));
  log("내루틴 리스트 조회 완료");
  log(response.data.toString());
  try {
    return (response.data as List)
        .map((e) => MyRoutine.liteFromJson(e))
        .toList();
  } catch (e) {
    log("내루틴 리스트 조회 오류");
    throw Exception(e);
  }
}

//get myRoutine by id
Future<MyRoutine> getMyRoutineById(String routineId) async {
  //dio로 get 요청 /routines/my-routines/{id}
  final response = await dio.get("/routines/my-routines/$routineId",
      options: Options(headers: {"Authorization": "true"}));
  log("내루틴 조회 완료");
  log(response.data.toString());
  try {
    return MyRoutine.fromJson(response.data);
  } catch (e) {
    log("내루틴 조회 오류");
    throw Exception(e);
  }
}

//post myRoutine
Future<MyRoutine> postMyRoutine(MyRoutine routine) async {
  //dio로 post 요청 /routines/my-routines
  final response = await dio.post("/routines/my-routines",
      options: Options(headers: {"Authorization": "true"}),
      data: routine.newRoutineToJson());
  try {
    return MyRoutine.fromJson(response.data);
  } catch (e) {
    log("내루틴 생성 오류");
    throw Exception(e);
  }
}

//patch myRoutine
///routine-manuals/{manualId}/routine/{routineId}

Future<void> postMyRoutineManuals(
    List<RoutineManual> routineManuals, String routineId) async {
  //dio로 patch 요청 /routines/my-routines/{id}
  for (int i = 0; i < routineManuals.length; i++) {
    await dio.post(
        "/routine-manuals/${routineManuals[i].manualId}/routine/$routineId",
        options: Options(headers: {"Authorization": "true"}),
        data: routineManuals[i].toJson());
  }
}
