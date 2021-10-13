class FertilizationModel {
  final String id;
  DateTime? lastUpdated;
  final String season;
  String typeOfFertilizer;
  String nameOfFertilizer;
  double? quantityApplied;
  DateTime? timeOfApplication;
  String isUpToDateInServer;

  FertilizationModel({
    required this.id,
    this.lastUpdated,
    required this.season,
    this.typeOfFertilizer = '',
    this.nameOfFertilizer = '',
    this.quantityApplied,
    this.timeOfApplication,
    this.isUpToDateInServer = 'No',
  });
}
