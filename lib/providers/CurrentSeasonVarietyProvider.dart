import 'package:flutter/foundation.dart';

import '../models/CurrentSeasonVarietyModel.dart';

import '../helpers/db_helper.dart';
import '../helpers/id_generator_helper.dart';

class CurrentSeasonVarietyProvider with ChangeNotifier {
  CurrentSeasonVarietyModel _currentSeasonVarietyObject =
      CurrentSeasonVarietyModel(
    id: IDGeneratorHelper.generateId(),
  );

  CurrentSeasonVarietyModel get getCurrentSeasonVarietyObject {
    CurrentSeasonVarietyModel _newCurrentSeasonVarietyObject =
        CurrentSeasonVarietyModel(
      id: _currentSeasonVarietyObject.id,
      lastUpdated: _currentSeasonVarietyObject.lastUpdated,
      varietyName: _currentSeasonVarietyObject.varietyName,
      previousSeasonHarvest: _currentSeasonVarietyObject.previousSeasonHarvest,
      previousSeasonHectarage:
          _currentSeasonVarietyObject.previousSeasonHectarage,
      sourceOfSeed: _currentSeasonVarietyObject.sourceOfSeed,
      numberOfYearsGrown: _currentSeasonVarietyObject.numberOfYearsGrown,
      percentFarmersGrowingVariety:
          _currentSeasonVarietyObject.percentFarmersGrowingVariety,
    );
    return _newCurrentSeasonVarietyObject;
  }

  Future<void>? updateCurrentSeasonVarietyObject(
      CurrentSeasonVarietyModel updatedCurrentSeasonVarietyObject) async {
    _currentSeasonVarietyObject = updatedCurrentSeasonVarietyObject;

    notifyListeners();

    await DBHelper.insert(
      'currentSeasonVariety',
      {
        'id': updatedCurrentSeasonVarietyObject.id,
        'lastUpdated': updatedCurrentSeasonVarietyObject.lastUpdated == null
            ? null
            : updatedCurrentSeasonVarietyObject.lastUpdated!.toIso8601String(),
        'varietyName': updatedCurrentSeasonVarietyObject.varietyName,
        'previousSeasonHarvest':
            updatedCurrentSeasonVarietyObject.previousSeasonHarvest,
        'previousSeasonHectarage':
            updatedCurrentSeasonVarietyObject.previousSeasonHectarage,
        'sourceOfSeed': updatedCurrentSeasonVarietyObject.sourceOfSeed,
        'numberOfYearsGrown':
            updatedCurrentSeasonVarietyObject.numberOfYearsGrown,
        'percentFarmersGrowingVariety':
            updatedCurrentSeasonVarietyObject.percentFarmersGrowingVariety,
        'isUpToDateInServer':
            updatedCurrentSeasonVarietyObject.isUpToDateInServer,
      },
    );
  }

  Future<void> fetchAndSetCurrentSeasonVarietyObject() async {
    final dataList = await DBHelper.getData('currentSeasonVariety');
    if (dataList.isEmpty) {
      _currentSeasonVarietyObject = CurrentSeasonVarietyModel(
        id: IDGeneratorHelper.generateId(),
      );
    } else {
      final _updatedMap = dataList[0];
      _currentSeasonVarietyObject = CurrentSeasonVarietyModel(
        id: _updatedMap['id'],
        lastUpdated: DateTime.parse(_updatedMap['lastUpdated']),
        varietyName: _updatedMap['varietyName'],
        previousSeasonHarvest: _updatedMap['previousSeasonHarvest'],
        previousSeasonHectarage: _updatedMap['previousSeasonHectarage'],
        sourceOfSeed: _updatedMap['sourceOfSeed'],
        numberOfYearsGrown: _updatedMap['numberOfYearsGrown'],
        percentFarmersGrowingVariety:
            _updatedMap['percentFarmersGrowingVariety'],
        isUpToDateInServer: _updatedMap['isUpToDateInServer'],
      );
    }
    notifyListeners();
  }
}
