import 'package:flutter/foundation.dart';

import '../models/FloweringModel.dart';

import '../helpers/db_helper.dart';

class FloweringProvider with ChangeNotifier {
  List<FloweringModel> _floweringObjectsList = [];

  List<FloweringModel> get getFloweringObjectsList {
    return [..._floweringObjectsList];
  }

  List<FloweringModel> get floweringObjectsToBeSynced {
    return _floweringObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String plotId) {
    final relevantList =
        _floweringObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  FloweringModel findByPlot(String plotId) {
    return _floweringObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updateFloweringObject(
    FloweringModel updatedFloweringObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _floweringObjectsList[_floweringObjectsList.indexWhere(
              (element) => element.id == updatedFloweringObject.id)] =
          updatedFloweringObject;
      notifyListeners();
    } else {
      _floweringObjectsList.add(updatedFloweringObject);
    }

    await DBHelper.insert(
      'flowering',
      {
        'id': updatedFloweringObject.id,
        'lastUpdated': updatedFloweringObject.lastUpdated.toIso8601String(),
        'plotId': updatedFloweringObject.plotId,
        'growingCycleAppreciation':
            updatedFloweringObject.growingCycleAppreciation,
        'growingCycleAppreciationComments':
            updatedFloweringObject.growingCycleAppreciationComments,
        'pestResistance': updatedFloweringObject.pestResistance,
        'pestResistanceComments': updatedFloweringObject.pestResistanceComments,
        'diseasesResistance': updatedFloweringObject.diseasesResistance,
        'diseasesResistanceComments':
            updatedFloweringObject.diseasesResistanceComments,
        'pestAndDiseasesResistance':
            updatedFloweringObject.pestAndDiseasesResistance,
        'pestAndDiseasesResistanceComments':
            updatedFloweringObject.pestAndDiseasesResistanceComments,
        'isUpToDateInServer': updatedFloweringObject.isUpToDateInServer,
        'existsInServer': updatedFloweringObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetFloweringObjects() async {
    final dataList = await DBHelper.getData('flowering');
    _floweringObjectsList = dataList
        .map(
          (floweringObject) => FloweringModel(
            id: floweringObject['id'],
            lastUpdated: DateTime.parse(floweringObject['lastUpdated']),
            plotId: floweringObject['plotId'],
            growingCycleAppreciation:
                floweringObject['growingCycleAppreciation'],
            growingCycleAppreciationComments:
                floweringObject['growingCycleAppreciationComments'],
            pestResistance: floweringObject['pestResistance'],
            pestResistanceComments: floweringObject['pestResistanceComments'],
            diseasesResistance: floweringObject['diseasesResistance'],
            diseasesResistanceComments:
                floweringObject['diseasesResistanceComments'],
            pestAndDiseasesResistance:
                floweringObject['pestAndDiseasesResistance'],
            pestAndDiseasesResistanceComments:
                floweringObject['pestAndDiseasesResistanceComments'],
            isUpToDateInServer: floweringObject['isUpToDateInServer'],
            existsInServer: floweringObject['existsInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
