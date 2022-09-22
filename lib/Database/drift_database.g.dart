// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserRoutine extends DataClass implements Insertable<UserRoutine> {
  final String id;
  final String routineName;
  final String day;
  const UserRoutine(
      {required this.id, required this.routineName, required this.day});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_name'] = Variable<String>(routineName);
    map['day'] = Variable<String>(day);
    return map;
  }

  UserRoutinesCompanion toCompanion(bool nullToAbsent) {
    return UserRoutinesCompanion(
      id: Value(id),
      routineName: Value(routineName),
      day: Value(day),
    );
  }

  factory UserRoutine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRoutine(
      id: serializer.fromJson<String>(json['id']),
      routineName: serializer.fromJson<String>(json['routineName']),
      day: serializer.fromJson<String>(json['day']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineName': serializer.toJson<String>(routineName),
      'day': serializer.toJson<String>(day),
    };
  }

  UserRoutine copyWith({String? id, String? routineName, String? day}) =>
      UserRoutine(
        id: id ?? this.id,
        routineName: routineName ?? this.routineName,
        day: day ?? this.day,
      );
  @override
  String toString() {
    return (StringBuffer('UserRoutine(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineName, day);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRoutine &&
          other.id == this.id &&
          other.routineName == this.routineName &&
          other.day == this.day);
}

class UserRoutinesCompanion extends UpdateCompanion<UserRoutine> {
  final Value<String> id;
  final Value<String> routineName;
  final Value<String> day;
  const UserRoutinesCompanion({
    this.id = const Value.absent(),
    this.routineName = const Value.absent(),
    this.day = const Value.absent(),
  });
  UserRoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String routineName,
    required String day,
  })  : routineName = Value(routineName),
        day = Value(day);
  static Insertable<UserRoutine> custom({
    Expression<String>? id,
    Expression<String>? routineName,
    Expression<String>? day,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineName != null) 'routine_name': routineName,
      if (day != null) 'day': day,
    });
  }

  UserRoutinesCompanion copyWith(
      {Value<String>? id, Value<String>? routineName, Value<String>? day}) {
    return UserRoutinesCompanion(
      id: id ?? this.id,
      routineName: routineName ?? this.routineName,
      day: day ?? this.day,
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
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }
}

class $UserRoutinesTable extends UserRoutines
    with TableInfo<$UserRoutinesTable, UserRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRoutinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  final VerificationMeta _routineNameMeta =
      const VerificationMeta('routineName');
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
      'routine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
      'day', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, routineName, day];
  @override
  String get aliasedName => _alias ?? 'user_routines';
  @override
  String get actualTableName => 'user_routines';
  @override
  VerificationContext validateIntegrity(Insertable<UserRoutine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_name')) {
      context.handle(
          _routineNameMeta,
          routineName.isAcceptableOrUnknown(
              data['routine_name']!, _routineNameMeta));
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  UserRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRoutine(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}routine_name'])!,
      day: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}day'])!,
    );
  }

  @override
  $UserRoutinesTable createAlias(String alias) {
    return $UserRoutinesTable(attachedDatabase, alias);
  }
}

