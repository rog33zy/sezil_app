class CurrentSeasonVarietyModel {
  String id;
  DateTime? lastUpdated;
  String varietyName;
  double? previousSeasonHarvest;
  double? previousSeasonHectarage;
  String sourceOfSeed;
  int? numberOfYearsGrown;
  int? percentFarmersGrowingVariety;
  String isUpToDateInServer;

  CurrentSeasonVarietyModel({
    this.id = 'rtyd',
    this.lastUpdated,
    this.varietyName = 'Blank',
    this.previousSeasonHarvest,
    this.previousSeasonHectarage,
    this.sourceOfSeed = 'Blank',
    this.numberOfYearsGrown,
    this.percentFarmersGrowingVariety,
    this.isUpToDateInServer = 'No',
  });
}
