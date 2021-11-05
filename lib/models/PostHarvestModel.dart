class PostHarvestModel {
  final String id;
  DateTime lastUpdated;
  final String plotId;
  double? yieldOfDriedCobs;
  String yieldOfDriedCobsComments;
  String grainHardness;
  String grainHardnessComments;
  double? yieldOfDriedPanicles;
  String yieldOfDriedPaniclesComments;
  double? yieldOfDriedHeads;
  String yieldOfDriedHeadsComments;
  double? yieldOfDriedPods;
  String yieldOfDriedPodsComments;
  double? grainsYield;
  String grainsYieldComments;
  String grainSizeAppreciation;
  String grainSizeAppreciationComments;
  String grainColourAppreciation;
  String grainColourAppreciationComments;
  String isUpToDateInServer;
  String existsInServer;

  PostHarvestModel({
    required this.id,
    required this.lastUpdated,
    required this.plotId,
    this.yieldOfDriedCobs,
    this.yieldOfDriedCobsComments = 'Blank',
    this.grainHardness = 'Blank',
    this.grainHardnessComments = 'Blank',
    this.yieldOfDriedPanicles,
    this.yieldOfDriedPaniclesComments = 'Blank',
    this.yieldOfDriedHeads,
    this.yieldOfDriedHeadsComments = 'Blank',
    this.yieldOfDriedPods,
    this.yieldOfDriedPodsComments = 'Blank',
    this.grainsYield,
    this.grainsYieldComments = 'Blank',
    this.grainSizeAppreciation = 'Blank',
    this.grainSizeAppreciationComments = 'Blank',
    this.grainColourAppreciation = 'Blank',
    this.grainColourAppreciationComments = 'Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
