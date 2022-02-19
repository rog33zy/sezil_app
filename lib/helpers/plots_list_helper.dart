class PlotsListHelper {
  static List plotsListGenerator(lastVariety, [String variety = ""]) {
    List plots = [];
    for (int i = 1; i <= lastVariety; i++) {
      String j = '0${i.toString().padLeft(2, '0')}';
      plots.add(j);
    }
    for (int i = 1; i <= lastVariety; i++) {
      String j = '1${i.toString().padLeft(2, '0')}';
      plots.add(j);
    }
    if (variety == "sorghum") {
      for (int i = 1; i <= lastVariety; i++) {
      String j = '2${i.toString().padLeft(2, '0')}';
      plots.add(j);
    }
    }
    return plots;
  }
}
