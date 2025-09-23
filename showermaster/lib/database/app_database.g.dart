// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $JobsTable extends Jobs with TableInfo<$JobsTable, Job> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>(
        'estimated_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    startDate,
    estimatedDurationMinutes,
    contactId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Job> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
        _estimatedDurationMinutesMeta,
        estimatedDurationMinutes.isAcceptableOrUnknown(
          data['estimated_duration_minutes']!,
          _estimatedDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedDurationMinutesMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Job map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Job(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration_minutes'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      )!,
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }
}

class Job extends DataClass implements Insertable<Job> {
  final String id;
  final String name;
  final DateTime startDate;
  final int estimatedDurationMinutes;
  final String contactId;
  const Job({
    required this.id,
    required this.name,
    required this.startDate,
    required this.estimatedDurationMinutes,
    required this.contactId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<DateTime>(startDate);
    map['estimated_duration_minutes'] = Variable<int>(estimatedDurationMinutes);
    map['contact_id'] = Variable<String>(contactId);
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      contactId: Value(contactId),
    );
  }

  factory Job.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Job(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      estimatedDurationMinutes: serializer.fromJson<int>(
        json['estimatedDurationMinutes'],
      ),
      contactId: serializer.fromJson<String>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime>(startDate),
      'estimatedDurationMinutes': serializer.toJson<int>(
        estimatedDurationMinutes,
      ),
      'contactId': serializer.toJson<String>(contactId),
    };
  }

  Job copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    int? estimatedDurationMinutes,
    String? contactId,
  }) => Job(
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    estimatedDurationMinutes:
        estimatedDurationMinutes ?? this.estimatedDurationMinutes,
    contactId: contactId ?? this.contactId,
  );
  Job copyWithCompanion(JobsCompanion data) {
    return Job(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Job(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, startDate, estimatedDurationMinutes, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.contactId == this.contactId);
}

class JobsCompanion extends UpdateCompanion<Job> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> startDate;
  final Value<int> estimatedDurationMinutes;
  final Value<String> contactId;
  final Value<int> rowid;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.contactId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JobsCompanion.insert({
    required String id,
    required String name,
    required DateTime startDate,
    required int estimatedDurationMinutes,
    required String contactId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       startDate = Value(startDate),
       estimatedDurationMinutes = Value(estimatedDurationMinutes),
       contactId = Value(contactId);
  static Insertable<Job> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<int>? estimatedDurationMinutes,
    Expression<String>? contactId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (contactId != null) 'contact_id': contactId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JobsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? startDate,
    Value<int>? estimatedDurationMinutes,
    Value<String>? contactId,
    Value<int>? rowid,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      contactId: contactId ?? this.contactId,
      rowid: rowid ?? this.rowid,
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
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes.value,
      );
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('contactId: $contactId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VisitsTable extends Visits with TableInfo<$VisitsTable, Visit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VisitStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<VisitStatus>($VisitsTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    scheduledAt,
    durationMinutes,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Visit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Visit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Visit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      status: $VisitsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $VisitsTable createAlias(String alias) {
    return $VisitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VisitStatus, int, int> $converterstatus =
      const EnumIndexConverter<VisitStatus>(VisitStatus.values);
}

class Visit extends DataClass implements Insertable<Visit> {
  final String id;
  final String jobId;
  final DateTime scheduledAt;
  final int durationMinutes;
  final VisitStatus status;
  const Visit({
    required this.id,
    required this.jobId,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['job_id'] = Variable<String>(jobId);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    {
      map['status'] = Variable<int>(
        $VisitsTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  VisitsCompanion toCompanion(bool nullToAbsent) {
    return VisitsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      scheduledAt: Value(scheduledAt),
      durationMinutes: Value(durationMinutes),
      status: Value(status),
    );
  }

  factory Visit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Visit(
      id: serializer.fromJson<String>(json['id']),
      jobId: serializer.fromJson<String>(json['jobId']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      status: $VisitsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jobId': serializer.toJson<String>(jobId),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'status': serializer.toJson<int>(
        $VisitsTable.$converterstatus.toJson(status),
      ),
    };
  }

  Visit copyWith({
    String? id,
    String? jobId,
    DateTime? scheduledAt,
    int? durationMinutes,
    VisitStatus? status,
  }) => Visit(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    status: status ?? this.status,
  );
  Visit copyWithCompanion(VisitsCompanion data) {
    return Visit(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Visit(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, jobId, scheduledAt, durationMinutes, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Visit &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.scheduledAt == this.scheduledAt &&
          other.durationMinutes == this.durationMinutes &&
          other.status == this.status);
}

class VisitsCompanion extends UpdateCompanion<Visit> {
  final Value<String> id;
  final Value<String> jobId;
  final Value<DateTime> scheduledAt;
  final Value<int> durationMinutes;
  final Value<VisitStatus> status;
  final Value<int> rowid;
  const VisitsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VisitsCompanion.insert({
    required String id,
    required String jobId,
    required DateTime scheduledAt,
    required int durationMinutes,
    required VisitStatus status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       jobId = Value(jobId),
       scheduledAt = Value(scheduledAt),
       durationMinutes = Value(durationMinutes),
       status = Value(status);
  static Insertable<Visit> custom({
    Expression<String>? id,
    Expression<String>? jobId,
    Expression<DateTime>? scheduledAt,
    Expression<int>? durationMinutes,
    Expression<int>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VisitsCompanion copyWith({
    Value<String>? id,
    Value<String>? jobId,
    Value<DateTime>? scheduledAt,
    Value<int>? durationMinutes,
    Value<VisitStatus>? status,
    Value<int>? rowid,
  }) {
    return VisitsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $VisitsTable.$converterstatus.toSql(status.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShowersTable extends Showers with TableInfo<$ShowersTable, Shower> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShowersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _visitIdMeta = const VerificationMeta(
    'visitId',
  );
  @override
  late final GeneratedColumn<String> visitId = GeneratedColumn<String>(
    'visit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES visits (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ShowerStyle, int> style =
      GeneratedColumn<int>(
        'style',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ShowerStyle>($ShowersTable.$converterstyle);
  @override
  late final GeneratedColumnWithTypeConverter<DoorType, int> doorType =
      GeneratedColumn<int>(
        'door_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DoorType>($ShowersTable.$converterdoorType);
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _panelCountMeta = const VerificationMeta(
    'panelCount',
  );
  @override
  late final GeneratedColumn<int> panelCount = GeneratedColumn<int>(
    'panel_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    visitId,
    name,
    style,
    doorType,
    templateId,
    panelCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'showers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shower> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('visit_id')) {
      context.handle(
        _visitIdMeta,
        visitId.isAcceptableOrUnknown(data['visit_id']!, _visitIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('panel_count')) {
      context.handle(
        _panelCountMeta,
        panelCount.isAcceptableOrUnknown(data['panel_count']!, _panelCountMeta),
      );
    } else if (isInserting) {
      context.missing(_panelCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shower map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shower(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      visitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visit_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      style: $ShowersTable.$converterstyle.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}style'],
        )!,
      ),
      doorType: $ShowersTable.$converterdoorType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}door_type'],
        )!,
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      panelCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}panel_count'],
      )!,
    );
  }

  @override
  $ShowersTable createAlias(String alias) {
    return $ShowersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ShowerStyle, int, int> $converterstyle =
      const EnumIndexConverter<ShowerStyle>(ShowerStyle.values);
  static JsonTypeConverter2<DoorType, int, int> $converterdoorType =
      const EnumIndexConverter<DoorType>(DoorType.values);
}

class Shower extends DataClass implements Insertable<Shower> {
  final String id;
  final String jobId;
  final String? visitId;
  final String name;
  final ShowerStyle style;
  final DoorType doorType;
  final String templateId;
  final int panelCount;
  const Shower({
    required this.id,
    required this.jobId,
    this.visitId,
    required this.name,
    required this.style,
    required this.doorType,
    required this.templateId,
    required this.panelCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['job_id'] = Variable<String>(jobId);
    if (!nullToAbsent || visitId != null) {
      map['visit_id'] = Variable<String>(visitId);
    }
    map['name'] = Variable<String>(name);
    {
      map['style'] = Variable<int>($ShowersTable.$converterstyle.toSql(style));
    }
    {
      map['door_type'] = Variable<int>(
        $ShowersTable.$converterdoorType.toSql(doorType),
      );
    }
    map['template_id'] = Variable<String>(templateId);
    map['panel_count'] = Variable<int>(panelCount);
    return map;
  }

  ShowersCompanion toCompanion(bool nullToAbsent) {
    return ShowersCompanion(
      id: Value(id),
      jobId: Value(jobId),
      visitId: visitId == null && nullToAbsent
          ? const Value.absent()
          : Value(visitId),
      name: Value(name),
      style: Value(style),
      doorType: Value(doorType),
      templateId: Value(templateId),
      panelCount: Value(panelCount),
    );
  }

  factory Shower.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shower(
      id: serializer.fromJson<String>(json['id']),
      jobId: serializer.fromJson<String>(json['jobId']),
      visitId: serializer.fromJson<String?>(json['visitId']),
      name: serializer.fromJson<String>(json['name']),
      style: $ShowersTable.$converterstyle.fromJson(
        serializer.fromJson<int>(json['style']),
      ),
      doorType: $ShowersTable.$converterdoorType.fromJson(
        serializer.fromJson<int>(json['doorType']),
      ),
      templateId: serializer.fromJson<String>(json['templateId']),
      panelCount: serializer.fromJson<int>(json['panelCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jobId': serializer.toJson<String>(jobId),
      'visitId': serializer.toJson<String?>(visitId),
      'name': serializer.toJson<String>(name),
      'style': serializer.toJson<int>(
        $ShowersTable.$converterstyle.toJson(style),
      ),
      'doorType': serializer.toJson<int>(
        $ShowersTable.$converterdoorType.toJson(doorType),
      ),
      'templateId': serializer.toJson<String>(templateId),
      'panelCount': serializer.toJson<int>(panelCount),
    };
  }

  Shower copyWith({
    String? id,
    String? jobId,
    Value<String?> visitId = const Value.absent(),
    String? name,
    ShowerStyle? style,
    DoorType? doorType,
    String? templateId,
    int? panelCount,
  }) => Shower(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    visitId: visitId.present ? visitId.value : this.visitId,
    name: name ?? this.name,
    style: style ?? this.style,
    doorType: doorType ?? this.doorType,
    templateId: templateId ?? this.templateId,
    panelCount: panelCount ?? this.panelCount,
  );
  Shower copyWithCompanion(ShowersCompanion data) {
    return Shower(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      visitId: data.visitId.present ? data.visitId.value : this.visitId,
      name: data.name.present ? data.name.value : this.name,
      style: data.style.present ? data.style.value : this.style,
      doorType: data.doorType.present ? data.doorType.value : this.doorType,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      panelCount: data.panelCount.present
          ? data.panelCount.value
          : this.panelCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shower(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('visitId: $visitId, ')
          ..write('name: $name, ')
          ..write('style: $style, ')
          ..write('doorType: $doorType, ')
          ..write('templateId: $templateId, ')
          ..write('panelCount: $panelCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    visitId,
    name,
    style,
    doorType,
    templateId,
    panelCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shower &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.visitId == this.visitId &&
          other.name == this.name &&
          other.style == this.style &&
          other.doorType == this.doorType &&
          other.templateId == this.templateId &&
          other.panelCount == this.panelCount);
}

class ShowersCompanion extends UpdateCompanion<Shower> {
  final Value<String> id;
  final Value<String> jobId;
  final Value<String?> visitId;
  final Value<String> name;
  final Value<ShowerStyle> style;
  final Value<DoorType> doorType;
  final Value<String> templateId;
  final Value<int> panelCount;
  final Value<int> rowid;
  const ShowersCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.visitId = const Value.absent(),
    this.name = const Value.absent(),
    this.style = const Value.absent(),
    this.doorType = const Value.absent(),
    this.templateId = const Value.absent(),
    this.panelCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShowersCompanion.insert({
    required String id,
    required String jobId,
    this.visitId = const Value.absent(),
    required String name,
    required ShowerStyle style,
    required DoorType doorType,
    required String templateId,
    required int panelCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       jobId = Value(jobId),
       name = Value(name),
       style = Value(style),
       doorType = Value(doorType),
       templateId = Value(templateId),
       panelCount = Value(panelCount);
  static Insertable<Shower> custom({
    Expression<String>? id,
    Expression<String>? jobId,
    Expression<String>? visitId,
    Expression<String>? name,
    Expression<int>? style,
    Expression<int>? doorType,
    Expression<String>? templateId,
    Expression<int>? panelCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (visitId != null) 'visit_id': visitId,
      if (name != null) 'name': name,
      if (style != null) 'style': style,
      if (doorType != null) 'door_type': doorType,
      if (templateId != null) 'template_id': templateId,
      if (panelCount != null) 'panel_count': panelCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShowersCompanion copyWith({
    Value<String>? id,
    Value<String>? jobId,
    Value<String?>? visitId,
    Value<String>? name,
    Value<ShowerStyle>? style,
    Value<DoorType>? doorType,
    Value<String>? templateId,
    Value<int>? panelCount,
    Value<int>? rowid,
  }) {
    return ShowersCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      visitId: visitId ?? this.visitId,
      name: name ?? this.name,
      style: style ?? this.style,
      doorType: doorType ?? this.doorType,
      templateId: templateId ?? this.templateId,
      panelCount: panelCount ?? this.panelCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (visitId.present) {
      map['visit_id'] = Variable<String>(visitId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (style.present) {
      map['style'] = Variable<int>(
        $ShowersTable.$converterstyle.toSql(style.value),
      );
    }
    if (doorType.present) {
      map['door_type'] = Variable<int>(
        $ShowersTable.$converterdoorType.toSql(doorType.value),
      );
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (panelCount.present) {
      map['panel_count'] = Variable<int>(panelCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShowersCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('visitId: $visitId, ')
          ..write('name: $name, ')
          ..write('style: $style, ')
          ..write('doorType: $doorType, ')
          ..write('templateId: $templateId, ')
          ..write('panelCount: $panelCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PanelsTable extends Panels with TableInfo<$PanelsTable, Panel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PanelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _showerIdMeta = const VerificationMeta(
    'showerId',
  );
  @override
  late final GeneratedColumn<String> showerId = GeneratedColumn<String>(
    'shower_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES showers (id)',
    ),
  );
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
    'index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoorMeta = const VerificationMeta('isDoor');
  @override
  late final GeneratedColumn<bool> isDoor = GeneratedColumn<bool>(
    'is_door',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_door" IN (0, 1))',
    ),
  );
  static const VerificationMeta _widthMmMeta = const VerificationMeta(
    'widthMm',
  );
  @override
  late final GeneratedColumn<double> widthMm = GeneratedColumn<double>(
    'width_mm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMmMeta = const VerificationMeta(
    'heightMm',
  );
  @override
  late final GeneratedColumn<double> heightMm = GeneratedColumn<double>(
    'height_mm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HandleSide?, int> handleSide =
      GeneratedColumn<int>(
        'handle_side',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<HandleSide?>($PanelsTable.$converterhandleSiden);
  static const VerificationMeta _hasBenchNotchMeta = const VerificationMeta(
    'hasBenchNotch',
  );
  @override
  late final GeneratedColumn<bool> hasBenchNotch = GeneratedColumn<bool>(
    'has_bench_notch',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_bench_notch" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isNotchReversedMeta = const VerificationMeta(
    'isNotchReversed',
  );
  @override
  late final GeneratedColumn<bool> isNotchReversed = GeneratedColumn<bool>(
    'is_notch_reversed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_notch_reversed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notchVerticalOffsetMmMeta =
      const VerificationMeta('notchVerticalOffsetMm');
  @override
  late final GeneratedColumn<double> notchVerticalOffsetMm =
      GeneratedColumn<double>(
        'notch_vertical_offset_mm',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notchVerticalHeightMmMeta =
      const VerificationMeta('notchVerticalHeightMm');
  @override
  late final GeneratedColumn<double> notchVerticalHeightMm =
      GeneratedColumn<double>(
        'notch_vertical_height_mm',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notchHorizontalOffsetMmMeta =
      const VerificationMeta('notchHorizontalOffsetMm');
  @override
  late final GeneratedColumn<double> notchHorizontalOffsetMm =
      GeneratedColumn<double>(
        'notch_horizontal_offset_mm',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notchHorizontalDepthMmMeta =
      const VerificationMeta('notchHorizontalDepthMm');
  @override
  late final GeneratedColumn<double> notchHorizontalDepthMm =
      GeneratedColumn<double>(
        'notch_horizontal_depth_mm',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    showerId,
    index,
    isDoor,
    widthMm,
    heightMm,
    handleSide,
    hasBenchNotch,
    isNotchReversed,
    notchVerticalOffsetMm,
    notchVerticalHeightMm,
    notchHorizontalOffsetMm,
    notchHorizontalDepthMm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'panels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Panel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shower_id')) {
      context.handle(
        _showerIdMeta,
        showerId.isAcceptableOrUnknown(data['shower_id']!, _showerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_showerIdMeta);
    }
    if (data.containsKey('index')) {
      context.handle(
        _indexMeta,
        index.isAcceptableOrUnknown(data['index']!, _indexMeta),
      );
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('is_door')) {
      context.handle(
        _isDoorMeta,
        isDoor.isAcceptableOrUnknown(data['is_door']!, _isDoorMeta),
      );
    } else if (isInserting) {
      context.missing(_isDoorMeta);
    }
    if (data.containsKey('width_mm')) {
      context.handle(
        _widthMmMeta,
        widthMm.isAcceptableOrUnknown(data['width_mm']!, _widthMmMeta),
      );
    }
    if (data.containsKey('height_mm')) {
      context.handle(
        _heightMmMeta,
        heightMm.isAcceptableOrUnknown(data['height_mm']!, _heightMmMeta),
      );
    }
    if (data.containsKey('has_bench_notch')) {
      context.handle(
        _hasBenchNotchMeta,
        hasBenchNotch.isAcceptableOrUnknown(
          data['has_bench_notch']!,
          _hasBenchNotchMeta,
        ),
      );
    }
    if (data.containsKey('is_notch_reversed')) {
      context.handle(
        _isNotchReversedMeta,
        isNotchReversed.isAcceptableOrUnknown(
          data['is_notch_reversed']!,
          _isNotchReversedMeta,
        ),
      );
    }
    if (data.containsKey('notch_vertical_offset_mm')) {
      context.handle(
        _notchVerticalOffsetMmMeta,
        notchVerticalOffsetMm.isAcceptableOrUnknown(
          data['notch_vertical_offset_mm']!,
          _notchVerticalOffsetMmMeta,
        ),
      );
    }
    if (data.containsKey('notch_vertical_height_mm')) {
      context.handle(
        _notchVerticalHeightMmMeta,
        notchVerticalHeightMm.isAcceptableOrUnknown(
          data['notch_vertical_height_mm']!,
          _notchVerticalHeightMmMeta,
        ),
      );
    }
    if (data.containsKey('notch_horizontal_offset_mm')) {
      context.handle(
        _notchHorizontalOffsetMmMeta,
        notchHorizontalOffsetMm.isAcceptableOrUnknown(
          data['notch_horizontal_offset_mm']!,
          _notchHorizontalOffsetMmMeta,
        ),
      );
    }
    if (data.containsKey('notch_horizontal_depth_mm')) {
      context.handle(
        _notchHorizontalDepthMmMeta,
        notchHorizontalDepthMm.isAcceptableOrUnknown(
          data['notch_horizontal_depth_mm']!,
          _notchHorizontalDepthMmMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {showerId, index};
  @override
  Panel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Panel(
      showerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shower_id'],
      )!,
      index: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}index'],
      )!,
      isDoor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_door'],
      )!,
      widthMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_mm'],
      ),
      heightMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_mm'],
      ),
      handleSide: $PanelsTable.$converterhandleSiden.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}handle_side'],
        ),
      ),
      hasBenchNotch: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_bench_notch'],
      )!,
      isNotchReversed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_notch_reversed'],
      )!,
      notchVerticalOffsetMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}notch_vertical_offset_mm'],
      ),
      notchVerticalHeightMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}notch_vertical_height_mm'],
      ),
      notchHorizontalOffsetMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}notch_horizontal_offset_mm'],
      ),
      notchHorizontalDepthMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}notch_horizontal_depth_mm'],
      ),
    );
  }

  @override
  $PanelsTable createAlias(String alias) {
    return $PanelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HandleSide, int, int> $converterhandleSide =
      const EnumIndexConverter<HandleSide>(HandleSide.values);
  static JsonTypeConverter2<HandleSide?, int?, int?> $converterhandleSiden =
      JsonTypeConverter2.asNullable($converterhandleSide);
}

class Panel extends DataClass implements Insertable<Panel> {
  final String showerId;
  final int index;
  final bool isDoor;
  final double? widthMm;
  final double? heightMm;
  final HandleSide? handleSide;
  final bool hasBenchNotch;
  final bool isNotchReversed;
  final double? notchVerticalOffsetMm;
  final double? notchVerticalHeightMm;
  final double? notchHorizontalOffsetMm;
  final double? notchHorizontalDepthMm;
  const Panel({
    required this.showerId,
    required this.index,
    required this.isDoor,
    this.widthMm,
    this.heightMm,
    this.handleSide,
    required this.hasBenchNotch,
    required this.isNotchReversed,
    this.notchVerticalOffsetMm,
    this.notchVerticalHeightMm,
    this.notchHorizontalOffsetMm,
    this.notchHorizontalDepthMm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shower_id'] = Variable<String>(showerId);
    map['index'] = Variable<int>(index);
    map['is_door'] = Variable<bool>(isDoor);
    if (!nullToAbsent || widthMm != null) {
      map['width_mm'] = Variable<double>(widthMm);
    }
    if (!nullToAbsent || heightMm != null) {
      map['height_mm'] = Variable<double>(heightMm);
    }
    if (!nullToAbsent || handleSide != null) {
      map['handle_side'] = Variable<int>(
        $PanelsTable.$converterhandleSiden.toSql(handleSide),
      );
    }
    map['has_bench_notch'] = Variable<bool>(hasBenchNotch);
    map['is_notch_reversed'] = Variable<bool>(isNotchReversed);
    if (!nullToAbsent || notchVerticalOffsetMm != null) {
      map['notch_vertical_offset_mm'] = Variable<double>(notchVerticalOffsetMm);
    }
    if (!nullToAbsent || notchVerticalHeightMm != null) {
      map['notch_vertical_height_mm'] = Variable<double>(notchVerticalHeightMm);
    }
    if (!nullToAbsent || notchHorizontalOffsetMm != null) {
      map['notch_horizontal_offset_mm'] = Variable<double>(
        notchHorizontalOffsetMm,
      );
    }
    if (!nullToAbsent || notchHorizontalDepthMm != null) {
      map['notch_horizontal_depth_mm'] = Variable<double>(
        notchHorizontalDepthMm,
      );
    }
    return map;
  }

  PanelsCompanion toCompanion(bool nullToAbsent) {
    return PanelsCompanion(
      showerId: Value(showerId),
      index: Value(index),
      isDoor: Value(isDoor),
      widthMm: widthMm == null && nullToAbsent
          ? const Value.absent()
          : Value(widthMm),
      heightMm: heightMm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightMm),
      handleSide: handleSide == null && nullToAbsent
          ? const Value.absent()
          : Value(handleSide),
      hasBenchNotch: Value(hasBenchNotch),
      isNotchReversed: Value(isNotchReversed),
      notchVerticalOffsetMm: notchVerticalOffsetMm == null && nullToAbsent
          ? const Value.absent()
          : Value(notchVerticalOffsetMm),
      notchVerticalHeightMm: notchVerticalHeightMm == null && nullToAbsent
          ? const Value.absent()
          : Value(notchVerticalHeightMm),
      notchHorizontalOffsetMm: notchHorizontalOffsetMm == null && nullToAbsent
          ? const Value.absent()
          : Value(notchHorizontalOffsetMm),
      notchHorizontalDepthMm: notchHorizontalDepthMm == null && nullToAbsent
          ? const Value.absent()
          : Value(notchHorizontalDepthMm),
    );
  }

  factory Panel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Panel(
      showerId: serializer.fromJson<String>(json['showerId']),
      index: serializer.fromJson<int>(json['index']),
      isDoor: serializer.fromJson<bool>(json['isDoor']),
      widthMm: serializer.fromJson<double?>(json['widthMm']),
      heightMm: serializer.fromJson<double?>(json['heightMm']),
      handleSide: $PanelsTable.$converterhandleSiden.fromJson(
        serializer.fromJson<int?>(json['handleSide']),
      ),
      hasBenchNotch: serializer.fromJson<bool>(json['hasBenchNotch']),
      isNotchReversed: serializer.fromJson<bool>(json['isNotchReversed']),
      notchVerticalOffsetMm: serializer.fromJson<double?>(
        json['notchVerticalOffsetMm'],
      ),
      notchVerticalHeightMm: serializer.fromJson<double?>(
        json['notchVerticalHeightMm'],
      ),
      notchHorizontalOffsetMm: serializer.fromJson<double?>(
        json['notchHorizontalOffsetMm'],
      ),
      notchHorizontalDepthMm: serializer.fromJson<double?>(
        json['notchHorizontalDepthMm'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'showerId': serializer.toJson<String>(showerId),
      'index': serializer.toJson<int>(index),
      'isDoor': serializer.toJson<bool>(isDoor),
      'widthMm': serializer.toJson<double?>(widthMm),
      'heightMm': serializer.toJson<double?>(heightMm),
      'handleSide': serializer.toJson<int?>(
        $PanelsTable.$converterhandleSiden.toJson(handleSide),
      ),
      'hasBenchNotch': serializer.toJson<bool>(hasBenchNotch),
      'isNotchReversed': serializer.toJson<bool>(isNotchReversed),
      'notchVerticalOffsetMm': serializer.toJson<double?>(
        notchVerticalOffsetMm,
      ),
      'notchVerticalHeightMm': serializer.toJson<double?>(
        notchVerticalHeightMm,
      ),
      'notchHorizontalOffsetMm': serializer.toJson<double?>(
        notchHorizontalOffsetMm,
      ),
      'notchHorizontalDepthMm': serializer.toJson<double?>(
        notchHorizontalDepthMm,
      ),
    };
  }

  Panel copyWith({
    String? showerId,
    int? index,
    bool? isDoor,
    Value<double?> widthMm = const Value.absent(),
    Value<double?> heightMm = const Value.absent(),
    Value<HandleSide?> handleSide = const Value.absent(),
    bool? hasBenchNotch,
    bool? isNotchReversed,
    Value<double?> notchVerticalOffsetMm = const Value.absent(),
    Value<double?> notchVerticalHeightMm = const Value.absent(),
    Value<double?> notchHorizontalOffsetMm = const Value.absent(),
    Value<double?> notchHorizontalDepthMm = const Value.absent(),
  }) => Panel(
    showerId: showerId ?? this.showerId,
    index: index ?? this.index,
    isDoor: isDoor ?? this.isDoor,
    widthMm: widthMm.present ? widthMm.value : this.widthMm,
    heightMm: heightMm.present ? heightMm.value : this.heightMm,
    handleSide: handleSide.present ? handleSide.value : this.handleSide,
    hasBenchNotch: hasBenchNotch ?? this.hasBenchNotch,
    isNotchReversed: isNotchReversed ?? this.isNotchReversed,
    notchVerticalOffsetMm: notchVerticalOffsetMm.present
        ? notchVerticalOffsetMm.value
        : this.notchVerticalOffsetMm,
    notchVerticalHeightMm: notchVerticalHeightMm.present
        ? notchVerticalHeightMm.value
        : this.notchVerticalHeightMm,
    notchHorizontalOffsetMm: notchHorizontalOffsetMm.present
        ? notchHorizontalOffsetMm.value
        : this.notchHorizontalOffsetMm,
    notchHorizontalDepthMm: notchHorizontalDepthMm.present
        ? notchHorizontalDepthMm.value
        : this.notchHorizontalDepthMm,
  );
  Panel copyWithCompanion(PanelsCompanion data) {
    return Panel(
      showerId: data.showerId.present ? data.showerId.value : this.showerId,
      index: data.index.present ? data.index.value : this.index,
      isDoor: data.isDoor.present ? data.isDoor.value : this.isDoor,
      widthMm: data.widthMm.present ? data.widthMm.value : this.widthMm,
      heightMm: data.heightMm.present ? data.heightMm.value : this.heightMm,
      handleSide: data.handleSide.present
          ? data.handleSide.value
          : this.handleSide,
      hasBenchNotch: data.hasBenchNotch.present
          ? data.hasBenchNotch.value
          : this.hasBenchNotch,
      isNotchReversed: data.isNotchReversed.present
          ? data.isNotchReversed.value
          : this.isNotchReversed,
      notchVerticalOffsetMm: data.notchVerticalOffsetMm.present
          ? data.notchVerticalOffsetMm.value
          : this.notchVerticalOffsetMm,
      notchVerticalHeightMm: data.notchVerticalHeightMm.present
          ? data.notchVerticalHeightMm.value
          : this.notchVerticalHeightMm,
      notchHorizontalOffsetMm: data.notchHorizontalOffsetMm.present
          ? data.notchHorizontalOffsetMm.value
          : this.notchHorizontalOffsetMm,
      notchHorizontalDepthMm: data.notchHorizontalDepthMm.present
          ? data.notchHorizontalDepthMm.value
          : this.notchHorizontalDepthMm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Panel(')
          ..write('showerId: $showerId, ')
          ..write('index: $index, ')
          ..write('isDoor: $isDoor, ')
          ..write('widthMm: $widthMm, ')
          ..write('heightMm: $heightMm, ')
          ..write('handleSide: $handleSide, ')
          ..write('hasBenchNotch: $hasBenchNotch, ')
          ..write('isNotchReversed: $isNotchReversed, ')
          ..write('notchVerticalOffsetMm: $notchVerticalOffsetMm, ')
          ..write('notchVerticalHeightMm: $notchVerticalHeightMm, ')
          ..write('notchHorizontalOffsetMm: $notchHorizontalOffsetMm, ')
          ..write('notchHorizontalDepthMm: $notchHorizontalDepthMm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    showerId,
    index,
    isDoor,
    widthMm,
    heightMm,
    handleSide,
    hasBenchNotch,
    isNotchReversed,
    notchVerticalOffsetMm,
    notchVerticalHeightMm,
    notchHorizontalOffsetMm,
    notchHorizontalDepthMm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Panel &&
          other.showerId == this.showerId &&
          other.index == this.index &&
          other.isDoor == this.isDoor &&
          other.widthMm == this.widthMm &&
          other.heightMm == this.heightMm &&
          other.handleSide == this.handleSide &&
          other.hasBenchNotch == this.hasBenchNotch &&
          other.isNotchReversed == this.isNotchReversed &&
          other.notchVerticalOffsetMm == this.notchVerticalOffsetMm &&
          other.notchVerticalHeightMm == this.notchVerticalHeightMm &&
          other.notchHorizontalOffsetMm == this.notchHorizontalOffsetMm &&
          other.notchHorizontalDepthMm == this.notchHorizontalDepthMm);
}

class PanelsCompanion extends UpdateCompanion<Panel> {
  final Value<String> showerId;
  final Value<int> index;
  final Value<bool> isDoor;
  final Value<double?> widthMm;
  final Value<double?> heightMm;
  final Value<HandleSide?> handleSide;
  final Value<bool> hasBenchNotch;
  final Value<bool> isNotchReversed;
  final Value<double?> notchVerticalOffsetMm;
  final Value<double?> notchVerticalHeightMm;
  final Value<double?> notchHorizontalOffsetMm;
  final Value<double?> notchHorizontalDepthMm;
  final Value<int> rowid;
  const PanelsCompanion({
    this.showerId = const Value.absent(),
    this.index = const Value.absent(),
    this.isDoor = const Value.absent(),
    this.widthMm = const Value.absent(),
    this.heightMm = const Value.absent(),
    this.handleSide = const Value.absent(),
    this.hasBenchNotch = const Value.absent(),
    this.isNotchReversed = const Value.absent(),
    this.notchVerticalOffsetMm = const Value.absent(),
    this.notchVerticalHeightMm = const Value.absent(),
    this.notchHorizontalOffsetMm = const Value.absent(),
    this.notchHorizontalDepthMm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PanelsCompanion.insert({
    required String showerId,
    required int index,
    required bool isDoor,
    this.widthMm = const Value.absent(),
    this.heightMm = const Value.absent(),
    this.handleSide = const Value.absent(),
    this.hasBenchNotch = const Value.absent(),
    this.isNotchReversed = const Value.absent(),
    this.notchVerticalOffsetMm = const Value.absent(),
    this.notchVerticalHeightMm = const Value.absent(),
    this.notchHorizontalOffsetMm = const Value.absent(),
    this.notchHorizontalDepthMm = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : showerId = Value(showerId),
       index = Value(index),
       isDoor = Value(isDoor);
  static Insertable<Panel> custom({
    Expression<String>? showerId,
    Expression<int>? index,
    Expression<bool>? isDoor,
    Expression<double>? widthMm,
    Expression<double>? heightMm,
    Expression<int>? handleSide,
    Expression<bool>? hasBenchNotch,
    Expression<bool>? isNotchReversed,
    Expression<double>? notchVerticalOffsetMm,
    Expression<double>? notchVerticalHeightMm,
    Expression<double>? notchHorizontalOffsetMm,
    Expression<double>? notchHorizontalDepthMm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (showerId != null) 'shower_id': showerId,
      if (index != null) 'index': index,
      if (isDoor != null) 'is_door': isDoor,
      if (widthMm != null) 'width_mm': widthMm,
      if (heightMm != null) 'height_mm': heightMm,
      if (handleSide != null) 'handle_side': handleSide,
      if (hasBenchNotch != null) 'has_bench_notch': hasBenchNotch,
      if (isNotchReversed != null) 'is_notch_reversed': isNotchReversed,
      if (notchVerticalOffsetMm != null)
        'notch_vertical_offset_mm': notchVerticalOffsetMm,
      if (notchVerticalHeightMm != null)
        'notch_vertical_height_mm': notchVerticalHeightMm,
      if (notchHorizontalOffsetMm != null)
        'notch_horizontal_offset_mm': notchHorizontalOffsetMm,
      if (notchHorizontalDepthMm != null)
        'notch_horizontal_depth_mm': notchHorizontalDepthMm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PanelsCompanion copyWith({
    Value<String>? showerId,
    Value<int>? index,
    Value<bool>? isDoor,
    Value<double?>? widthMm,
    Value<double?>? heightMm,
    Value<HandleSide?>? handleSide,
    Value<bool>? hasBenchNotch,
    Value<bool>? isNotchReversed,
    Value<double?>? notchVerticalOffsetMm,
    Value<double?>? notchVerticalHeightMm,
    Value<double?>? notchHorizontalOffsetMm,
    Value<double?>? notchHorizontalDepthMm,
    Value<int>? rowid,
  }) {
    return PanelsCompanion(
      showerId: showerId ?? this.showerId,
      index: index ?? this.index,
      isDoor: isDoor ?? this.isDoor,
      widthMm: widthMm ?? this.widthMm,
      heightMm: heightMm ?? this.heightMm,
      handleSide: handleSide ?? this.handleSide,
      hasBenchNotch: hasBenchNotch ?? this.hasBenchNotch,
      isNotchReversed: isNotchReversed ?? this.isNotchReversed,
      notchVerticalOffsetMm:
          notchVerticalOffsetMm ?? this.notchVerticalOffsetMm,
      notchVerticalHeightMm:
          notchVerticalHeightMm ?? this.notchVerticalHeightMm,
      notchHorizontalOffsetMm:
          notchHorizontalOffsetMm ?? this.notchHorizontalOffsetMm,
      notchHorizontalDepthMm:
          notchHorizontalDepthMm ?? this.notchHorizontalDepthMm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (showerId.present) {
      map['shower_id'] = Variable<String>(showerId.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (isDoor.present) {
      map['is_door'] = Variable<bool>(isDoor.value);
    }
    if (widthMm.present) {
      map['width_mm'] = Variable<double>(widthMm.value);
    }
    if (heightMm.present) {
      map['height_mm'] = Variable<double>(heightMm.value);
    }
    if (handleSide.present) {
      map['handle_side'] = Variable<int>(
        $PanelsTable.$converterhandleSiden.toSql(handleSide.value),
      );
    }
    if (hasBenchNotch.present) {
      map['has_bench_notch'] = Variable<bool>(hasBenchNotch.value);
    }
    if (isNotchReversed.present) {
      map['is_notch_reversed'] = Variable<bool>(isNotchReversed.value);
    }
    if (notchVerticalOffsetMm.present) {
      map['notch_vertical_offset_mm'] = Variable<double>(
        notchVerticalOffsetMm.value,
      );
    }
    if (notchVerticalHeightMm.present) {
      map['notch_vertical_height_mm'] = Variable<double>(
        notchVerticalHeightMm.value,
      );
    }
    if (notchHorizontalOffsetMm.present) {
      map['notch_horizontal_offset_mm'] = Variable<double>(
        notchHorizontalOffsetMm.value,
      );
    }
    if (notchHorizontalDepthMm.present) {
      map['notch_horizontal_depth_mm'] = Variable<double>(
        notchHorizontalDepthMm.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PanelsCompanion(')
          ..write('showerId: $showerId, ')
          ..write('index: $index, ')
          ..write('isDoor: $isDoor, ')
          ..write('widthMm: $widthMm, ')
          ..write('heightMm: $heightMm, ')
          ..write('handleSide: $handleSide, ')
          ..write('hasBenchNotch: $hasBenchNotch, ')
          ..write('isNotchReversed: $isNotchReversed, ')
          ..write('notchVerticalOffsetMm: $notchVerticalOffsetMm, ')
          ..write('notchVerticalHeightMm: $notchVerticalHeightMm, ')
          ..write('notchHorizontalOffsetMm: $notchHorizontalOffsetMm, ')
          ..write('notchHorizontalDepthMm: $notchHorizontalDepthMm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    timestamp,
    localPath,
    caption,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Photo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class Photo extends DataClass implements Insertable<Photo> {
  final String id;
  final String entityType;
  final String entityId;
  final DateTime timestamp;
  final String localPath;
  final String? caption;
  const Photo({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.timestamp,
    required this.localPath,
    this.caption,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      timestamp: Value(timestamp),
      localPath: Value(localPath),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
    );
  }

  factory Photo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      localPath: serializer.fromJson<String>(json['localPath']),
      caption: serializer.fromJson<String?>(json['caption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'localPath': serializer.toJson<String>(localPath),
      'caption': serializer.toJson<String?>(caption),
    };
  }

  Photo copyWith({
    String? id,
    String? entityType,
    String? entityId,
    DateTime? timestamp,
    String? localPath,
    Value<String?> caption = const Value.absent(),
  }) => Photo(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    timestamp: timestamp ?? this.timestamp,
    localPath: localPath ?? this.localPath,
    caption: caption.present ? caption.value : this.caption,
  );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      caption: data.caption.present ? data.caption.value : this.caption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('timestamp: $timestamp, ')
          ..write('localPath: $localPath, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityType, entityId, timestamp, localPath, caption);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.timestamp == this.timestamp &&
          other.localPath == this.localPath &&
          other.caption == this.caption);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<DateTime> timestamp;
  final Value<String> localPath;
  final Value<String?> caption;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.localPath = const Value.absent(),
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required DateTime timestamp,
    required String localPath,
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       timestamp = Value(timestamp),
       localPath = Value(localPath);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<DateTime>? timestamp,
    Expression<String>? localPath,
    Expression<String>? caption,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (timestamp != null) 'timestamp': timestamp,
      if (localPath != null) 'local_path': localPath,
      if (caption != null) 'caption': caption,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<DateTime>? timestamp,
    Value<String>? localPath,
    Value<String?>? caption,
    Value<int>? rowid,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      timestamp: timestamp ?? this.timestamp,
      localPath: localPath ?? this.localPath,
      caption: caption ?? this.caption,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('timestamp: $timestamp, ')
          ..write('localPath: $localPath, ')
          ..write('caption: $caption, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $VisitsTable visits = $VisitsTable(this);
  late final $ShowersTable showers = $ShowersTable(this);
  late final $PanelsTable panels = $PanelsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    jobs,
    visits,
    showers,
    panels,
    photos,
  ];
}

typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      required String id,
      required String name,
      required DateTime startDate,
      required int estimatedDurationMinutes,
      required String contactId,
      Value<int> rowid,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> startDate,
      Value<int> estimatedDurationMinutes,
      Value<String> contactId,
      Value<int> rowid,
    });

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, Job> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VisitsTable, List<Visit>> _visitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.visits,
    aliasName: $_aliasNameGenerator(db.jobs.id, db.visits.jobId),
  );

  $$VisitsTableProcessedTableManager get visitsRefs {
    final manager = $$VisitsTableTableManager(
      $_db,
      $_db.visits,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_visitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShowersTable, List<Shower>> _showersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.showers,
    aliasName: $_aliasNameGenerator(db.jobs.id, db.showers.jobId),
  );

  $$ShowersTableProcessedTableManager get showersRefs {
    final manager = $$ShowersTableTableManager(
      $_db,
      $_db.showers,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_showersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> visitsRefs(
    Expression<bool> Function($$VisitsTableFilterComposer f) f,
  ) {
    final $$VisitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.visits,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitsTableFilterComposer(
            $db: $db,
            $table: $db.visits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> showersRefs(
    Expression<bool> Function($$ShowersTableFilterComposer f) f,
  ) {
    final $$ShowersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableFilterComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  Expression<T> visitsRefs<T extends Object>(
    Expression<T> Function($$VisitsTableAnnotationComposer a) f,
  ) {
    final $$VisitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.visits,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitsTableAnnotationComposer(
            $db: $db,
            $table: $db.visits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> showersRefs<T extends Object>(
    Expression<T> Function($$ShowersTableAnnotationComposer a) f,
  ) {
    final $$ShowersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableAnnotationComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          Job,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (Job, $$JobsTableReferences),
          Job,
          PrefetchHooks Function({bool visitsRefs, bool showersRefs})
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> estimatedDurationMinutes = const Value.absent(),
                Value<String> contactId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                name: name,
                startDate: startDate,
                estimatedDurationMinutes: estimatedDurationMinutes,
                contactId: contactId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime startDate,
                required int estimatedDurationMinutes,
                required String contactId,
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                name: name,
                startDate: startDate,
                estimatedDurationMinutes: estimatedDurationMinutes,
                contactId: contactId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$JobsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({visitsRefs = false, showersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (visitsRefs) db.visits,
                if (showersRefs) db.showers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (visitsRefs)
                    await $_getPrefetchedData<Job, $JobsTable, Visit>(
                      currentTable: table,
                      referencedTable: $$JobsTableReferences._visitsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$JobsTableReferences(db, table, p0).visitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.jobId == item.id),
                      typedResults: items,
                    ),
                  if (showersRefs)
                    await $_getPrefetchedData<Job, $JobsTable, Shower>(
                      currentTable: table,
                      referencedTable: $$JobsTableReferences._showersRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$JobsTableReferences(db, table, p0).showersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.jobId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      Job,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (Job, $$JobsTableReferences),
      Job,
      PrefetchHooks Function({bool visitsRefs, bool showersRefs})
    >;
typedef $$VisitsTableCreateCompanionBuilder =
    VisitsCompanion Function({
      required String id,
      required String jobId,
      required DateTime scheduledAt,
      required int durationMinutes,
      required VisitStatus status,
      Value<int> rowid,
    });
typedef $$VisitsTableUpdateCompanionBuilder =
    VisitsCompanion Function({
      Value<String> id,
      Value<String> jobId,
      Value<DateTime> scheduledAt,
      Value<int> durationMinutes,
      Value<VisitStatus> status,
      Value<int> rowid,
    });

final class $$VisitsTableReferences
    extends BaseReferences<_$AppDatabase, $VisitsTable, Visit> {
  $$VisitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias($_aliasNameGenerator(db.visits.jobId, db.jobs.id));

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<String>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ShowersTable, List<Shower>> _showersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.showers,
    aliasName: $_aliasNameGenerator(db.visits.id, db.showers.visitId),
  );

  $$ShowersTableProcessedTableManager get showersRefs {
    final manager = $$ShowersTableTableManager(
      $_db,
      $_db.showers,
    ).filter((f) => f.visitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_showersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VisitsTableFilterComposer
    extends Composer<_$AppDatabase, $VisitsTable> {
  $$VisitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VisitStatus, VisitStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> showersRefs(
    Expression<bool> Function($$ShowersTableFilterComposer f) f,
  ) {
    final $$ShowersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.visitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableFilterComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VisitsTableOrderingComposer
    extends Composer<_$AppDatabase, $VisitsTable> {
  $$VisitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VisitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisitsTable> {
  $$VisitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VisitStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> showersRefs<T extends Object>(
    Expression<T> Function($$ShowersTableAnnotationComposer a) f,
  ) {
    final $$ShowersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.visitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableAnnotationComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VisitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisitsTable,
          Visit,
          $$VisitsTableFilterComposer,
          $$VisitsTableOrderingComposer,
          $$VisitsTableAnnotationComposer,
          $$VisitsTableCreateCompanionBuilder,
          $$VisitsTableUpdateCompanionBuilder,
          (Visit, $$VisitsTableReferences),
          Visit,
          PrefetchHooks Function({bool jobId, bool showersRefs})
        > {
  $$VisitsTableTableManager(_$AppDatabase db, $VisitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> jobId = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<VisitStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VisitsCompanion(
                id: id,
                jobId: jobId,
                scheduledAt: scheduledAt,
                durationMinutes: durationMinutes,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String jobId,
                required DateTime scheduledAt,
                required int durationMinutes,
                required VisitStatus status,
                Value<int> rowid = const Value.absent(),
              }) => VisitsCompanion.insert(
                id: id,
                jobId: jobId,
                scheduledAt: scheduledAt,
                durationMinutes: durationMinutes,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VisitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false, showersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (showersRefs) db.showers],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable: $$VisitsTableReferences
                                    ._jobIdTable(db),
                                referencedColumn: $$VisitsTableReferences
                                    ._jobIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (showersRefs)
                    await $_getPrefetchedData<Visit, $VisitsTable, Shower>(
                      currentTable: table,
                      referencedTable: $$VisitsTableReferences
                          ._showersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VisitsTableReferences(db, table, p0).showersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.visitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VisitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisitsTable,
      Visit,
      $$VisitsTableFilterComposer,
      $$VisitsTableOrderingComposer,
      $$VisitsTableAnnotationComposer,
      $$VisitsTableCreateCompanionBuilder,
      $$VisitsTableUpdateCompanionBuilder,
      (Visit, $$VisitsTableReferences),
      Visit,
      PrefetchHooks Function({bool jobId, bool showersRefs})
    >;
typedef $$ShowersTableCreateCompanionBuilder =
    ShowersCompanion Function({
      required String id,
      required String jobId,
      Value<String?> visitId,
      required String name,
      required ShowerStyle style,
      required DoorType doorType,
      required String templateId,
      required int panelCount,
      Value<int> rowid,
    });
typedef $$ShowersTableUpdateCompanionBuilder =
    ShowersCompanion Function({
      Value<String> id,
      Value<String> jobId,
      Value<String?> visitId,
      Value<String> name,
      Value<ShowerStyle> style,
      Value<DoorType> doorType,
      Value<String> templateId,
      Value<int> panelCount,
      Value<int> rowid,
    });

final class $$ShowersTableReferences
    extends BaseReferences<_$AppDatabase, $ShowersTable, Shower> {
  $$ShowersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias($_aliasNameGenerator(db.showers.jobId, db.jobs.id));

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<String>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VisitsTable _visitIdTable(_$AppDatabase db) => db.visits.createAlias(
    $_aliasNameGenerator(db.showers.visitId, db.visits.id),
  );

  $$VisitsTableProcessedTableManager? get visitId {
    final $_column = $_itemColumn<String>('visit_id');
    if ($_column == null) return null;
    final manager = $$VisitsTableTableManager(
      $_db,
      $_db.visits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_visitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PanelsTable, List<Panel>> _panelsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.panels,
    aliasName: $_aliasNameGenerator(db.showers.id, db.panels.showerId),
  );

  $$PanelsTableProcessedTableManager get panelsRefs {
    final manager = $$PanelsTableTableManager(
      $_db,
      $_db.panels,
    ).filter((f) => f.showerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_panelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShowersTableFilterComposer
    extends Composer<_$AppDatabase, $ShowersTable> {
  $$ShowersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ShowerStyle, ShowerStyle, int> get style =>
      $composableBuilder(
        column: $table.style,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<DoorType, DoorType, int> get doorType =>
      $composableBuilder(
        column: $table.doorType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get panelCount => $composableBuilder(
    column: $table.panelCount,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VisitsTableFilterComposer get visitId {
    final $$VisitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.visitId,
      referencedTable: $db.visits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitsTableFilterComposer(
            $db: $db,
            $table: $db.visits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> panelsRefs(
    Expression<bool> Function($$PanelsTableFilterComposer f) f,
  ) {
    final $$PanelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.panels,
      getReferencedColumn: (t) => t.showerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PanelsTableFilterComposer(
            $db: $db,
            $table: $db.panels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShowersTableOrderingComposer
    extends Composer<_$AppDatabase, $ShowersTable> {
  $$ShowersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get doorType => $composableBuilder(
    column: $table.doorType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get panelCount => $composableBuilder(
    column: $table.panelCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VisitsTableOrderingComposer get visitId {
    final $$VisitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.visitId,
      referencedTable: $db.visits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitsTableOrderingComposer(
            $db: $db,
            $table: $db.visits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShowersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShowersTable> {
  $$ShowersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ShowerStyle, int> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DoorType, int> get doorType =>
      $composableBuilder(column: $table.doorType, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get panelCount => $composableBuilder(
    column: $table.panelCount,
    builder: (column) => column,
  );

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VisitsTableAnnotationComposer get visitId {
    final $$VisitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.visitId,
      referencedTable: $db.visits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitsTableAnnotationComposer(
            $db: $db,
            $table: $db.visits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> panelsRefs<T extends Object>(
    Expression<T> Function($$PanelsTableAnnotationComposer a) f,
  ) {
    final $$PanelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.panels,
      getReferencedColumn: (t) => t.showerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PanelsTableAnnotationComposer(
            $db: $db,
            $table: $db.panels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShowersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShowersTable,
          Shower,
          $$ShowersTableFilterComposer,
          $$ShowersTableOrderingComposer,
          $$ShowersTableAnnotationComposer,
          $$ShowersTableCreateCompanionBuilder,
          $$ShowersTableUpdateCompanionBuilder,
          (Shower, $$ShowersTableReferences),
          Shower,
          PrefetchHooks Function({bool jobId, bool visitId, bool panelsRefs})
        > {
  $$ShowersTableTableManager(_$AppDatabase db, $ShowersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShowersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShowersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShowersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> jobId = const Value.absent(),
                Value<String?> visitId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ShowerStyle> style = const Value.absent(),
                Value<DoorType> doorType = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> panelCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShowersCompanion(
                id: id,
                jobId: jobId,
                visitId: visitId,
                name: name,
                style: style,
                doorType: doorType,
                templateId: templateId,
                panelCount: panelCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String jobId,
                Value<String?> visitId = const Value.absent(),
                required String name,
                required ShowerStyle style,
                required DoorType doorType,
                required String templateId,
                required int panelCount,
                Value<int> rowid = const Value.absent(),
              }) => ShowersCompanion.insert(
                id: id,
                jobId: jobId,
                visitId: visitId,
                name: name,
                style: style,
                doorType: doorType,
                templateId: templateId,
                panelCount: panelCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShowersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({jobId = false, visitId = false, panelsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (panelsRefs) db.panels],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (jobId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.jobId,
                                    referencedTable: $$ShowersTableReferences
                                        ._jobIdTable(db),
                                    referencedColumn: $$ShowersTableReferences
                                        ._jobIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (visitId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.visitId,
                                    referencedTable: $$ShowersTableReferences
                                        ._visitIdTable(db),
                                    referencedColumn: $$ShowersTableReferences
                                        ._visitIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (panelsRefs)
                        await $_getPrefetchedData<Shower, $ShowersTable, Panel>(
                          currentTable: table,
                          referencedTable: $$ShowersTableReferences
                              ._panelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShowersTableReferences(
                                db,
                                table,
                                p0,
                              ).panelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.showerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ShowersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShowersTable,
      Shower,
      $$ShowersTableFilterComposer,
      $$ShowersTableOrderingComposer,
      $$ShowersTableAnnotationComposer,
      $$ShowersTableCreateCompanionBuilder,
      $$ShowersTableUpdateCompanionBuilder,
      (Shower, $$ShowersTableReferences),
      Shower,
      PrefetchHooks Function({bool jobId, bool visitId, bool panelsRefs})
    >;
typedef $$PanelsTableCreateCompanionBuilder =
    PanelsCompanion Function({
      required String showerId,
      required int index,
      required bool isDoor,
      Value<double?> widthMm,
      Value<double?> heightMm,
      Value<HandleSide?> handleSide,
      Value<bool> hasBenchNotch,
      Value<bool> isNotchReversed,
      Value<double?> notchVerticalOffsetMm,
      Value<double?> notchVerticalHeightMm,
      Value<double?> notchHorizontalOffsetMm,
      Value<double?> notchHorizontalDepthMm,
      Value<int> rowid,
    });
typedef $$PanelsTableUpdateCompanionBuilder =
    PanelsCompanion Function({
      Value<String> showerId,
      Value<int> index,
      Value<bool> isDoor,
      Value<double?> widthMm,
      Value<double?> heightMm,
      Value<HandleSide?> handleSide,
      Value<bool> hasBenchNotch,
      Value<bool> isNotchReversed,
      Value<double?> notchVerticalOffsetMm,
      Value<double?> notchVerticalHeightMm,
      Value<double?> notchHorizontalOffsetMm,
      Value<double?> notchHorizontalDepthMm,
      Value<int> rowid,
    });

final class $$PanelsTableReferences
    extends BaseReferences<_$AppDatabase, $PanelsTable, Panel> {
  $$PanelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShowersTable _showerIdTable(_$AppDatabase db) => db.showers
      .createAlias($_aliasNameGenerator(db.panels.showerId, db.showers.id));

  $$ShowersTableProcessedTableManager get showerId {
    final $_column = $_itemColumn<String>('shower_id')!;

    final manager = $$ShowersTableTableManager(
      $_db,
      $_db.showers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_showerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PanelsTableFilterComposer
    extends Composer<_$AppDatabase, $PanelsTable> {
  $$PanelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDoor => $composableBuilder(
    column: $table.isDoor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthMm => $composableBuilder(
    column: $table.widthMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightMm => $composableBuilder(
    column: $table.heightMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HandleSide?, HandleSide, int> get handleSide =>
      $composableBuilder(
        column: $table.handleSide,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get hasBenchNotch => $composableBuilder(
    column: $table.hasBenchNotch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNotchReversed => $composableBuilder(
    column: $table.isNotchReversed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get notchVerticalOffsetMm => $composableBuilder(
    column: $table.notchVerticalOffsetMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get notchVerticalHeightMm => $composableBuilder(
    column: $table.notchVerticalHeightMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get notchHorizontalOffsetMm => $composableBuilder(
    column: $table.notchHorizontalOffsetMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get notchHorizontalDepthMm => $composableBuilder(
    column: $table.notchHorizontalDepthMm,
    builder: (column) => ColumnFilters(column),
  );

  $$ShowersTableFilterComposer get showerId {
    final $$ShowersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.showerId,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableFilterComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PanelsTableOrderingComposer
    extends Composer<_$AppDatabase, $PanelsTable> {
  $$PanelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDoor => $composableBuilder(
    column: $table.isDoor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthMm => $composableBuilder(
    column: $table.widthMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightMm => $composableBuilder(
    column: $table.heightMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get handleSide => $composableBuilder(
    column: $table.handleSide,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasBenchNotch => $composableBuilder(
    column: $table.hasBenchNotch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNotchReversed => $composableBuilder(
    column: $table.isNotchReversed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get notchVerticalOffsetMm => $composableBuilder(
    column: $table.notchVerticalOffsetMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get notchVerticalHeightMm => $composableBuilder(
    column: $table.notchVerticalHeightMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get notchHorizontalOffsetMm => $composableBuilder(
    column: $table.notchHorizontalOffsetMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get notchHorizontalDepthMm => $composableBuilder(
    column: $table.notchHorizontalDepthMm,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShowersTableOrderingComposer get showerId {
    final $$ShowersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.showerId,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableOrderingComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PanelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PanelsTable> {
  $$PanelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<bool> get isDoor =>
      $composableBuilder(column: $table.isDoor, builder: (column) => column);

  GeneratedColumn<double> get widthMm =>
      $composableBuilder(column: $table.widthMm, builder: (column) => column);

  GeneratedColumn<double> get heightMm =>
      $composableBuilder(column: $table.heightMm, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HandleSide?, int> get handleSide =>
      $composableBuilder(
        column: $table.handleSide,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get hasBenchNotch => $composableBuilder(
    column: $table.hasBenchNotch,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isNotchReversed => $composableBuilder(
    column: $table.isNotchReversed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get notchVerticalOffsetMm => $composableBuilder(
    column: $table.notchVerticalOffsetMm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get notchVerticalHeightMm => $composableBuilder(
    column: $table.notchVerticalHeightMm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get notchHorizontalOffsetMm => $composableBuilder(
    column: $table.notchHorizontalOffsetMm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get notchHorizontalDepthMm => $composableBuilder(
    column: $table.notchHorizontalDepthMm,
    builder: (column) => column,
  );

  $$ShowersTableAnnotationComposer get showerId {
    final $$ShowersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.showerId,
      referencedTable: $db.showers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShowersTableAnnotationComposer(
            $db: $db,
            $table: $db.showers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PanelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PanelsTable,
          Panel,
          $$PanelsTableFilterComposer,
          $$PanelsTableOrderingComposer,
          $$PanelsTableAnnotationComposer,
          $$PanelsTableCreateCompanionBuilder,
          $$PanelsTableUpdateCompanionBuilder,
          (Panel, $$PanelsTableReferences),
          Panel,
          PrefetchHooks Function({bool showerId})
        > {
  $$PanelsTableTableManager(_$AppDatabase db, $PanelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PanelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PanelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PanelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> showerId = const Value.absent(),
                Value<int> index = const Value.absent(),
                Value<bool> isDoor = const Value.absent(),
                Value<double?> widthMm = const Value.absent(),
                Value<double?> heightMm = const Value.absent(),
                Value<HandleSide?> handleSide = const Value.absent(),
                Value<bool> hasBenchNotch = const Value.absent(),
                Value<bool> isNotchReversed = const Value.absent(),
                Value<double?> notchVerticalOffsetMm = const Value.absent(),
                Value<double?> notchVerticalHeightMm = const Value.absent(),
                Value<double?> notchHorizontalOffsetMm = const Value.absent(),
                Value<double?> notchHorizontalDepthMm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PanelsCompanion(
                showerId: showerId,
                index: index,
                isDoor: isDoor,
                widthMm: widthMm,
                heightMm: heightMm,
                handleSide: handleSide,
                hasBenchNotch: hasBenchNotch,
                isNotchReversed: isNotchReversed,
                notchVerticalOffsetMm: notchVerticalOffsetMm,
                notchVerticalHeightMm: notchVerticalHeightMm,
                notchHorizontalOffsetMm: notchHorizontalOffsetMm,
                notchHorizontalDepthMm: notchHorizontalDepthMm,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String showerId,
                required int index,
                required bool isDoor,
                Value<double?> widthMm = const Value.absent(),
                Value<double?> heightMm = const Value.absent(),
                Value<HandleSide?> handleSide = const Value.absent(),
                Value<bool> hasBenchNotch = const Value.absent(),
                Value<bool> isNotchReversed = const Value.absent(),
                Value<double?> notchVerticalOffsetMm = const Value.absent(),
                Value<double?> notchVerticalHeightMm = const Value.absent(),
                Value<double?> notchHorizontalOffsetMm = const Value.absent(),
                Value<double?> notchHorizontalDepthMm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PanelsCompanion.insert(
                showerId: showerId,
                index: index,
                isDoor: isDoor,
                widthMm: widthMm,
                heightMm: heightMm,
                handleSide: handleSide,
                hasBenchNotch: hasBenchNotch,
                isNotchReversed: isNotchReversed,
                notchVerticalOffsetMm: notchVerticalOffsetMm,
                notchVerticalHeightMm: notchVerticalHeightMm,
                notchHorizontalOffsetMm: notchHorizontalOffsetMm,
                notchHorizontalDepthMm: notchHorizontalDepthMm,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PanelsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({showerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (showerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.showerId,
                                referencedTable: $$PanelsTableReferences
                                    ._showerIdTable(db),
                                referencedColumn: $$PanelsTableReferences
                                    ._showerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PanelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PanelsTable,
      Panel,
      $$PanelsTableFilterComposer,
      $$PanelsTableOrderingComposer,
      $$PanelsTableAnnotationComposer,
      $$PanelsTableCreateCompanionBuilder,
      $$PanelsTableUpdateCompanionBuilder,
      (Panel, $$PanelsTableReferences),
      Panel,
      PrefetchHooks Function({bool showerId})
    >;
typedef $$PhotosTableCreateCompanionBuilder =
    PhotosCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required DateTime timestamp,
      required String localPath,
      Value<String?> caption,
      Value<int> rowid,
    });
typedef $$PhotosTableUpdateCompanionBuilder =
    PhotosCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<DateTime> timestamp,
      Value<String> localPath,
      Value<String?> caption,
      Value<int> rowid,
    });

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          Photo,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
          Photo,
          PrefetchHooks Function()
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                timestamp: timestamp,
                localPath: localPath,
                caption: caption,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required DateTime timestamp,
                required String localPath,
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                timestamp: timestamp,
                localPath: localPath,
                caption: caption,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      Photo,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
      Photo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$VisitsTableTableManager get visits =>
      $$VisitsTableTableManager(_db, _db.visits);
  $$ShowersTableTableManager get showers =>
      $$ShowersTableTableManager(_db, _db.showers);
  $$PanelsTableTableManager get panels =>
      $$PanelsTableTableManager(_db, _db.panels);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
}
