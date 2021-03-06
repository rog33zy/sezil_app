import 'package:flutter/foundation.dart';

import '../models/FertilizationModel.dart';

import '../helpers/db_helper.dart';

class FertilizationProvider with ChangeNotifier {
  List<FertilizationModel> _fertilizationObjectsList = [];

  List<FertilizationModel> get getFertilizationObjectsList {
    return [..._fertilizationObjectsList];
  }

  List<FertilizationModel> get fertilizationObjectsToBeSynced {
    return _fertilizationObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String season, String typeOfDressing) {
    final relevantList = _fertilizationObjectsList.where(
      (element) =>
          element.season == season && element.typeOfDressing == typeOfDressing,
    );
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  FertilizationModel findFertObject(String season, String typeOfDressing) {
    return _fertilizationObjectsList.firstWhere(
      (element) =>
          element.season == season && element.typeOfDressing == typeOfDressing,
    );
  }

  Future<void> updateFertilizationObject(
      FertilizationModel updatedFertilizationObject, bool isExisiting) async {
    if (isExisiting) {
      _fertilizationObjectsList[_fertilizationObjectsList.indexWhere(
              (element) => element.id == updatedFertilizationObject.id)] =
          updatedFertilizationObject;

      notifyListeners();
    } else {
      _fertilizationObjectsList.add(updatedFertilizationObject);
    }

    await DBHelper.insert(
      'fertilization',
      {
        'id': updatedFertilizationObject.id,
        'lastUpdated':
            updatedFertilizationObject.lastUpdated!.toIso8601String(),
        'season': updatedFertilizationObject.season,
        'typeOfDressing': updatedFertilizationObject.typeOfDressing,
        'nameOfOrganicFertilizer':
            updatedFertilizationObject.nameOfOrganicFertilizer,
        'nameOfSyntheticFertilizer':
            updatedFertilizationObject.nameOfSyntheticFertilizer,
        'quantityApplied': updatedFertilizationObject.quantityApplied,
        'timeOfApplication': updatedFertilizationObject.timeOfApplication ==
                null
            ? null
            : updatedFertilizationObject.timeOfApplication!.toIso8601String(),
        'isUpToDateInServer': updatedFertilizationObject.isUpToDateInServer,
        'existsInServer': updatedFertilizationObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetFertilizationObjects() async {
    final dataList = await DBHelper.getData('fertilization');
    _fertilizationObjectsList = dataList
        .map(
          (fertilizationObjectMap) => FertilizationModel(
            id: fertilizationObjectMap['id'],
            lastUpdated: fertilizationObjectMap['lastUpdated'] == null
                ? null
                : DateTime.parse(
                    fertilizationObjectMap['lastUpdated'],
                  ),
            season: fertilizationObjectMap['season'],
            typeOfDressing: fertilizationObjectMap['typeOfDressing'],
            nameOfOrganicFertilizer:
                fertilizationObjectMap['nameOfOrganicFertilizer'],
            nameOfSyntheticFertilizer:
                fertilizationObjectMap['nameOfSyntheticFertilizer'],
            quantityApplied: fertilizationObjectMap['quantityApplied'],
            timeOfApplication:
                fertilizationObjectMap['timeOfApplication'] == null
                    ? null
                    : DateTime.parse(
                        fertilizationObjectMap['timeOfApplication'],
                      ),
            isUpToDateInServer: fertilizationObjectMap['isUpToDateInServer'],
            existsInServer: fertilizationObjectMap['existsInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
