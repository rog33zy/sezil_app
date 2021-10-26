import '../constants/Varieties.dart';

class NextFieldHelper {
  static String? findNextFieldPlotId(crop, plotId) {
    List allPlotIdsList = Varieties.varieties[crop] as List<dynamic>;
    int currentIndex =
        allPlotIdsList.indexWhere((element) => element == plotId);
    if (currentIndex != allPlotIdsList.length - 1) {
      return allPlotIdsList[currentIndex + 1];
    } else
      return '301';
  }
}
