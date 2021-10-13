import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    String pathToDb = path.join(
      databasesPath,
      'sezil.db',
    );

    Database database = await openDatabase(
      pathToDb,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE 
              fieldOperations 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  dateOfLandPreparation TEXT,
                  methodOfLandPreparation TEXT,
                  dateOfPlanting TEXT,
                  dateOfThinning TEXT,
                  dateOfFirstWeeding TEXT,
                  dateOfSecondWeeding TEXT,
                  isUpToDateInServer TEXT
                )
          ''',
        );
        await db.execute(
          '''CREATE TABLE 
              currentSeasonVariety 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  varietyName TEXT,
                  previousSeasonHarvest num,
                  previousSeasonHectarage num,
                  sourceOfSeed TEXT,
                  numberOfYearsGrown num,
                  percentFarmersGrowingVariety num,
                  isUpToDateInServer TEXT
                )
          ''',
        );
      },
    );
    return database;
  }

  static Future<void>? insert(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.database();
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await DBHelper.database();
    return await db.query(tableName);
  }
}
