class FieldOperationsModel {
  String id;
  String fieldId;
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
    this.dateOfLandPreparation,
    this.methodOfLandPreparation = "Blank",
    this.dateOfPlanting,
    this.dateOfThinning,
    this.dateOfFirstWeeding,
    this.dateOfSecondWeeding,
    this.isUpToDateInServer = 'No',
  });
}
