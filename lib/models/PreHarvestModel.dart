class PreHarvestModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String lodgingResistance;
  String lodgingResistanceComments;
  String huskCover;
  String huskCoverComments;
  String cobSize;
  String cobSizeComments;
  String numberOfCobsPerPlant;
  String numberOfCobsPerPlantComments;
  String plantHeight;
  String plantHeightComments;
  String birdDamage;
  String birdDamageComments;
  String panicleAppreciation;
  String panicleAppreciationComments;
  String grainQualityAppreciation;
  String grainQualityAppreciationComments;
  String headSizeAppreciation;
  String headSizeAppreciationComments;
  String numberOfHeadsAppreciation;
  String numberOfHeadsAppreciationComments;
  String plantGrowthHabitAppreciation;
  String plantGrowthHabitAppreciationComments;
  String podLengthAppreciation;
  String podLengthAppreciationComments;
  String willingnessToCultivateNextSeason;
  String willingnessToCultivateNextSeasonComments;
  String isUpToDateInServer;
  String existsInServer;

  PreHarvestModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.lodgingResistance = 'Blank',
    this.lodgingResistanceComments = 'Blank',
    this.huskCover = 'Blank',
    this.huskCoverComments = 'Blank',
    this.cobSize = 'Blank',
    this.cobSizeComments = 'Blank',
    this.numberOfCobsPerPlant = 'Blank',
    this.numberOfCobsPerPlantComments = 'Blank',
    this.plantHeight = 'Blank',
    this.plantHeightComments = 'Blank',
    this.birdDamage = 'Blank',
    this.birdDamageComments = 'Blank',
    this.panicleAppreciation = 'Blank',
    this.panicleAppreciationComments = 'Blank',
    this.grainQualityAppreciation = 'Blank',
    this.grainQualityAppreciationComments = 'Blank',
    this.headSizeAppreciation = 'Blank',
    this.headSizeAppreciationComments = 'Blank',
    this.numberOfHeadsAppreciation = 'Blank',
    this.numberOfHeadsAppreciationComments = 'Blank',
    this.plantGrowthHabitAppreciation = 'Blank',
    this.plantGrowthHabitAppreciationComments = 'Blank',
    this.podLengthAppreciation = 'Blank',
    this.podLengthAppreciationComments = 'Blank',
    this.willingnessToCultivateNextSeason = 'Blank',
    this.willingnessToCultivateNextSeasonComments = 'Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
