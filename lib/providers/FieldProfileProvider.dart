import 'package:flutter/foundation.dart';

import '../models/FieldProfileModel.dart';

import '../helpers/db_helper.dart';
import '../helpers/id_generator_helper.dart';

class FieldProfileProvider with ChangeNotifier {
  FieldProfileModel _fieldProfileObject = FieldProfileModel(
    id: IDGeneratorHelper.generateId(),
  );

  FieldProfileModel get getFieldProfileObject {
    FieldProfileModel _newFieldProfileObject = FieldProfileModel(
      id: _fieldProfileObject.id,
      lastUpdated: _fieldProfileObject.lastUpdated,
      fieldSize: _fieldProfileObject.fieldSize,
      soilType: _fieldProfileObject.soilType,
      latitude: _fieldProfileObject.latitude,
      longitude: _fieldProfileObject.longitude,
      cropGrownPrevSeason: _fieldProfileObject.cropGrownPrevSeason,
      cropGrownTwoSeasonsAgo: _fieldProfileObject.cropGrownTwoSeasonsAgo,
      prevSeasonWeedingManual: _fieldProfileObject.prevSeasonWeedingManual,
      prevSeasonWeedingChemicalName:
          _fieldProfileObject.prevSeasonWeedingChemicalName,
      isUpToDateInServer: _fieldProfileObject.isUpToDateInServer,
      existsInServer: _fieldProfileObject.existsInServer,
    );
    return _newFieldProfileObject;
  }

  Future<void>? updateFieldProfileObject(
      FieldProfileModel updatedFieldProfileObject) async {
    _fieldProfileObject = updatedFieldProfileObject;

    notifyListeners();

    await DBHelper.insert(
      'fieldProfile',
      {
        'id': updatedFieldProfileObject.id,
        'lastUpdated': updatedFieldProfileObject.lastUpdated!.toIso8601String(),
        'fieldSize': updatedFieldProfileObject.fieldSize,
        'soilType': updatedFieldProfileObject.soilType,
        'latitude': updatedFieldProfileObject.latitude,
        'longitude': updatedFieldProfileObject.longitude,
        'cropGrownPrevSeason': updatedFieldProfileObject.cropGrownPrevSeason,
        'cropGrownTwoSeasonsAgo':
            updatedFieldProfileObject.cropGrownTwoSeasonsAgo,
        'prevSeasonWeedingManual':
            updatedFieldProfileObject.prevSeasonWeedingManual,
        'prevSeasonWeedingChemicalName':
            updatedFieldProfileObject.prevSeasonWeedingChemicalName,
        'isUpToDateInServer': updatedFieldProfileObject.isUpToDateInServer,
        'existsInServer': updatedFieldProfileObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetFieldProfileObject() async {
    final dataList = await DBHelper.getData('fieldProfile');
    if (dataList.isEmpty) {
      _fieldProfileObject = FieldProfileModel(
        id: IDGeneratorHelper.generateId(),
      );
    } else {
      final _updatedMap = dataList[0];
      _fieldProfileObject = FieldProfileModel(
        id: _updatedMap['id'],
        lastUpdated: DateTime.parse(_updatedMap['lastUpdated']),
        fieldSize: _updatedMap['fieldSize'],
        soilType: _updatedMap['soilType'],
        latitude: _updatedMap['latitude'],
        longitude: _updatedMap['longitude'],
        cropGrownPrevSeason: _updatedMap['cropGrownPrevSeason'],
        cropGrownTwoSeasonsAgo: _updatedMap['cropGrownTwoSeasonsAgo'],
        prevSeasonWeedingManual: _updatedMap['prevSeasonWeedingManual'],
        prevSeasonWeedingChemicalName:
            _updatedMap['prevSeasonWeedingChemicalName'],
        isUpToDateInServer: _updatedMap['isUpToDateInServer'],
        existsInServer: _updatedMap['existsInServer'],
      );
    }
    notifyListeners();
  }
}
