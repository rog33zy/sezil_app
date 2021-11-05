class FieldOperationsModel {
  final String id;
  DateTime? lastUpdated;
  DateTime? dateOfLandPreparation;
  String methodOfLandPreparation;
  DateTime? dateOfPlanting;
  DateTime? dateOfThinning;
  DateTime? dateOfFirstWeeding;
  String firstWeedingIsManual;
  String firstWeedingHerbicideName;
  double? firstWeedingHerbicideQty;
  DateTime? dateOfPesticideApplication;
  String pesticideName;
  double? pesticideApplicationQty;
  DateTime? dateOfSecondWeeding;
  String secondWeedingIsManual;
  String secondWeedingHerbicideName;
  double? secondWeedingHerbicideQty;
  String isUpToDateInServer;
  String existsInServer;

  FieldOperationsModel({
    required this.id,
    this.lastUpdated,
    this.dateOfLandPreparation,
    this.methodOfLandPreparation = 'Blank',
    this.dateOfPlanting,
    this.dateOfThinning,
    this.dateOfFirstWeeding,
    this.firstWeedingIsManual = 'Blank',
    this.firstWeedingHerbicideName = 'Blank',
    this.firstWeedingHerbicideQty,
    this.dateOfPesticideApplication,
    this.pesticideName = 'Blank',
    this.pesticideApplicationQty,
    this.dateOfSecondWeeding,
    this.secondWeedingIsManual = 'Blank',
    this.secondWeedingHerbicideName = 'Blank',
    this.secondWeedingHerbicideQty,
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
