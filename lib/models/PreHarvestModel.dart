class PreHarvestModel {
  final String id;
  final String fieldId;
  DateTime lastUpdated;
  final String crop;
  final String variety;
  final String plotId;
  final String trialId;
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
    required this.fieldId,
    required this.lastUpdated,
    required this.crop,
    required this.variety,
    required this.plotId,
    required this.trialId,
  });
}
