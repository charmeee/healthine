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
    log("error: $e");
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
Future<void> patchMyRoutine(
    Map<String, dynamic> routine, String routineId) async {
  //dio로 patch 요청 /routines/my-routines/{id}
  await dio.patch("/routines/${routineId}",
      options: Options(headers: {"Authorization": "true"}), data: routine);
}

//delete myRoutine
Future<void> deleteMyRoutine(String routineId) async {
  //dio로 delete 요청 /routines/my-routines/{id}
  await dio.delete("/routines/$routineId",
      options: Options(headers: {"Authorization": "true"}));
}

//post myRoutineManual
Future<void> postMyRoutineManual(
    RoutineManual routineManual, String routineId) async {
  //dio로 patch 요청 /routines/my-routines/{id}
  await dio.post(
      "/routine-manuals/${routineManual.manualId}/routine/$routineId",
      options: Options(headers: {"Authorization": "true"}),
      data: routineManual.isCardio
          ? routineManual.cardioToJson()
          : routineManual.weightToJson());
}

//patch myRoutineManual /routine-manuals/{routineManualId}
Future<void> patchMyRoutineManual(RoutineManual routineManual) async {
  //dio로 patch 요청 /routines/my-routines/{id}
  log(routineManual.routineManualId);
  await dio.patch("/routine-manuals/${routineManual.routineManualId}",
      options: Options(headers: {"Authorization": "true"}),
      data: routineManual.isCardio
          ? routineManual.cardioToJson()
          : routineManual.weightToJson());
}

//delete myRoutineManual /routine-manuals/{routineManualId}
Future<void> deleteMyRoutineManual(String routineManualId) async {
  //dio로 patch 요청 /routines/my-routines/{id}
  await dio.delete("/routine-manuals/$routineManualId",
      options: Options(headers: {"Authorization": "true"}));
}
