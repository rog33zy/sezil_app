class PostPlantingModel {
  final String id;
  DateTime? lastUpdated;
  final String plotId;
  String seedlingVigour;
  String seedlingVigourComments;
  int? plantStand;
  String plantStandComments;
  String isUpToDateInServer;

  PostPlantingModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.seedlingVigour = 'Blank',
    this.plantStand,
    this.seedlingVigourComments = 'Blank',
    this.plantStandComments = 'Blank',
    this.isUpToDateInServer = 'No',
  });
}
