import 'package:flutter/foundation.dart';

import '../models/FertilizationModel.dart';

import '../helpers/db_helper.dart';
import '../helpers/id_generator_helper.dart';

class FertilizationProvider with ChangeNotifier {
  List<FertilizationModel> _fertilizationObjects = [
    FertilizationModel(id: IDGeneratorHelper.generateId(), season: '2020-2021'),
    FertilizationModel(id: IDGeneratorHelper.generateId(), season: '2021-2022'),
  ];

  List<FertilizationModel> get getFertilizationObjects {
    return [..._fertilizationObjects];
  }

  FertilizationModel findBySeason(String season) {
    return _fertilizationObjects
        .firstWhere((element) => element.season == season);
  }

  Future<void>? updateFertilizationObject(
      FertilizationModel updatedFertilizationObject) async {
    _fertilizationObjects[_fertilizationObjects.indexWhere(
            (element) => element.id == updatedFertilizationObject.id)] =
        updatedFertilizationObject;

    notifyListeners();

    DBHelper.insert(
      'fertilization',
      {
        'id': updatedFertilizationObject.id,
        'lastUpdated':
            updatedFertilizationObject.lastUpdated!.toIso8601String(),
        'season': updatedFertilizationObject.season,
        'typeOfFertilizer': updatedFertilizationObject.typeOfFertilizer,
        'nameOfFertilizer': updatedFertilizationObject.nameOfFertilizer,
        'quantityApplied': updatedFertilizationObject.quantityApplied,
        'timeOfApplication': updatedFertilizationObject.timeOfApplication ==
                null
            ? null
            : updatedFertilizationObject.timeOfApplication!.toIso8601String(),
        'isUpToDateInServer': updatedFertilizationObject.isUpToDateInServer,
      },
    );
  }

  Future<void> fetchAndSetFertilizationObjects() async {
    final dataList = await DBHelper.getData('fertilization');

    if (dataList.isEmpty) {
      _fertilizationObjects = [
        FertilizationModel(
            id: IDGeneratorHelper.generateId(), season: '2020-2021'),
        FertilizationModel(
            id: IDGeneratorHelper.generateId(), season: '2021-2022'),
      ];
      for (FertilizationModel fertObj in _fertilizationObjects) {
        DBHelper.insert(
          'fertilization',
          {
            'id': fertObj.id,
            'lastUpdated': fertObj.lastUpdated == null
                ? null
                : fertObj.lastUpdated!.toIso8601String(),
            'season': fertObj.season,
            'typeOfFertilizer': fertObj.typeOfFertilizer,
            'nameOfFertilizer': fertObj.nameOfFertilizer,
            'quantityApplied': fertObj.quantityApplied,
            'timeOfApplication': fertObj.timeOfApplication == null
                ? null
                : fertObj.timeOfApplication!.toIso8601String(),
            'isUpToDateInServer': fertObj.isUpToDateInServer,
          },
        );
      }
    } else {
      _fertilizationObjects = dataList
          .map(
            (fertilizationObjectMap) => FertilizationModel(
              id: fertilizationObjectMap['id'],
              lastUpdated: fertilizationObjectMap['lastUpdated'] == null
                  ? null
                  : DateTime.parse(
                      fertilizationObjectMap['lastUpdated'],
                    ),
              season: fertilizationObjectMap['season'],
              typeOfFertilizer: fertilizationObjectMap['typeOfFertilizer'],
              nameOfFertilizer: fertilizationObjectMap['nameOfFertilizer'],
              quantityApplied: fertilizationObjectMap['quantityApplied'],
              timeOfApplication:
                  fertilizationObjectMap['timeOfApplication'] == null
                      ? null
                      : DateTime.parse(
                          fertilizationObjectMap['timeOfApplication'],
                        ),
              isUpToDateInServer: fertilizationObjectMap['isUpToDateInServer'],
            ),
          )
          .toList();
    }
    notifyListeners();
  }
}
