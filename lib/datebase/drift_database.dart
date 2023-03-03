import 'dart:io';

import 'package:calendar_schdeduer/model/category_color.dart';
import 'package:calendar_schdeduer/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../model/schedule_with_color.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColors(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    query.where(schedules.date.equals(date));
    query.orderBy([
      OrderingTerm.asc(schedules.startTime)
    ]);

    return query.watch().map(
          (rows) => rows.map(
            (row) => ScheduleWithColor(
              schedule: row.readTable(schedules),
              categoryColor: row.readTable(categoryColors),
            ),
          ).toList(),
        );
  }

  Future<Schedule> watchSchedule(int id) => (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);

  /*{
    */ /*final query = select(schedules);
    query.where((tbl) => tbl.date.equals(date));
    return query.watch();

    select(schedules).where((tbl) => tbl.date.equals(date)).watch();
    */ /*

    return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  }*/

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(
        dbFolder.path,
        'db.sqlite',
      ),
    );
    return NativeDatabase(file);
  });
}
