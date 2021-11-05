class FertilizationModel {
  final String id;
  DateTime? lastUpdated;
  final String season;
  final String typeOfDressing;
  String nameOfOrganicFertilizer;
  String nameOfSyntheticFertilizer;
  double? quantityApplied;
  DateTime? timeOfApplication;
  String isUpToDateInServer;
  String existsInServer;

  FertilizationModel({
    required this.id,
    this.lastUpdated,
    required this.season,
    required this.typeOfDressing,
    this.nameOfOrganicFertilizer = 'Blank',
    this.nameOfSyntheticFertilizer = 'Blank',
    this.quantityApplied,
    this.timeOfApplication,
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