class UserRoutineManual extends DataClass
    implements Insertable<UserRoutineManual> {
  final String id;
  final String routineId;
  final String exerciseId;
  final int order;
  final int weight;
  final int goalNum;
  final int goalSet;
  final int goalTime;
  final int nowSet;
  final int didTime;
  const UserRoutineManual(
      {required this.id,
      required this.routineId,
      required this.exerciseId,
      required this.order,
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
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order'] = Variable<int>(order);
    map['weight'] = Variable<int>(weight);
    map['goal_num'] = Variable<int>(goalNum);
    map['goal_set'] = Variable<int>(goalSet);
    map['goal_time'] = Variable<int>(goalTime);
    map['now_set'] = Variable<int>(nowSet);
    map['did_time'] = Variable<int>(didTime);
    return map;
  }

  UserRoutineManualsCompanion toCompanion(bool nullToAbsent) {
    return UserRoutineManualsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      order: Value(order),
      weight: Value(weight),
      goalNum: Value(goalNum),
      goalSet: Value(goalSet),
      goalTime: Value(goalTime),
      nowSet: Value(nowSet),
      didTime: Value(didTime),
    );
  }

  factory UserRoutineManual.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRoutineManual(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
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
      'exerciseId': serializer.toJson<String>(exerciseId),
      'order': serializer.toJson<int>(order),
      'weight': serializer.toJson<int>(weight),
      'goalNum': serializer.toJson<int>(goalNum),
      'goalSet': serializer.toJson<int>(goalSet),
      'goalTime': serializer.toJson<int>(goalTime),
      'nowSet': serializer.toJson<int>(nowSet),
      'didTime': serializer.toJson<int>(didTime),
    };
  }

  UserRoutineManual copyWith(
          {String? id,
          String? routineId,
          String? exerciseId,
          int? order,
          int? weight,
          int? goalNum,
          int? goalSet,
          int? goalTime,
          int? nowSet,
          int? didTime}) =>
      UserRoutineManual(
        id: id ?? this.id,
        routineId: routineId ?? this.routineId,
        exerciseId: exerciseId ?? this.exerciseId,
        order: order ?? this.order,
        weight: weight ?? this.weight,
        goalNum: goalNum ?? this.goalNum,
        goalSet: goalSet ?? this.goalSet,
        goalTime: goalTime ?? this.goalTime,
        nowSet: nowSet ?? this.nowSet,
        didTime: didTime ?? this.didTime,
      );
  @override
  String toString() {
    return (StringBuffer('UserRoutineManual(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
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
  int get hashCode => Object.hash(id, routineId, exerciseId, order, weight,
      goalNum, goalSet, goalTime, nowSet, didTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRoutineManual &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.order == this.order &&
          other.weight == this.weight &&
          other.goalNum == this.goalNum &&
          other.goalSet == this.goalSet &&
          other.goalTime == this.goalTime &&
          other.nowSet == this.nowSet &&
          other.didTime == this.didTime);
}

class UserRoutineManualsCompanion extends UpdateCompanion<UserRoutineManual> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> exerciseId;
  final Value<int> order;
  final Value<int> weight;
  final Value<int> goalNum;
  final Value<int> goalSet;
  final Value<int> goalTime;
  final Value<int> nowSet;
  final Value<int> didTime;
  const UserRoutineManualsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.weight = const Value.absent(),
    this.goalNum = const Value.absent(),
    this.goalSet = const Value.absent(),
    this.goalTime = const Value.absent(),
    this.nowSet = const Value.absent(),
    this.didTime = const Value.absent(),
  });
  UserRoutineManualsCompanion.insert({
    this.id = const Value.absent(),
    required String routineId,
    required String exerciseId,
    required int order,
    required int weight,
    required int goalNum,
    required int goalSet,
    required int goalTime,
    required int nowSet,
    required int didTime,
  })  : routineId = Value(routineId),
        exerciseId = Value(exerciseId),
        order = Value(order),
        weight = Value(weight),
        goalNum = Value(goalNum),
        goalSet = Value(goalSet),
        goalTime = Value(goalTime),
        nowSet = Value(nowSet),
        didTime = Value(didTime);
  static Insertable<UserRoutineManual> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? exerciseId,
    Expression<int>? order,
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
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (order != null) 'order': order,
      if (weight != null) 'weight': weight,
      if (goalNum != null) 'goal_num': goalNum,
      if (goalSet != null) 'goal_set': goalSet,
      if (goalTime != null) 'goal_time': goalTime,
      if (nowSet != null) 'now_set': nowSet,
      if (didTime != null) 'did_time': didTime,
    });
  }

  UserRoutineManualsCompanion copyWith(
      {Value<String>? id,
      Value<String>? routineId,
      Value<String>? exerciseId,
      Value<int>? order,
      Value<int>? weight,
      Value<int>? goalNum,
      Value<int>? goalSet,
      Value<int>? goalTime,
      Value<int>? nowSet,
      Value<int>? didTime}) {
    return UserRoutineManualsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
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
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
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
    return (StringBuffer('UserRoutineManualsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
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

class $UserRoutineManualsTable extends UserRoutineManuals
    with TableInfo<$UserRoutineManualsTable, UserRoutineManual> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRoutineManualsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  final VerificationMeta _routineIdMeta = const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
        exerciseId,
        order,
        weight,
        goalNum,
        goalSet,
        goalTime,
        nowSet,
        didTime
      ];
  @override
  String get aliasedName => _alias ?? 'user_routine_manuals';
  @override
  String get actualTableName => 'user_routine_manuals';
  @override
  VerificationContext validateIntegrity(Insertable<UserRoutineManual> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
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
  UserRoutineManual map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRoutineManual(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id'])!,
      exerciseId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      order: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
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
  $UserRoutineManualsTable createAlias(String alias) {
    return $UserRoutineManualsTable(attachedDatabase, alias);
  }
}

class UserExerciseRecord extends DataClass
    implements Insertable<UserExerciseRecord> {
  final String id;
  final String exerciseId;
  final int order;
  final int weight;
  final int setPerNum;
  final int didSet;
  final int didTime;
  const UserExerciseRecord(
      {required this.id,
      required this.exerciseId,
      required this.order,
      required this.weight,
      required this.setPerNum,
      required this.didSet,
      required this.didTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order'] = Variable<int>(order);
    map['weight'] = Variable<int>(weight);
    map['set_per_num'] = Variable<int>(setPerNum);
    map['did_set'] = Variable<int>(didSet);
    map['did_time'] = Variable<int>(didTime);
    return map;
  }

  UserExerciseRecordsCompanion toCompanion(bool nullToAbsent) {
    return UserExerciseRecordsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      order: Value(order),
      weight: Value(weight),
      setPerNum: Value(setPerNum),
      didSet: Value(didSet),
      didTime: Value(didTime),
    );
  }

  factory UserExerciseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserExerciseRecord(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
      weight: serializer.fromJson<int>(json['weight']),
      setPerNum: serializer.fromJson<int>(json['setPerNum']),
      didSet: serializer.fromJson<int>(json['didSet']),
      didTime: serializer.fromJson<int>(json['didTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'order': serializer.toJson<int>(order),
      'weight': serializer.toJson<int>(weight),
      'setPerNum': serializer.toJson<int>(setPerNum),
      'didSet': serializer.toJson<int>(didSet),
      'didTime': serializer.toJson<int>(didTime),
    };
  }

  UserExerciseRecord copyWith(
          {String? id,
          String? exerciseId,
          int? order,
          int? weight,
          int? setPerNum,
          int? didSet,
          int? didTime}) =>
      UserExerciseRecord(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        order: order ?? this.order,
        weight: weight ?? this.weight,
        setPerNum: setPerNum ?? this.setPerNum,
        didSet: didSet ?? this.didSet,
        didTime: didTime ?? this.didTime,
      );
  @override
  String toString() {
    return (StringBuffer('UserExerciseRecord(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('weight: $weight, ')
          ..write('setPerNum: $setPerNum, ')
          ..write('didSet: $didSet, ')
          ..write('didTime: $didTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, order, weight, setPerNum, didSet, didTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserExerciseRecord &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.order == this.order &&
          other.weight == this.weight &&
          other.setPerNum == this.setPerNum &&
          other.didSet == this.didSet &&
          other.didTime == this.didTime);
}

class UserExerciseRecordsCompanion extends UpdateCompanion<UserExerciseRecord> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<int> order;
  final Value<int> weight;
  final Value<int> setPerNum;
  final Value<int> didSet;
  final Value<int> didTime;
  const UserExerciseRecordsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.weight = const Value.absent(),
    this.setPerNum = const Value.absent(),
    this.didSet = const Value.absent(),
    this.didTime = const Value.absent(),
  });
  UserExerciseRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required int order,
    required int weight,
    required int setPerNum,
    required int didSet,
    required int didTime,
  })  : exerciseId = Value(exerciseId),
        order = Value(order),
        weight = Value(weight),
        setPerNum = Value(setPerNum),
        didSet = Value(didSet),
        didTime = Value(didTime);
  static Insertable<UserExerciseRecord> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<int>? order,
    Expression<int>? weight,
    Expression<int>? setPerNum,
    Expression<int>? didSet,
    Expression<int>? didTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (order != null) 'order': order,
      if (weight != null) 'weight': weight,
      if (setPerNum != null) 'set_per_num': setPerNum,
      if (didSet != null) 'did_set': didSet,
      if (didTime != null) 'did_time': didTime,
    });
  }

  UserExerciseRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? exerciseId,
      Value<int>? order,
      Value<int>? weight,
      Value<int>? setPerNum,
      Value<int>? didSet,
      Value<int>? didTime}) {
    return UserExerciseRecordsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      weight: weight ?? this.weight,
      setPerNum: setPerNum ?? this.setPerNum,
      didSet: didSet ?? this.didSet,
      didTime: didTime ?? this.didTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (setPerNum.present) {
      map['set_per_num'] = Variable<int>(setPerNum.value);
    }
    if (didSet.present) {
      map['did_set'] = Variable<int>(didSet.value);
    }
    if (didTime.present) {
      map['did_time'] = Variable<int>(didTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserExerciseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('weight: $weight, ')
          ..write('setPerNum: $setPerNum, ')
          ..write('didSet: $didSet, ')
          ..write('didTime: $didTime')
          ..write(')'))
        .toString();
  }
}

