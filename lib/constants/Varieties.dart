import '../helpers/plots_list_helper.dart';

class Varieties {
  static final varieties = {
    'Maize': PlotsListHelper.plotsListGenerator(22),
    'Sorghum': PlotsListHelper.plotsListGenerator(12),
    'Sunflower': PlotsListHelper.plotsListGenerator(15),
    'Beans': PlotsListHelper.plotsListGenerator(27),
  };
}
