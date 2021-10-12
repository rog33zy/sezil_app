class FloweringModel {
  final String id;
  final String fieldId;
  DateTime lastUpdated;
  final String crop;
  final String variety;
  final String plotId;
  final String trialId;
  String? growingCycleAppreciation;
  String? pestResistance;
  String? diseasesResistance;

  FloweringModel({
    required this.id,
    required this.fieldId,
    required this.lastUpdated,
    required this.crop,
    required this.variety,
    required this.plotId,
    required this.trialId,
    this.growingCycleAppreciation,
    this.pestResistance,
    this.diseasesResistance,
  });
}
