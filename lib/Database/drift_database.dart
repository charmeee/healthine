import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:healthin/Model/drift/exerciserecord_drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//private 값까지 불러올 수 있음., 사실상 한파일로 인식하는듯한느뀜
part 'drift_database.g.dart';

@DriftDatabase(tables: [ExerciseRecords])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createExerciseRecord(ExerciseRecordsCompanion data) =>
      into(exerciseRecords).insert(data);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'local_database.sqlite'));
    return NativeDatabase(file);
  });
}
