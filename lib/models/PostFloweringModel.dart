class PostFloweringModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String pestResistance;
  String pestResistanceComments;
  String diseasesResistance;
  String diseasesResistanceComments;
  String pestAndDiseasesResistance;
  String pestAndDiseasesResistanceComments;
  String droughtTolerance;
  String droughtToleranceComments;
  String isUpToDateInServer;
  String existsInServer;

  PostFloweringModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.pestResistance = 'Blank',
    this.pestResistanceComments = 'Blank',
    this.diseasesResistance = 'Blank',
    this.diseasesResistanceComments = 'Blank',
    this.pestAndDiseasesResistance = 'Blank',
    this.pestAndDiseasesResistanceComments = 'Blank',
    this.droughtTolerance = 'Blank',
    this.droughtToleranceComments = 'Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
