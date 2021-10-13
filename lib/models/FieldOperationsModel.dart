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
    this.id = '3454',
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
