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
                  firstWeedingIsManual TEXT,
                  firstWeedingHerbicideName TEXT,
                  firstWeedingHerbicideQty REAL,
                  dateOfPesticideApplication TEXT,
                  pesticideName TEXT,
                  pesticideApplicationQty REAL,
                  dateOfSecondWeeding TEXT,
                  secondWeedingIsManual TEXT,
                  secondWeedingHerbicideName TEXT,
                  secondWeedingHerbicideQty REAL,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
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
                  previousSeasonHarvest REAL,
                  previousSeasonHectarage REAL,
                  sourceOfSeed TEXT,
                  numberOfYearsGrown INTEGER,
                  percentFarmersGrowingVariety INTEGER,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              fertilization 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  season TEXT,
                  typeOfDressing TEXT,
                  nameOfOrganicFertilizer TEXT,
                  nameOfSyntheticFertilizer TEXT,
                  quantityApplied REAL,
                  timeOfApplication TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              fieldProfile 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  fieldSize TEXT,
                  soilType TEXT,
                  latitude REAL,
                  longitude REAL,
                  cropGrownPrevSeason TEXT,
                  cropGrownTwoSeasonsAgo TEXT,
                  prevSeasonWeedingChemical TEXT,
                  prevSeasonWeedingChemicalName TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              postPlanting 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  seedlingVigour TEXT,
                  seedlingVigourComments TEXT,
                  plantStand INTEGER,
                  plantStandComments TEXT,
                  pestResistance TEXT,
                  pestResistanceComments TEXT,
                  diseasesResistance TEXT,
                  diseasesResistanceComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              flowering 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  growingCycleAppreciation TEXT,
                  growingCycleAppreciationComments TEXT,
                  pestResistance TEXT,
                  pestResistanceComments TEXT,
                  diseasesResistance TEXT,
                  diseasesResistanceComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              postFlowering 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  pestResistance TEXT,
                  pestResistanceComments TEXT,
                  diseasesResistance TEXT,
                  diseasesResistanceComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              preHarvest 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  lodgingResistance TEXT,
                  lodgingResistanceComments TEXT,
                  huskCover TEXT,
                  huskCoverComments TEXT,
                  cobSizeAppreciation TEXT,
                  cobSizeAppreciationComments TEXT,
                  numberOfCobsPerPlantAppreciation TEXT,
                  numberOfCobsPerPlantAppreciationComments TEXT,
                  plantHeight TEXT,
                  plantHeightComments TEXT,
                  birdDamage TEXT,
                  birdDamageComments TEXT,
                  panicleAppreciation TEXT,
                  panicleAppreciationComments TEXT,
                  grainQualityAppreciation TEXT,
                  grainQualityAppreciationComments TEXT,
                  headSizeAppreciation TEXT,
                  headSizeAppreciationComments TEXT,
                  numberOfHeadsAppreciation TEXT,
                  numberOfHeadsAppreciationComments TEXT,
                  plantGrowthHabitAppreciation TEXT,
                  plantGrowthHabitAppreciationComments TEXT,
                  podLengthAppreciation TEXT,
                  podLengthAppreciationComments TEXT,
                  willingnessToCultivateNextSeason TEXT,
                  willingnessToCultivateNextSeasonComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              harvest 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  harvestDate TEXT,
                  numberOfPlants INTEGER,
                  numberOfPlantsComments TEXT,
                  numberOfHarvestedCobs INTEGER,
                  numberOfHarvestedCobsComments TEXT,
                  yieldOfHarvestedCobs REAL,
                  yieldOfHarvestedCobsComments TEXT,
                  numberOfHarvestedPanicles INTEGER,
                  numberOfHarvestedPaniclesComments TEXT,
                  yieldOfHarvestedPanicles REAL,
                  yieldOfHarvestedPaniclesComments TEXT,
                  numberOfHarvestedHeads INTEGER,
                  numberOfHarvestedHeadsComments TEXT,
                  yieldOfHarvestedHeads REAL,
                  yieldOfHarvestedHeadsComments TEXT,
                  numberOfHarvestedPods INTEGER,
                  numberOfHarvestedPodsComments TEXT,
                  yieldOfHarvestedPods REAL,
                  yieldOfHarvestedPodsComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
                )
          ''',
        );

        await db.execute(
          '''CREATE TABLE 
              postHarvest 
                (
                  id TEXT PRIMARY KEY,
                  lastUpdated TEXT,
                  plotId TEXT,
                  yieldOfDriedCobs REAL,
                  yieldOfDriedCobsComments TEXT,
                  grainHardness TEXT,
                  grainHardnessComments TEXT,
                  yieldOfDriedPanicles REAL,
                  yieldOfDriedPaniclesComments TEXT,
                  yieldOfDriedHeads REAL,
                  yieldOfDriedHeadsComments TEXT,
                  yieldOfDriedPods REAL,
                  yieldOfDriedPodsComments TEXT,
                  grainsYield REAL,
                  grainsYieldComments TEXT,
                  grainSizeAppreciation TEXT,
                  grainSizeAppreciationComments TEXT,
                  grainColourAppreciation TEXT,
                  grainColourAppreciationComments TEXT,
                  isUpToDateInServer TEXT,
                  existsInServer TEXT
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
