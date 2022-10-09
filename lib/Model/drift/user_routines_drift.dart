import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserRoutines extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get routineName => text()();

  //진행여부
  TextColumn get day => text()(); //기본 월~일
}
