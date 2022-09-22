import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserRoutineManuals extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get routineId => text()();
  TextColumn get exerciseId => text()(); //운동 id ->dictionary에 나온 운동들의 id값.
  IntColumn get order => integer()();

  //진행여부
  TextColumn get day => text()(); //기본 월~일

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
