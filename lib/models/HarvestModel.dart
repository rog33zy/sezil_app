class HarvestModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  DateTime? harvestDate;
  int? numberOfPlants;
  String numberOfPlantsComments;
  int? numberOfHarvestedCobs;
  String numberOfHarvestedCobsComments;
  double? yieldOfHarvestedCobs;
  String yieldOfHarvestedCobsComments;
  int? numberOfHarvestedPanicles;
  String numberOfHarvestedPaniclesComments;
  double? yieldOfHarvestedPanicles;
  String yieldOfHarvestedPaniclesComments;
  int? numberOfHarvestedHeads;
  String numberOfHarvestedHeadsComments;
  double? yieldOfHarvestedHeads;
  String yieldOfHarvestedHeadsComments;
  int? numberOfHarvestedPods;
  String numberOfHarvestedPodsComments;
  double? yieldOfHarvestedPods;
  String yieldOfHarvestedPodsComments;
  String isUpToDateInServer;

  HarvestModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.harvestDate,
    this.numberOfPlants,
    this.numberOfPlantsComments = 'Blank',
    this.numberOfHarvestedCobs,
    this.numberOfHarvestedCobsComments = 'Blank',
    this.yieldOfHarvestedCobs,
    this.yieldOfHarvestedCobsComments = 'Blank',
    this.numberOfHarvestedPanicles,
    this.numberOfHarvestedPaniclesComments = 'Blank',
    this.yieldOfHarvestedPanicles,
    this.yieldOfHarvestedPaniclesComments = 'Blank',
    this.numberOfHarvestedHeads,
    this.numberOfHarvestedHeadsComments = 'Blank',
    this.yieldOfHarvestedHeads,
    this.yieldOfHarvestedHeadsComments = 'Blank',
    this.numberOfHarvestedPods,
    this.numberOfHarvestedPodsComments = 'Blank',
    this.yieldOfHarvestedPods,
    this.yieldOfHarvestedPodsComments = 'Blank',
    this.isUpToDateInServer = 'No',
  });
}
