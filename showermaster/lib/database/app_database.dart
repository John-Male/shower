import 'package:drift/drift.dart';
import 'database_connection.dart'; // ✅ platform-aware executor

import '../models/job.dart';
import '../models/visit.dart';
import '../models/shower.dart';
import '../models/panel.dart';
import '../models/photo.dart';

part 'app_database.g.dart';

// Table definitions for Drift
class Jobs extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get startDate => dateTime()();
  IntColumn get estimatedDurationMinutes => integer()();
  TextColumn get contactId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Visits extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text().references(Jobs, #id)();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get durationMinutes => integer()();
  IntColumn get status => intEnum<VisitStatus>()();

  @override
  Set<Column> get primaryKey => {id};
}

class Showers extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text().references(Jobs, #id)();
  TextColumn get visitId => text().nullable().references(Visits, #id)();
  TextColumn get name => text()();
  IntColumn get style => intEnum<ShowerStyle>()();
  IntColumn get doorType => intEnum<DoorType>()();
  TextColumn get templateId => text()();
  IntColumn get panelCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Panels extends Table {
  TextColumn get showerId => text().references(Showers, #id)();
  IntColumn get index => integer()();
  BoolColumn get isDoor => boolean()();
  RealColumn get widthMm => real().nullable()();
  RealColumn get heightMm => real().nullable()();
  IntColumn get handleSide => intEnum<HandleSide>().nullable()();
  BoolColumn get hasBenchNotch => boolean().withDefault(const Constant(false))();
  BoolColumn get isNotchReversed => boolean().withDefault(const Constant(false))();
  RealColumn get notchVerticalOffsetMm => real().nullable()();
  RealColumn get notchVerticalHeightMm => real().nullable()();
  RealColumn get notchHorizontalOffsetMm => real().nullable()();
  RealColumn get notchHorizontalDepthMm => real().nullable()();

  @override
  Set<Column> get primaryKey => {showerId, index};
}

class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get localPath => text()();
  TextColumn get caption => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Jobs, Visits, Showers, Panels, Photos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(createQueryExecutor()); // ✅ use platform-specific executor

  @override
  int get schemaVersion => 1;

  // Jobs
  Future<List<Job>> getAllJobs() => select(jobs).get();
  Future<void> insertJob(JobsCompanion job) => into(jobs).insert(job);
  Future<void> updateJob(String id, JobsCompanion job) => 
      (update(jobs)..where((j) => j.id.equals(id))).write(job);
  Future<void> deleteJob(String id) => 
      (delete(jobs)..where((j) => j.id.equals(id))).go();

  // Visits
  Future<List<Visit>> getVisitsForJob(String jobId) =>
      (select(visits)..where((v) => v.jobId.equals(jobId))).get();
  Future<Visit?> getVisit(String id) => 
      (select(visits)..where((v) => v.id.equals(id))).getSingleOrNull();
  Future<void> insertVisit(VisitsCompanion visit) => into(visits).insert(visit);
  Future<void> updateVisit(String id, VisitsCompanion visit) => 
      (update(visits)..where((v) => v.id.equals(id))).write(visit);
  Future<void> deleteVisit(String id) => 
      (delete(visits)..where((v) => v.id.equals(id))).go();

  // Showers
  Future<List<Shower>> getShowersForJob(String jobId) =>
      (select(showers)..where((s) => s.jobId.equals(jobId))).get();
  Future<Shower?> getShower(String id) => 
      (select(showers)..where((s) => s.id.equals(id))).getSingleOrNull();
  Future<void> insertShower(ShowersCompanion shower) => into(showers).insert(shower);
  Future<void> updateShower(String id, ShowersCompanion shower) => 
      (update(showers)..where((s) => s.id.equals(id))).write(shower);
  Future<void> deleteShower(String id) => 
      (delete(showers)..where((s) => s.id.equals(id))).go();
  Future<List<Shower>> getShowersForJobVisit(String visitId) =>
      (select(showers)..where((s) => s.visitId.equals(visitId))).get();

  // Panels
  Future<List<Panel>> getPanelsForShower(String showerId) =>
      (select(panels)..where((p) => p.showerId.equals(showerId))).get();
  Future<void> insertPanel(PanelsCompanion panel) => into(panels).insert(panel);
  Future<void> updatePanel(String showerId, int index, PanelsCompanion panel) => 
      (update(panels)..where((p) => p.showerId.equals(showerId) & p.index.equals(index))).write(panel);
  Future<void> deletePanel(String showerId, int index) => 
      (delete(panels)..where((p) => p.showerId.equals(showerId) & p.index.equals(index))).go();
  Future<void> deletePanelsForShower(String showerId) => 
      (delete(panels)..where((p) => p.showerId.equals(showerId))).go();

  // Photos
  Future<List<Photo>> getPhotosForEntity(String type, String id) =>
      (select(photos)
        ..where((p) => p.entityType.equals(type) & p.entityId.equals(id)))
          .get();
  Future<void> insertPhoto(PhotosCompanion photo) => into(photos).insert(photo);
  Future<void> deletePhoto(String id) => 
      (delete(photos)..where((p) => p.id.equals(id))).go();
}
