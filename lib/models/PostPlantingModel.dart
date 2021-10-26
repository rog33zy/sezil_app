class PostPlantingModel {
  final String id;
  DateTime? lastUpdated;
  final String plotId;
  String seedlingVigour;
  String seedlingVigourComments;
  int? plantStand;
  String plantStandComments;
  String pestResistance;
  String pestResistanceComments;
  String diseasesResistance;
  String diseasesResistanceComments;
  String isUpToDateInServer;

  PostPlantingModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.seedlingVigour = 'Blank',
    this.plantStand,
    this.seedlingVigourComments = 'Blank',
    this.plantStandComments = 'Blank',
    this.pestResistance = 'Blank',
    this.pestResistanceComments = 'Blank',
    this.diseasesResistance = 'Blank',
    this.diseasesResistanceComments = 'Blank',
    this.isUpToDateInServer = 'No',
  });
}
