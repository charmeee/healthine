import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:healthin/Model/drift/user_exercise_record.dart';
import 'package:healthin/Model/drift/user_routine_manuals_drift.dart';
import 'package:healthin/Model/drift/user_routines_drift.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

//private 값까지 불러올 수 있음., 사실상 한파일로 인식하는듯한느뀜
part 'drift_database.g.dart';

final _uuid = Uuid();

@DriftDatabase(tables: [UserRoutines, UserRoutineManuals, UserExerciseRecords])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  //create routine routines 에 추가됨.
  Future<int> createRoutine(UserRoutinesCompanion data) =>
      into(userRoutines).insert(data); //insert는 id값을 리턴해준다ㅏ.

  //create routineManuals routineManuals 에 추가됨.
  Future<int> createRoutineManual(UserRoutineManualsCompanion data) =>
      into(userRoutineManuals).insert(data);

  Future<List<UserRoutine>> getUserRoutine() => select(userRoutines).get();

  //stream routine
  Stream<List<UserRoutine>> watchUserRoutine() => select(userRoutines).watch();

  //stream routineManualsByroutineId
  Stream<List<UserRoutineManual>> watchUserRoutineManualsByUserRoutineId(
          String routineId) =>
      (select(userRoutineManuals)
            ..where((tbl) => tbl.routineId.equals(routineId)))
          .watch();
  //루틴 업데이트
  Future<int> updateUserRoutineById(String id, UserRoutinesCompanion data) =>
      (update(userRoutines)..where((tbl) => tbl.id.equals(id))).write(data);
  //루틴 메뉴얼 업데이트
  Future<int> updateUserRoutineManualById(
          String id, UserRoutineManualsCompanion data) =>
      (update(userRoutineManuals)..where((tbl) => tbl.id.equals(id)))
          .write(data);

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
