class FieldProfileModel {
  final String id;
  DateTime? lastUpdated;
  double? fieldSize;
  String soilType;
  double? latitude;
  double? longitude;
  String cropGrownPrevSeason;
  String cropGrownTwoSeasonsAgo;

  FieldProfileModel({
    required this.id,
    this.lastUpdated,
    this.fieldSize,
    this.soilType = 'Blank',
    this.latitude,
    this.longitude,
    this.cropGrownPrevSeason = 'Blank',
    this.cropGrownTwoSeasonsAgo = 'Blank',
  });
}
