import 'package:drift/drift.dart';

class ExerciseRecords extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();

  TextColumn get status => text()();

  IntColumn get doingTime => integer()();
  //근력
  IntColumn get weight => integer()();
  IntColumn get doingSet => integer()();
  IntColumn get doingNum => integer()();
  //근력
  IntColumn get numPerSet => integer()();
  IntColumn get totalSet => integer()(); //전체세트

  //유산소
  IntColumn get totalTime => integer()();

  DateTimeColumn get date => dateTime().clientDefault(() => DateTime.now())();
}
