class FloweringModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  String? growingCycleAppreciation;
  String? pestResistance;
  String? diseasesResistance;

  FloweringModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.growingCycleAppreciation,
    this.pestResistance,
    this.diseasesResistance,
  });
}
