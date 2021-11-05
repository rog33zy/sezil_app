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
  String grainSize;
  String grainSizeComments;
  String grainColour;
  String grainColourComments;
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
    this.grainSize = 'Blank',
    this.grainSizeComments = 'Blank',
    this.grainColour = 'Blank',
    this.grainColourComments = 'Blank',
    this.isUpToDateInServer = 'No',
    this.existsInServer = 'No',
  });
}
