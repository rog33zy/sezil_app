class PreHarvestModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String? lodgingResistance;
  String? huskCover;
  String? cobSize;
  String? numberOfCobsPerPlant;
  String? plantHeight;
  String? birdDamage;
  String? panicleAppreciation;
  String? grainQualityAppreciation;
  String? headSizeAppreciation;
  String? plantGrowthHabitAppreciation;
  String? willingnessToCultivateNextSeason;

  PreHarvestModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
  });
}