class $UserExerciseRecordsTable extends UserExerciseRecords
    with TableInfo<$UserExerciseRecordsTable, UserExerciseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserExerciseRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _setPerNumMeta = const VerificationMeta('setPerNum');
  @override
  late final GeneratedColumn<int> setPerNum = GeneratedColumn<int>(
      'set_per_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _didSetMeta = const VerificationMeta('didSet');
  @override
  late final GeneratedColumn<int> didSet = GeneratedColumn<int>(
      'did_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _didTimeMeta = const VerificationMeta('didTime');
  @override
  late final GeneratedColumn<int> didTime = GeneratedColumn<int>(
      'did_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, order, weight, setPerNum, didSet, didTime];
  @override
  String get aliasedName => _alias ?? 'user_exercise_records';
  @override
  String get actualTableName => 'user_exercise_records';
  @override
  VerificationContext validateIntegrity(Insertable<UserExerciseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('set_per_num')) {
      context.handle(
          _setPerNumMeta,
          setPerNum.isAcceptableOrUnknown(
              data['set_per_num']!, _setPerNumMeta));
    } else if (isInserting) {
      context.missing(_setPerNumMeta);
    }
    if (data.containsKey('did_set')) {
      context.handle(_didSetMeta,
          didSet.isAcceptableOrUnknown(data['did_set']!, _didSetMeta));
    } else if (isInserting) {
      context.missing(_didSetMeta);
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
  UserExerciseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserExerciseRecord(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      order: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      weight: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      setPerNum: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}set_per_num'])!,
      didSet: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}did_set'])!,
      didTime: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}did_time'])!,
    );
  }

  @override
  $UserExerciseRecordsTable createAlias(String alias) {
    return $UserExerciseRecordsTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $UserRoutinesTable userRoutines = $UserRoutinesTable(this);
  late final $UserRoutineManualsTable userRoutineManuals =
      $UserRoutineManualsTable(this);
  late final $UserExerciseRecordsTable userExerciseRecords =
      $UserExerciseRecordsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userRoutines, userRoutineManuals, userExerciseRecords];
}
