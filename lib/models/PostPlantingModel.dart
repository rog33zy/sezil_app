class PostPlantingModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String? seedlingVigour;
  String? plantStand;

  PostPlantingModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.seedlingVigour,
    this.plantStand,
  });
}
