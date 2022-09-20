import 'package:drift/drift.dart';

class RoutineManuals extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();

  //진행여부
  TextColumn get status => text()();

  //근력
  IntColumn get weight => integer()();

  //목표
  IntColumn get goalNum => integer()();
  IntColumn get goalSet => integer()();
  IntColumn get goalTime => integer()(); //전체세트

  //근력
  IntColumn get nowSet => integer()();

  //유산소
  IntColumn get didTime => integer()();
}
