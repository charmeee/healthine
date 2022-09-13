import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Database/drift_database.dart';

final localDatabaseProvider = Provider((ref) {
  return LocalDatabase();
});
