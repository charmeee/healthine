import 'package:drift/drift.dart';

class ExerciseRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get reps => integer()();
  IntColumn get sets => integer()();
  IntColumn get weight => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get exerciseId => integer()();
  @override
  Set<Column> get primaryKey => {id};
}
