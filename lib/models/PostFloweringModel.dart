class PostFloweringModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String pestResistance;
  String pestResistanceComments;
  String diseasesResistance;
  String diseasesResistanceComments;
  String isUpToDateInServer;

  PostFloweringModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.pestResistance = 'Blank',
    this.pestResistanceComments = 'Blank',
    this.diseasesResistance = 'Blank',
    this.diseasesResistanceComments = 'Blank',
    this.isUpToDateInServer = 'No',
  });
}