class PostPlantingModel {
  final String id;
  final String fieldId;
  DateTime lastUpdated;
  final String crop;
  final String variety;
  final String plotId;
  final String trialId;
  String? seedlingVigour;
  String? plantStand;

  PostPlantingModel({
    required this.id,
    required this.fieldId,
    required this.lastUpdated,
    required this.crop,
    required this.variety,
    required this.plotId,
    required this.trialId,
    this.seedlingVigour,
    this.plantStand,
  });
}
