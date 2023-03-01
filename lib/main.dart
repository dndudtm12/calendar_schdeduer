import 'package:calendar_schdeduer/datebase/drift_database.dart';
import 'package:calendar_schdeduer/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';

const DEFAULAT_COLORS = [
  'F44336',
  'FF9800',
  'FFEB3B',
  '2196F3',
  '3F51B5',
  '9C27B0',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDataBase();

  GetIt.instance.registerSingleton<LocalDataBase>(database);

  final colors = await database.getCategoryColors();

  if(colors.isEmpty){
    for(String hexCode in DEFAULAT_COLORS){
      await database.createCategoryColors(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const HomeScreen(),
    ),
  );
}
