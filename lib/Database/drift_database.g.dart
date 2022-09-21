// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Routine extends DataClass implements Insertable<Routine> {
  final String id;
  final String routineName;
  const Routine({required this.id, required this.routineName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_name'] = Variable<String>(routineName);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      routineName: Value(routineName),
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<String>(json['id']),
      routineName: serializer.fromJson<String>(json['routineName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineName': serializer.toJson<String>(routineName),
    };
  }

  Routine copyWith({String? id, String? routineName}) => Routine(
        id: id ?? this.id,
        routineName: routineName ?? this.routineName,
      );
  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('routineName: $routineName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.routineName == this.routineName);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<String> id;
  final Value<String> routineName;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.routineName = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String routineName,
  })  : id = Value(id),
        routineName = Value(routineName);
  static Insertable<Routine> custom({
    Expression<String>? id,
    Expression<String>? routineName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineName != null) 'routine_name': routineName,
    });
  }

  RoutinesCompanion copyWith({Value<String>? id, Value<String>? routineName}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      routineName: routineName ?? this.routineName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('routineName: $routineName')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _routineNameMeta =
      const VerificationMeta('routineName');
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
      'routine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, routineName];
  @override
  String get aliasedName => _alias ?? 'routines';
  @override
  String get actualTableName => 'routines';
  @override
  VerificationContext validateIntegrity(Insertable<Routine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_name')) {
      context.handle(
          _routineNameMeta,
          routineName.isAcceptableOrUnknown(
              data['routine_name']!, _routineNameMeta));
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}routine_name'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class RoutineManual extends DataClass implements Insertable<RoutineManual> {
  final String id;
  final String routineId;
  final String name;
  final String type;
  final int order;
  final String status;
  final int weight;
  final int goalNum;
  final int goalSet;
  final int goalTime;
  final int nowSet;
  final int didTime;
  const RoutineManual(
      {required this.id,
      required this.routineId,
      required this.name,
      required this.type,
      required this.order,
      required this.status,
      required this.weight,
      required this.goalNum,
      required this.goalSet,
      required this.goalTime,
      required this.nowSet,
      required this.didTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['order'] = Variable<int>(order);
    map['status'] = Variable<String>(status);
    map['weight'] = Variable<int>(weight);
    map['goal_num'] = Variable<int>(goalNum);
    map['goal_set'] = Variable<int>(goalSet);
    map['goal_time'] = Variable<int>(goalTime);
    map['now_set'] = Variable<int>(nowSet);
    map['did_time'] = Variable<int>(didTime);
    return map;
  }

  RoutineManualsCompanion toCompanion(bool nullToAbsent) {
    return RoutineManualsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      name: Value(name),
      type: Value(type),
      order: Value(order),
      status: Value(status),
      weight: Value(weight),
      goalNum: Value(goalNum),
      goalSet: Value(goalSet),
      goalTime: Value(goalTime),
      nowSet: Value(nowSet),
      didTime: Value(didTime),
    );
  }

  factory RoutineManual.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineManual(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      order: serializer.fromJson<int>(json['order']),
      status: serializer.fromJson<String>(json['status']),
      weight: serializer.fromJson<int>(json['weight']),
      goalNum: serializer.fromJson<int>(json['goalNum']),
      goalSet: serializer.fromJson<int>(json['goalSet']),
      goalTime: serializer.fromJson<int>(json['goalTime']),
      nowSet: serializer.fromJson<int>(json['nowSet']),
      didTime: serializer.fromJson<int>(json['didTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'order': serializer.toJson<int>(order),
      'status': serializer.toJson<String>(status),
      'weight': serializer.toJson<int>(weight),
      'goalNum': serializer.toJson<int>(goalNum),
      'goalSet': serializer.toJson<int>(goalSet),
      'goalTime': serializer.toJson<int>(goalTime),
      'nowSet': serializer.toJson<int>(nowSet),
      'didTime': serializer.toJson<int>(didTime),
    };
  }

  RoutineManual copyWith(
          {String? id,
          String? routineId,
          String? name,
          String? type,
          int? order,
          String? status,
          int? weight,
          int? goalNum,
          int? goalSet,
          int? goalTime,
          int? nowSet,
          int? didTime}) =>
      RoutineManual(
        id: id ?? this.id,
        routineId: routineId ?? this.routineId,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        status: status ?? this.status,
        weight: weight ?? this.weight,
        goalNum: goalNum ?? this.goalNum,
        goalSet: goalSet ?? this.goalSet,
        goalTime: goalTime ?? this.goalTime,
        nowSet: nowSet ?? this.nowSet,
        didTime: didTime ?? this.didTime,
      );
  @override
  String toString() {
    return (StringBuffer('RoutineManual(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('status: $status, ')
          ..write('weight: $weight, ')
          ..write('goalNum: $goalNum, ')
          ..write('goalSet: $goalSet, ')
          ..write('goalTime: $goalTime, ')
          ..write('nowSet: $nowSet, ')
          ..write('didTime: $didTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, name, type, order, status,
      weight, goalNum, goalSet, goalTime, nowSet, didTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineManual &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.type == this.type &&
          other.order == this.order &&
          other.status == this.status &&
          other.weight == this.weight &&
          other.goalNum == this.goalNum &&
          other.goalSet == this.goalSet &&
          other.goalTime == this.goalTime &&
          other.nowSet == this.nowSet &&
          other.didTime == this.didTime);
}

class RoutineManualsCompanion extends UpdateCompanion<RoutineManual> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> name;
  final Value<String> type;
  final Value<int> order;
  final Value<String> status;
  final Value<int> weight;
  final Value<int> goalNum;
  final Value<int> goalSet;
  final Value<int> goalTime;
  final Value<int> nowSet;
  final Value<int> didTime;
  const RoutineManualsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.order = const Value.absent(),
    this.status = const Value.absent(),
    this.weight = const Value.absent(),
    this.goalNum = const Value.absent(),
    this.goalSet = const Value.absent(),
    this.goalTime = const Value.absent(),
    this.nowSet = const Value.absent(),
    this.didTime = const Value.absent(),
  });
  RoutineManualsCompanion.insert({
    required String id,
    required String routineId,
    required String name,
    required String type,
    required int order,
    required String status,
    required int weight,
    required int goalNum,
    required int goalSet,
    required int goalTime,
    required int nowSet,
    required int didTime,
  })  : id = Value(id),
        routineId = Value(routineId),
        name = Value(name),
        type = Value(type),
        order = Value(order),
        status = Value(status),
        weight = Value(weight),
        goalNum = Value(goalNum),
        goalSet = Value(goalSet),
        goalTime = Value(goalTime),
        nowSet = Value(nowSet),
        didTime = Value(didTime);
  static Insertable<RoutineManual> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? order,
    Expression<String>? status,
    Expression<int>? weight,
    Expression<int>? goalNum,
    Expression<int>? goalSet,
    Expression<int>? goalTime,
    Expression<int>? nowSet,
    Expression<int>? didTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (order != null) 'order': order,
      if (status != null) 'status': status,
      if (weight != null) 'weight': weight,
      if (goalNum != null) 'goal_num': goalNum,
      if (goalSet != null) 'goal_set': goalSet,
      if (goalTime != null) 'goal_time': goalTime,
      if (nowSet != null) 'now_set': nowSet,
      if (didTime != null) 'did_time': didTime,
    });
  }

  RoutineManualsCompanion copyWith(
      {Value<String>? id,
      Value<String>? routineId,
      Value<String>? name,
      Value<String>? type,
      Value<int>? order,
      Value<String>? status,
      Value<int>? weight,
      Value<int>? goalNum,
      Value<int>? goalSet,
      Value<int>? goalTime,
      Value<int>? nowSet,
      Value<int>? didTime}) {
    return RoutineManualsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      type: type ?? this.type,
      order: order ?? this.order,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      goalNum: goalNum ?? this.goalNum,
      goalSet: goalSet ?? this.goalSet,
      goalTime: goalTime ?? this.goalTime,
      nowSet: nowSet ?? this.nowSet,
      didTime: didTime ?? this.didTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (goalNum.present) {
      map['goal_num'] = Variable<int>(goalNum.value);
    }
    if (goalSet.present) {
      map['goal_set'] = Variable<int>(goalSet.value);
    }
    if (goalTime.present) {
      map['goal_time'] = Variable<int>(goalTime.value);
    }
    if (nowSet.present) {
      map['now_set'] = Variable<int>(nowSet.value);
    }
    if (didTime.present) {
      map['did_time'] = Variable<int>(didTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineManualsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('status: $status, ')
          ..write('weight: $weight, ')
          ..write('goalNum: $goalNum, ')
          ..write('goalSet: $goalSet, ')
          ..write('goalTime: $goalTime, ')
          ..write('nowSet: $nowSet, ')
          ..write('didTime: $didTime')
          ..write(')'))
        .toString();
  }
}

