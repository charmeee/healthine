import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserRoutines extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get routineName => text()();
}
