class FloweringModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String growingCycleAppreciation;
  String growingCycleAppreciationComments;
  String pestResistance;
  String pestResistanceComments;
  String diseasesResistance;
  String diseasesResistanceComments;
  String isUpToDateInServer;
  String existsInServer;

  FloweringModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.growingCycleAppreciation = 'Blank',
    this.growingCycleAppreciationComments = 'Blank',
    this.pestResistance = 'Blank',
    this.pestResistanceComments = 'Blank',
    this.diseasesResistance = 'Blank',
    this.diseasesResistanceComments = 'Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