class $RoutineManualsTable extends RoutineManuals
    with TableInfo<$RoutineManualsTable, RoutineManual> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineManualsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _routineIdMeta = const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, false,
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
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _goalNumMeta = const VerificationMeta('goalNum');
  @override
  late final GeneratedColumn<int> goalNum = GeneratedColumn<int>(
      'goal_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _goalSetMeta = const VerificationMeta('goalSet');
  @override
  late final GeneratedColumn<int> goalSet = GeneratedColumn<int>(
      'goal_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _goalTimeMeta = const VerificationMeta('goalTime');
  @override
  late final GeneratedColumn<int> goalTime = GeneratedColumn<int>(
      'goal_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _nowSetMeta = const VerificationMeta('nowSet');
  @override
  late final GeneratedColumn<int> nowSet = GeneratedColumn<int>(
      'now_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _didTimeMeta = const VerificationMeta('didTime');
  @override
  late final GeneratedColumn<int> didTime = GeneratedColumn<int>(
      'did_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        routineId,
        name,
        type,
        order,
        status,
        weight,
        goalNum,
        goalSet,
        goalTime,
        nowSet,
        didTime
      ];
  @override
  String get aliasedName => _alias ?? 'routine_manuals';
  @override
  String get actualTableName => 'routine_manuals';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineManual> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
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
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('goal_num')) {
      context.handle(_goalNumMeta,
          goalNum.isAcceptableOrUnknown(data['goal_num']!, _goalNumMeta));
    } else if (isInserting) {
      context.missing(_goalNumMeta);
    }
    if (data.containsKey('goal_set')) {
      context.handle(_goalSetMeta,
          goalSet.isAcceptableOrUnknown(data['goal_set']!, _goalSetMeta));
    } else if (isInserting) {
      context.missing(_goalSetMeta);
    }
    if (data.containsKey('goal_time')) {
      context.handle(_goalTimeMeta,
          goalTime.isAcceptableOrUnknown(data['goal_time']!, _goalTimeMeta));
    } else if (isInserting) {
      context.missing(_goalTimeMeta);
    }
    if (data.containsKey('now_set')) {
      context.handle(_nowSetMeta,
          nowSet.isAcceptableOrUnknown(data['now_set']!, _nowSetMeta));
    } else if (isInserting) {
      context.missing(_nowSetMeta);
    }
    if (data.containsKey('did_time')) {
      context.handle(_didTimeMeta,
          didTime.isAcceptableOrUnknown(data['did_time']!, _didTimeMeta));
    } else if (isInserting) {
      context.missing(_didTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  RoutineManual map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineManual(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      order: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      status: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      weight: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      goalNum: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}goal_num'])!,
      goalSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}goal_set'])!,
      goalTime: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}goal_time'])!,
      nowSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}now_set'])!,
      didTime: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}did_time'])!,
    );
  }

  @override
  $RoutineManualsTable createAlias(String alias) {
    return $RoutineManualsTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $RoutineManualsTable routineManuals = $RoutineManualsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [routines, routineManuals];
}
