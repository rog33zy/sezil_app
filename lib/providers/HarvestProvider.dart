import 'package:flutter/foundation.dart';

import '../models/HarvestModel.dart';

import '../helpers/db_helper.dart';

class HarvestProvider with ChangeNotifier {
  List<HarvestModel> _harvestObjectsList = [];

  List<HarvestModel> get getHarvestObjectsList {
    return [..._harvestObjectsList];
  }

  List<HarvestModel> get harvestObjectsToBeSynced {
    return _harvestObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String plotId) {
    final relevantList =
        _harvestObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  HarvestModel findByPlot(String plotId) {
    return _harvestObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updateHarvestObject(
    HarvestModel updatedHarvestObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _harvestObjectsList[_harvestObjectsList
              .indexWhere((element) => element.id == updatedHarvestObject.id)] =
          updatedHarvestObject;
      notifyListeners();
    } else {
      _harvestObjectsList.add(updatedHarvestObject);
    }

    await DBHelper.insert(
      'harvest',
      {
        'id': updatedHarvestObject.id,
        'lastUpdated': updatedHarvestObject.lastUpdated.toIso8601String(),
        'plotId': updatedHarvestObject.plotId,
        'harvestDate': updatedHarvestObject.harvestDate == null
            ? null
            : updatedHarvestObject.harvestDate!.toIso8601String(),
        'numberOfPlants': updatedHarvestObject.numberOfPlants,
        'numberOfPlantsComments': updatedHarvestObject.numberOfPlantsComments,
        'numberOfHarvestedCobs': updatedHarvestObject.numberOfHarvestedCobs,
        'numberOfHarvestedCobsComments':
            updatedHarvestObject.numberOfHarvestedCobsComments,
        'yieldOfHarvestedCobs': updatedHarvestObject.yieldOfHarvestedCobs,
        'yieldOfHarvestedCobsComments':
            updatedHarvestObject.yieldOfHarvestedCobsComments,
        'numberOfHarvestedPanicles':
            updatedHarvestObject.numberOfHarvestedPanicles,
        'numberOfHarvestedPaniclesComments':
            updatedHarvestObject.numberOfHarvestedPaniclesComments,
        'yieldOfHarvestedPanicles':
            updatedHarvestObject.yieldOfHarvestedPanicles,
        'yieldOfHarvestedPaniclesComments':
            updatedHarvestObject.yieldOfHarvestedPaniclesComments,
        'numberOfHarvestedHeads': updatedHarvestObject.numberOfHarvestedHeads,
        'numberOfHarvestedHeadsComments':
            updatedHarvestObject.numberOfHarvestedHeadsComments,
        'yieldOfHarvestedHeads': updatedHarvestObject.yieldOfHarvestedHeads,
        'yieldOfHarvestedHeadsComments':
            updatedHarvestObject.yieldOfHarvestedHeadsComments,
        'numberOfHarvestedPods': updatedHarvestObject.numberOfHarvestedPods,
        'numberOfHarvestedPodsComments':
            updatedHarvestObject.numberOfHarvestedPodsComments,
        'yieldOfHarvestedPods': updatedHarvestObject.yieldOfHarvestedPods,
        'yieldOfHarvestedPodsComments':
            updatedHarvestObject.yieldOfHarvestedPodsComments,
        'isUpToDateInServer': updatedHarvestObject.isUpToDateInServer,
      },
    );
  }

  Future<void> fetchAndSetHarvestObjects() async {
    final dataList = await DBHelper.getData('harvest');
    _harvestObjectsList = dataList
        .map(
          (harvestObject) => HarvestModel(
            id: harvestObject['id'],
            lastUpdated: DateTime.parse(harvestObject['lastUpdated']),
            plotId: harvestObject['plotId'],
            harvestDate: harvestObject['harvestDate'] == null
                ? null
                : DateTime.parse(harvestObject['harvestDate']),
            numberOfPlants: harvestObject['numberOfPlants'],
            numberOfPlantsComments: harvestObject['numberOfPlantsComments'],
            numberOfHarvestedCobs: harvestObject['numberOfHarvestedCobs'],
            numberOfHarvestedCobsComments:
                harvestObject['numberOfHarvestedCobsComments'],
            yieldOfHarvestedCobs: harvestObject['yieldOfHarvestedCobs'],
            yieldOfHarvestedCobsComments:
                harvestObject['yieldOfHarvestedCobsComments'],
            numberOfHarvestedPanicles:
                harvestObject['numberOfHarvestedPanicles'],
            numberOfHarvestedPaniclesComments:
                harvestObject['numberOfHarvestedPaniclesComments'],
            yieldOfHarvestedPanicles: harvestObject['yieldOfHarvestedPanicles'],
            yieldOfHarvestedPaniclesComments:
                harvestObject['yieldOfHarvestedPaniclesComments'],
            numberOfHarvestedHeads: harvestObject['numberOfHarvestedHeads'],
            numberOfHarvestedHeadsComments:
                harvestObject['numberOfHarvestedHeadsComments'],
            yieldOfHarvestedHeads: harvestObject['yieldOfHarvestedHeads'],
            yieldOfHarvestedHeadsComments:
                harvestObject['yieldOfHarvestedHeadsComments'],
            numberOfHarvestedPods: harvestObject['numberOfHarvestedPods'],
            numberOfHarvestedPodsComments:
                harvestObject['numberOfHarvestedPodsComments'],
            yieldOfHarvestedPods: harvestObject['yieldOfHarvestedPods'],
            yieldOfHarvestedPodsComments:
                harvestObject['yieldOfHarvestedPodsComments'],
            isUpToDateInServer: harvestObject['isUpToDateInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
