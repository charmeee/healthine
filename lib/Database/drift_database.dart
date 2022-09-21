import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:healthin/Model/drift/routine_manuals_drift.dart';
import 'package:healthin/Model/drift/routines_drift.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//private 값까지 불러올 수 있음., 사실상 한파일로 인식하는듯한느뀜
part 'drift_database.g.dart';

@DriftDatabase(tables: [Routines, RoutineManuals])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  //create routine routines 에 추가됨.
  Future<int> createRoutine(RoutinesCompanion data) =>
      into(routines).insert(data); //insert는 id값을 리턴해준다ㅏ.

  //create routineManuals routineManuals 에 추가됨.
  Future<int> createRoutineManual(RoutineManualsCompanion data) =>
      into(routineManuals).insert(data);

  Future<List<Routine>> getRoutine() => select(routines).get();

  //stream routine
  Stream<List<Routine>> watchRoutine() => select(routines).watch();

  //stream routineManualsByroutineId
  Stream<List<RoutineManual>> watchRoutineManualsByRoutineId(
          String routineId) =>
      (select(routineManuals)..where((tbl) => tbl.routineId.equals(routineId)))
          .watch();
  //루틴 업데이트
  Future<int> updateRoutineById(String id, RoutinesCompanion data) =>
      (update(routines)..where((tbl) => tbl.id.equals(id))).write(data);
  //루틴 메뉴얼 업데이트
  Future<int> updateRoutineManualById(
          String id, RoutineManualsCompanion data) =>
      (update(routineManuals)..where((tbl) => tbl.id.equals(id))).write(data);

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
  //흠흠흠ㅎ
  //삭제로직 루틴을 삭제하면루틴메뉴얼도 다삭제되어야함.
  //루틴메뉴얼ㅇ
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'local_database.sqlite'));
    return NativeDatabase(file);
  });
}
