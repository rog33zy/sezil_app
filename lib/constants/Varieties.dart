import '../helpers/plots_list_helper.dart';

class Varieties {
  static final varieties = {
    'Maize': PlotsListHelper.plotsListGenerator(24),
    'Sorghum': PlotsListHelper.plotsListGenerator(8, "sorghum"),
    'Sunflower': PlotsListHelper.plotsListGenerator(16),
    'Beans': PlotsListHelper.plotsListGenerator(24),
  };
}
