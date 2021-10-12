class CurrentSeasonVarietyModel {
  String id;
  String fieldId;
  DateTime? lastUpdated;
  String varietyName;
  String reasonsForGrowingVariety;
  String mainFeaturesOfVariety;
  double? previousSeasonHarvest;
  double? previousSeasonHectarage;
  String sourceOfSeed;
  double? numberOfYearsGrown;
  double? percentFarmersGrowingVariety;

  CurrentSeasonVarietyModel({
    required this.id,
    required this.fieldId,
    this.lastUpdated,
    this.varietyName = '',
    this.reasonsForGrowingVariety = '',
    this.mainFeaturesOfVariety = '',
    this.previousSeasonHarvest,
    this.previousSeasonHectarage,
    this.sourceOfSeed = '',
    this.numberOfYearsGrown,
    this.percentFarmersGrowingVariety,
  });
}
