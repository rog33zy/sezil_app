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
  String firstWeedingHerbicideQty;
  DateTime? dateOfPesticideApplication;
  String pesticideName;
  String pesticideApplicationQty;
  DateTime? dateOfSecondWeeding;
  String secondWeedingIsManual;
  String secondWeedingHerbicideName;
  String secondWeedingHerbicideQty;
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
    this.firstWeedingHerbicideQty='Blank',
    this.dateOfPesticideApplication,
    this.pesticideName = 'Blank',
    this.pesticideApplicationQty = 'Blank',
    this.dateOfSecondWeeding,
    this.secondWeedingIsManual = 'Blank',
    this.secondWeedingHerbicideName = 'Blank',
    this.secondWeedingHerbicideQty='Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
