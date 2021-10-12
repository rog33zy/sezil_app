class FieldProfileModel {
  final String id;
  final String fieldId;
  DateTime? lastUpdated;
  double? fieldSize;
  String soilType;
  double? latitude;
  double? longitude;
  String cropGrownPrevSeason;
  String cropGrownTwoSeasonsAgain;

  FieldProfileModel({
    required this.id,
    required this.fieldId,
    this.lastUpdated,
    this.fieldSize,
    this.soilType = '',
    this.latitude,
    this.longitude,
    this.cropGrownPrevSeason = '',
    this.cropGrownTwoSeasonsAgain = '',
  });
}
