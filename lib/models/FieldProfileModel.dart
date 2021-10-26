class FieldProfileModel {
  final String id;
  DateTime? lastUpdated;
  String fieldSize;
  String soilType;
  double? latitude;
  double? longitude;
  String cropGrownPrevSeason;
  String cropGrownTwoSeasonsAgo;
  String prevSeasonWeedingManual;
  String prevSeasonWeedingChemicalName;
  String isUpToDateInServer;

  FieldProfileModel({
    required this.id,
    this.lastUpdated,
    this.fieldSize = 'Blank',
    this.soilType = 'Blank',
    this.latitude,
    this.longitude,
    this.cropGrownPrevSeason = 'Blank',
    this.cropGrownTwoSeasonsAgo = 'Blank',
    this.prevSeasonWeedingManual = 'Blank',
    this.prevSeasonWeedingChemicalName = 'Blank',
    this.isUpToDateInServer = 'No',
  });
}
