class CurrentSeasonVarietyModel {
  String id;
  DateTime? lastUpdated;
  String varietyName;
  double? previousSeasonHarvest;
  double? previousSeasonHectarage;
  String sourceOfSeed;
  double? numberOfYearsGrown;
  double? percentFarmersGrowingVariety;
  String isUpToDateInServer;

  CurrentSeasonVarietyModel({
    this.id = 'rtyd',
    this.lastUpdated,
    this.varietyName = '',
    this.previousSeasonHarvest,
    this.previousSeasonHectarage,
    this.sourceOfSeed = '',
    this.numberOfYearsGrown,
    this.percentFarmersGrowingVariety,
    this.isUpToDateInServer = 'No',
  });
}
