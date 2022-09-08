// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ExerciseRecord extends DataClass implements Insertable<ExerciseRecord> {
  final String id;
  final String name;
  final String type;
  final String status;
  final int doingTime;
  final int weight;
  final int doingSet;
  final int doingNum;
  final int numPerSet;
  final int totalSet;
  final int totalTime;
  final DateTime date;
  const ExerciseRecord(
      {required this.id,
      required this.name,
      required this.type,
      required this.status,
      required this.doingTime,
      required this.weight,
      required this.doingSet,
      required this.doingNum,
      required this.numPerSet,
      required this.totalSet,
      required this.totalTime,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['doing_time'] = Variable<int>(doingTime);
    map['weight'] = Variable<int>(weight);
    map['doing_set'] = Variable<int>(doingSet);
    map['doing_num'] = Variable<int>(doingNum);
    map['num_per_set'] = Variable<int>(numPerSet);
    map['total_set'] = Variable<int>(totalSet);
    map['total_time'] = Variable<int>(totalTime);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ExerciseRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseRecordsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      status: Value(status),
      doingTime: Value(doingTime),
      weight: Value(weight),
      doingSet: Value(doingSet),
      doingNum: Value(doingNum),
      numPerSet: Value(numPerSet),
      totalSet: Value(totalSet),
      totalTime: Value(totalTime),
      date: Value(date),
    );
  }

  factory ExerciseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      doingTime: serializer.fromJson<int>(json['doingTime']),
      weight: serializer.fromJson<int>(json['weight']),
      doingSet: serializer.fromJson<int>(json['doingSet']),
      doingNum: serializer.fromJson<int>(json['doingNum']),
      numPerSet: serializer.fromJson<int>(json['numPerSet']),
      totalSet: serializer.fromJson<int>(json['totalSet']),
      totalTime: serializer.fromJson<int>(json['totalTime']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'doingTime': serializer.toJson<int>(doingTime),
      'weight': serializer.toJson<int>(weight),
      'doingSet': serializer.toJson<int>(doingSet),
      'doingNum': serializer.toJson<int>(doingNum),
      'numPerSet': serializer.toJson<int>(numPerSet),
      'totalSet': serializer.toJson<int>(totalSet),
      'totalTime': serializer.toJson<int>(totalTime),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  ExerciseRecord copyWith(
          {String? id,
          String? name,
          String? type,
          String? status,
          int? doingTime,
          int? weight,
          int? doingSet,
          int? doingNum,
          int? numPerSet,
          int? totalSet,
          int? totalTime,
          DateTime? date}) =>
      ExerciseRecord(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        status: status ?? this.status,
        doingTime: doingTime ?? this.doingTime,
        weight: weight ?? this.weight,
        doingSet: doingSet ?? this.doingSet,
        doingNum: doingNum ?? this.doingNum,
        numPerSet: numPerSet ?? this.numPerSet,
        totalSet: totalSet ?? this.totalSet,
        totalTime: totalTime ?? this.totalTime,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('ExerciseRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('doingTime: $doingTime, ')
          ..write('weight: $weight, ')
          ..write('doingSet: $doingSet, ')
          ..write('doingNum: $doingNum, ')
          ..write('numPerSet: $numPerSet, ')
          ..write('totalSet: $totalSet, ')
          ..write('totalTime: $totalTime, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, status, doingTime, weight,
      doingSet, doingNum, numPerSet, totalSet, totalTime, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.status == this.status &&
          other.doingTime == this.doingTime &&
          other.weight == this.weight &&
          other.doingSet == this.doingSet &&
          other.doingNum == this.doingNum &&
          other.numPerSet == this.numPerSet &&
          other.totalSet == this.totalSet &&
          other.totalTime == this.totalTime &&
          other.date == this.date);
}

class ExerciseRecordsCompanion extends UpdateCompanion<ExerciseRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> status;
  final Value<int> doingTime;
  final Value<int> weight;
  final Value<int> doingSet;
  final Value<int> doingNum;
  final Value<int> numPerSet;
  final Value<int> totalSet;
  final Value<int> totalTime;
  final Value<DateTime> date;
  const ExerciseRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.doingTime = const Value.absent(),
    this.weight = const Value.absent(),
    this.doingSet = const Value.absent(),
    this.doingNum = const Value.absent(),
    this.numPerSet = const Value.absent(),
    this.totalSet = const Value.absent(),
    this.totalTime = const Value.absent(),
    this.date = const Value.absent(),
  });
  ExerciseRecordsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String status,
    required int doingTime,
    required int weight,
    required int doingSet,
    required int doingNum,
    required int numPerSet,
    required int totalSet,
    required int totalTime,
    this.date = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        status = Value(status),
        doingTime = Value(doingTime),
        weight = Value(weight),
        doingSet = Value(doingSet),
        doingNum = Value(doingNum),
        numPerSet = Value(numPerSet),
        totalSet = Value(totalSet),
        totalTime = Value(totalTime);
  static Insertable<ExerciseRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? status,
    Expression<int>? doingTime,
    Expression<int>? weight,
    Expression<int>? doingSet,
    Expression<int>? doingNum,
    Expression<int>? numPerSet,
    Expression<int>? totalSet,
    Expression<int>? totalTime,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (doingTime != null) 'doing_time': doingTime,
      if (weight != null) 'weight': weight,
      if (doingSet != null) 'doing_set': doingSet,
      if (doingNum != null) 'doing_num': doingNum,
      if (numPerSet != null) 'num_per_set': numPerSet,
      if (totalSet != null) 'total_set': totalSet,
      if (totalTime != null) 'total_time': totalTime,
      if (date != null) 'date': date,
    });
  }

  ExerciseRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? status,
      Value<int>? doingTime,
      Value<int>? weight,
      Value<int>? doingSet,
      Value<int>? doingNum,
      Value<int>? numPerSet,
      Value<int>? totalSet,
      Value<int>? totalTime,
      Value<DateTime>? date}) {
    return ExerciseRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      doingTime: doingTime ?? this.doingTime,
      weight: weight ?? this.weight,
      doingSet: doingSet ?? this.doingSet,
      doingNum: doingNum ?? this.doingNum,
      numPerSet: numPerSet ?? this.numPerSet,
      totalSet: totalSet ?? this.totalSet,
      totalTime: totalTime ?? this.totalTime,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (doingTime.present) {
      map['doing_time'] = Variable<int>(doingTime.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (doingSet.present) {
      map['doing_set'] = Variable<int>(doingSet.value);
    }
    if (doingNum.present) {
      map['doing_num'] = Variable<int>(doingNum.value);
    }
    if (numPerSet.present) {
      map['num_per_set'] = Variable<int>(numPerSet.value);
    }
    if (totalSet.present) {
      map['total_set'] = Variable<int>(totalSet.value);
    }
    if (totalTime.present) {
      map['total_time'] = Variable<int>(totalTime.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('doingTime: $doingTime, ')
          ..write('weight: $weight, ')
          ..write('doingSet: $doingSet, ')
          ..write('doingNum: $doingNum, ')
          ..write('numPerSet: $numPerSet, ')
          ..write('totalSet: $totalSet, ')
          ..write('totalTime: $totalTime, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $ExerciseRecordsTable extends ExerciseRecords
    with TableInfo<$ExerciseRecordsTable, ExerciseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _doingTimeMeta = const VerificationMeta('doingTime');
  @override
  late final GeneratedColumn<int> doingTime = GeneratedColumn<int>(
      'doing_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _doingSetMeta = const VerificationMeta('doingSet');
  @override
  late final GeneratedColumn<int> doingSet = GeneratedColumn<int>(
      'doing_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _doingNumMeta = const VerificationMeta('doingNum');
  @override
  late final GeneratedColumn<int> doingNum = GeneratedColumn<int>(
      'doing_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _numPerSetMeta = const VerificationMeta('numPerSet');
  @override
  late final GeneratedColumn<int> numPerSet = GeneratedColumn<int>(
      'num_per_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _totalSetMeta = const VerificationMeta('totalSet');
  @override
  late final GeneratedColumn<int> totalSet = GeneratedColumn<int>(
      'total_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _totalTimeMeta = const VerificationMeta('totalTime');
  @override
  late final GeneratedColumn<int> totalTime = GeneratedColumn<int>(
      'total_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        status,
        doingTime,
        weight,
        doingSet,
        doingNum,
        numPerSet,
        totalSet,
        totalTime,
        date
      ];
  @override
  String get aliasedName => _alias ?? 'exercise_records';
  @override
  String get actualTableName => 'exercise_records';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('doing_time')) {
      context.handle(_doingTimeMeta,
          doingTime.isAcceptableOrUnknown(data['doing_time']!, _doingTimeMeta));
    } else if (isInserting) {
      context.missing(_doingTimeMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('doing_set')) {
      context.handle(_doingSetMeta,
          doingSet.isAcceptableOrUnknown(data['doing_set']!, _doingSetMeta));
    } else if (isInserting) {
      context.missing(_doingSetMeta);
    }
    if (data.containsKey('doing_num')) {
      context.handle(_doingNumMeta,
          doingNum.isAcceptableOrUnknown(data['doing_num']!, _doingNumMeta));
    } else if (isInserting) {
      context.missing(_doingNumMeta);
    }
    if (data.containsKey('num_per_set')) {
      context.handle(
          _numPerSetMeta,
          numPerSet.isAcceptableOrUnknown(
              data['num_per_set']!, _numPerSetMeta));
    } else if (isInserting) {
      context.missing(_numPerSetMeta);
    }
    if (data.containsKey('total_set')) {
      context.handle(_totalSetMeta,
          totalSet.isAcceptableOrUnknown(data['total_set']!, _totalSetMeta));
    } else if (isInserting) {
      context.missing(_totalSetMeta);
    }
    if (data.containsKey('total_time')) {
      context.handle(_totalTimeMeta,
          totalTime.isAcceptableOrUnknown(data['total_time']!, _totalTimeMeta));
    } else if (isInserting) {
      context.missing(_totalTimeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ExerciseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRecord(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      status: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      doingTime: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}doing_time'])!,
      weight: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      doingSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}doing_set'])!,
      doingNum: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}doing_num'])!,
      numPerSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}num_per_set'])!,
      totalSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}total_set'])!,
      totalTime: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}total_time'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $ExerciseRecordsTable createAlias(String alias) {
    return $ExerciseRecordsTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $ExerciseRecordsTable exerciseRecords =
      $ExerciseRecordsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [exerciseRecords];
}
