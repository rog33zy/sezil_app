class FieldOperationsModel {
  final String id;
  final String fieldId;
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
    this.fieldId = '2021-3r45',
    this.lastUpdated,
    this.dateOfLandPreparation,
    this.methodOfLandPreparation = "Blank",
    this.dateOfPlanting,
    this.dateOfThinning,
    this.dateOfFirstWeeding,
    this.dateOfSecondWeeding,
    this.isUpToDateInServer = 'No',
  });
}
