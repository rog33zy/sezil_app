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
        'lastUpdated': updatedFieldProfileObject.lastUpdated,
        'fieldSize': updatedFieldProfileObject.fieldSize,
        'soilType': updatedFieldProfileObject.soilType,
        'latitude': updatedFieldProfileObject.latitude,
        'longitude': updatedFieldProfileObject.longitude,
        'cropGrownPrevSeason': updatedFieldProfileObject.cropGrownPrevSeason,
        'cropGrownTwoSeasonsAgo':
            updatedFieldProfileObject.cropGrownTwoSeasonsAgo,
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
        lastUpdated: _updatedMap['lastUpdated'],
        fieldSize: _updatedMap['fieldSize'],
        soilType: _updatedMap['soilType'],
        latitude: _updatedMap['latitude'],
        longitude: _updatedMap['longitude'],
        cropGrownPrevSeason: _updatedMap['cropGrownPrevSeason'],
        cropGrownTwoSeasonsAgo: _updatedMap['cropGrownTwoSeasonsAgo'],
      );
    }
    notifyListeners();
  }
}
