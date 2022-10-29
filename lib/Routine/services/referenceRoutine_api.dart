import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Routine/models/routine_models.dart';

//get /routines
Future<List<ReferenceRoutine>> getReferenceRoutineList(
    int page, int limit) async {
  //dio로 get 요청 /routines
  final response = await dio.get("/routines?page=$page&limit=$limit",
      options: Options(headers: {"Authorization": "true"}));
  log("참조루틴 리스트 조회 완료");
  log(response.data.toString());
  log(response.data["items"].toString());

  try {
    return (response.data["items"] as List)
        .map((e) => ReferenceRoutine.liteFromJson(e))
        .toList();
  } catch (e) {
    log("참조루틴 리스트 조회 오류");
    throw Exception(e);
  }
}

///routines/{routineId}

Future<ReferenceRoutine> getReferenceRoutine(String referenceId) async {
  final response = await dio.get("/routines/$referenceId",
      options: Options(headers: {"Authorization": "true"}));
  log("참조루틴 조회 완료");
  log(response.data.toString());
  try {
    return ReferenceRoutine.fromJson(response.data);
  } catch (e) {
    log("참조루틴 조회 오류");
    throw Exception(e);
  }
}
