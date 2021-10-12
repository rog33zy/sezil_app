class FertilizationModel {
  final String id;
  final String fieldId;
  DateTime? lastUpdated;
  String typeOfFertilizer;
  String nameOfFertilizer;
  double? quantityApplied;
  String? timeOfApplication;

  FertilizationModel({
    required this.id,
    required this.fieldId,
    required this.lastUpdated,
    this.typeOfFertilizer='',
    this.nameOfFertilizer='',
    this.quantityApplied,
    this.timeOfApplication,
  });
}
