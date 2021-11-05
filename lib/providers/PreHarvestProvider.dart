import 'package:flutter/foundation.dart';

import '../models/PreHarvestModel.dart';

import '../helpers/db_helper.dart';

class PreHarvestProvider with ChangeNotifier {
  List<PreHarvestModel> _preHarvestObjectsList = [];

  List<PreHarvestModel> get getPreHarvestObjectsList {
    return [..._preHarvestObjectsList];
  }

  List<PreHarvestModel> get preHarvestObjectsToBeSynced {
    return _preHarvestObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String plotId) {
    final relevantList =
        _preHarvestObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  PreHarvestModel findByPlot(String plotId) {
    return _preHarvestObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updatePreHarvestObject(
    PreHarvestModel updatedPreHarvestObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _preHarvestObjectsList[_preHarvestObjectsList.indexWhere(
              (element) => element.id == updatedPreHarvestObject.id)] =
          updatedPreHarvestObject;
      notifyListeners();
    } else {
      _preHarvestObjectsList.add(updatedPreHarvestObject);
    }

    await DBHelper.insert(
      'preHarvest',
      {
        'id': updatedPreHarvestObject.id,
        'lastUpdated': updatedPreHarvestObject.lastUpdated.toIso8601String(),
        'plotId': updatedPreHarvestObject.plotId,
        'lodgingResistance': updatedPreHarvestObject.lodgingResistance,
        'lodgingResistanceComments':
            updatedPreHarvestObject.lodgingResistanceComments,
        'huskCover': updatedPreHarvestObject.huskCover,
        'huskCoverComments': updatedPreHarvestObject.huskCoverComments,
        'cobSize': updatedPreHarvestObject.cobSize,
        'cobSizeComments': updatedPreHarvestObject.cobSizeComments,
        'numberOfCobsPerPlant': updatedPreHarvestObject.numberOfCobsPerPlant,
        'numberOfCobsPerPlantComments':
            updatedPreHarvestObject.numberOfCobsPerPlantComments,
        'plantHeight': updatedPreHarvestObject.plantHeight,
        'plantHeightComments': updatedPreHarvestObject.plantHeightComments,
        'birdDamage': updatedPreHarvestObject.birdDamage,
        'birdDamageComments': updatedPreHarvestObject.birdDamageComments,
        'panicleAppreciation': updatedPreHarvestObject.panicleAppreciation,
        'panicleAppreciationComments':
            updatedPreHarvestObject.panicleAppreciationComments,
        'grainQualityAppreciation':
            updatedPreHarvestObject.grainQualityAppreciation,
        'grainQualityAppreciationComments':
            updatedPreHarvestObject.grainQualityAppreciationComments,
        'headSizeAppreciation': updatedPreHarvestObject.headSizeAppreciation,
        'headSizeAppreciationComments':
            updatedPreHarvestObject.headSizeAppreciationComments,
        'numberOfHeadsAppreciation':
            updatedPreHarvestObject.numberOfHeadsAppreciation,
        'numberOfHeadsAppreciationComments':
            updatedPreHarvestObject.numberOfHeadsAppreciationComments,
        'plantGrowthHabitAppreciation':
            updatedPreHarvestObject.plantGrowthHabitAppreciation,
        'plantGrowthHabitAppreciationComments':
            updatedPreHarvestObject.plantGrowthHabitAppreciationComments,
        'podLengthAppreciation': updatedPreHarvestObject.podLengthAppreciation,
        'podLengthAppreciationComments':
            updatedPreHarvestObject.podLengthAppreciationComments,
        'willingnessToCultivateNextSeason':
            updatedPreHarvestObject.willingnessToCultivateNextSeason,
        'willingnessToCultivateNextSeasonComments':
            updatedPreHarvestObject.willingnessToCultivateNextSeasonComments,
        'isUpToDateInServer': updatedPreHarvestObject.isUpToDateInServer,
        'existsInServer': updatedPreHarvestObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetPreHarvestObjects() async {
    final dataList = await DBHelper.getData('preHarvest');
    _preHarvestObjectsList = dataList
        .map(
          (preHarvestObject) => PreHarvestModel(
            id: preHarvestObject['id'],
            lastUpdated: DateTime.parse(preHarvestObject['lastUpdated']),
            plotId: preHarvestObject['plotId'],
            lodgingResistance: preHarvestObject['lodgingResistance'],
            lodgingResistanceComments:
                preHarvestObject['lodgingResistanceComments'],
            huskCover: preHarvestObject['huskCover'],
            huskCoverComments: preHarvestObject['huskCoverComments'],
            cobSize: preHarvestObject['cobSize'],
            cobSizeComments: preHarvestObject['cobSizeComments'],
            numberOfCobsPerPlant: preHarvestObject['numberOfCobsPerPlant'],
            numberOfCobsPerPlantComments:
                preHarvestObject['numberOfCobsPerPlantComments'],
            plantHeight: preHarvestObject['plantHeight'],
            plantHeightComments: preHarvestObject['plantHeightComments'],
            birdDamage: preHarvestObject['birdDamage'],
            birdDamageComments: preHarvestObject['birdDamageComments'],
            panicleAppreciation: preHarvestObject['panicleAppreciation'],
            panicleAppreciationComments:
                preHarvestObject['panicleAppreciationComments'],
            grainQualityAppreciation:
                preHarvestObject['grainQualityAppreciation'],
            grainQualityAppreciationComments:
                preHarvestObject['grainQualityAppreciationComments'],
            headSizeAppreciation: preHarvestObject['headSizeAppreciation'],
            headSizeAppreciationComments:
                preHarvestObject['headSizeAppreciationComments'],
            numberOfHeadsAppreciation:
                preHarvestObject['numberOfHeadsAppreciation'],
            numberOfHeadsAppreciationComments:
                preHarvestObject['numberOfHeadsAppreciationComments'],
            plantGrowthHabitAppreciation:
                preHarvestObject['plantGrowthHabitAppreciation'],
            plantGrowthHabitAppreciationComments:
                preHarvestObject['plantGrowthHabitAppreciationComments'],
            podLengthAppreciation: preHarvestObject['podLengthAppreciation'],
            podLengthAppreciationComments:
                preHarvestObject['podLengthAppreciationComments'],
            willingnessToCultivateNextSeason:
                preHarvestObject['willingnessToCultivateNextSeason'],
            willingnessToCultivateNextSeasonComments:
                preHarvestObject['willingnessToCultivateNextSeasonComments'],
            isUpToDateInServer: preHarvestObject['isUpToDateInServer'],
            existsInServer: preHarvestObject['existsInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
