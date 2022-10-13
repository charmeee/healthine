import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserExerciseRecords extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get exerciseId => text()(); //운동 id ->dictionary에 나온 운동들의 id값.
  IntColumn get order => integer()();

  //근력
  IntColumn get weight => integer()();

  //한운동
  IntColumn get setPerNum => integer()();
  IntColumn get didSet => integer()(); //1세트 다 완료안했으면 0
  IntColumn get didTime => integer()(); //chrlwns.

}
