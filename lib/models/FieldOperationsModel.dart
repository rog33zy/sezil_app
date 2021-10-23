class FieldOperationsModel {
  final String id;
  DateTime? lastUpdated;
  DateTime? dateOfLandPreparation;
  String methodOfLandPreparation;
  DateTime? dateOfPlanting;
  DateTime? dateOfThinning;
  DateTime? dateOfFirstWeeding;
  DateTime? dateOfSecondWeeding;
  String isUpToDateInServer;

  FieldOperationsModel({
    required this.id,
    this.lastUpdated,
    this.dateOfLandPreparation,
    this.methodOfLandPreparation = 'Blank',
    this.dateOfPlanting,
    this.dateOfThinning,
    this.dateOfFirstWeeding,
    this.dateOfSecondWeeding,
    this.isUpToDateInServer = 'No',
  });
}
