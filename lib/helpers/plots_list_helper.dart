class PlotsListHelper {
  static List plotsListGenerator(lastVariety) {
    List plots = [];
    for (int i = 1; i <= lastVariety; i++) {
      String j = '1${i.toString().padLeft(2, '0')}';
      plots.add(j);
    }
    for (int i = 1; i <= lastVariety; i++) {
      String j = '2${i.toString().padLeft(2, '0')}';
      plots.add(j);
    }
    return plots;
  }
}
