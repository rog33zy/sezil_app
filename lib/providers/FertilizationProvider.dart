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
        'timeOfApplication':
            updatedFertilizationObject.timeOfApplication!.toIso8601String(),
        'isUpToDateInServer': updatedFertilizationObject.isUpToDateInServer,
      },
    );
  }

  Future<void> fetchAndSetFertilizationObjects() async {
    final dataList = await DBHelper.getData('fertilization');
    print(dataList);
    if (dataList.isEmpty) {
      _fertilizationObjects = [
        FertilizationModel(
            id: IDGeneratorHelper.generateId(), season: '2020-2021'),
        FertilizationModel(
            id: IDGeneratorHelper.generateId(), season: '2021-2022'),
      ];
    } else {
      _fertilizationObjects = dataList
          .map(
            (e) => FertilizationModel(
              id: e['id'],
              lastUpdated: e['lastUpdated'],
              season: e['season'],
              typeOfFertilizer: e['typeOfFertilizer'],
              nameOfFertilizer: e['nameOfFertilizer'],
              quantityApplied: e['quantityApplied'],
              timeOfApplication: e['timeOfApplication'],
              isUpToDateInServer: e['isUpToDateInServer'],
            ),
          )
          .toList();
    }
    notifyListeners();
  }
}
