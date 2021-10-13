import 'package:flutter/foundation.dart';

import '../models/FieldOperationsModel.dart';

import '../helpers/db_helper.dart';

class FieldOperationsProvider with ChangeNotifier {
  FieldOperationsModel _fieldOperationsObject = FieldOperationsModel();

  FieldOperationsModel get getFieldOperationsObject {
    FieldOperationsModel _newFieldOperationsModel = FieldOperationsModel(
      id: _fieldOperationsObject.id,
      lastUpdated: _fieldOperationsObject.lastUpdated,
      dateOfLandPreparation: _fieldOperationsObject.dateOfLandPreparation,
      methodOfLandPreparation: _fieldOperationsObject.methodOfLandPreparation,
      dateOfPlanting: _fieldOperationsObject.dateOfPlanting,
      dateOfThinning: _fieldOperationsObject.dateOfThinning,
      dateOfFirstWeeding: _fieldOperationsObject.dateOfFirstWeeding,
      dateOfSecondWeeding: _fieldOperationsObject.dateOfSecondWeeding,
      isUpToDateInServer: _fieldOperationsObject.isUpToDateInServer,
    );
    return _newFieldOperationsModel;
  }

  Future<void>? updateFieldOperationsObject(
      FieldOperationsModel updatedFieldOperationsObject) async {
    _fieldOperationsObject = updatedFieldOperationsObject;

    notifyListeners();

    await DBHelper.insert(
      'fieldOperations',
      {
        'id': updatedFieldOperationsObject.id,
        'lastUpdated': updatedFieldOperationsObject.lastUpdated == null
            ? 'NULL'
            : updatedFieldOperationsObject.lastUpdated!.toIso8601String(),
        'dateOfLandPreparation':
            updatedFieldOperationsObject.dateOfLandPreparation == null
                ? 'NULL'
                : updatedFieldOperationsObject.dateOfLandPreparation!
                    .toIso8601String(),
        'methodOfLandPreparation':
            updatedFieldOperationsObject.methodOfLandPreparation,
        'dateOfPlanting': updatedFieldOperationsObject.dateOfPlanting == null
            ? 'NULL'
            : updatedFieldOperationsObject.dateOfPlanting!.toIso8601String(),
        'dateOfThinning': updatedFieldOperationsObject.dateOfThinning == null
            ? 'NULL'
            : updatedFieldOperationsObject.dateOfThinning!.toIso8601String(),
        'dateOfFirstWeeding':
            updatedFieldOperationsObject.dateOfFirstWeeding == null
                ? 'NULL'
                : updatedFieldOperationsObject.dateOfFirstWeeding!
                    .toIso8601String(),
        'dateOfSecondWeeding':
            updatedFieldOperationsObject.dateOfSecondWeeding == null
                ? 'NULL'
                : updatedFieldOperationsObject.dateOfSecondWeeding!
                    .toIso8601String(),
        'isUpToDateInServer': "No",
      },
    );
  }

  Future<void> fetchAndSetFieldOperationsObject() async {
    final dataList = await DBHelper.getData('fieldOperations');
    if (dataList.isEmpty) {
      _fieldOperationsObject = FieldOperationsModel();
    } else {
      final _updatedFieldOperationsObjectMap = dataList[0];
      _fieldOperationsObject = FieldOperationsModel(
        id: _updatedFieldOperationsObjectMap['id'],
        dateOfLandPreparation:
            _updatedFieldOperationsObjectMap['dateOfLandPreparation'] == 'NULL'
                ? null
                : DateTime.parse(
                    _updatedFieldOperationsObjectMap['dateOfLandPreparation']),
        methodOfLandPreparation:
            _updatedFieldOperationsObjectMap['methodOfLandPreparation'],
        dateOfPlanting: _updatedFieldOperationsObjectMap['dateOfPlanting'] == 'NULL'
            ? null
            : DateTime.parse(
                _updatedFieldOperationsObjectMap['dateOfPlanting']),
        dateOfThinning: _updatedFieldOperationsObjectMap['dateOfThinning'] == 'NULL'
            ? null
            : DateTime.parse(
                _updatedFieldOperationsObjectMap['dateOfThinning']),
        dateOfFirstWeeding:
            _updatedFieldOperationsObjectMap['dateOfFirstWeeding'] == 'NULL'
                ? null
                : DateTime.parse(
                    _updatedFieldOperationsObjectMap['dateOfFirstWeeding']),
        dateOfSecondWeeding:
            _updatedFieldOperationsObjectMap['dateOfSecondWeeding'] == 'NULL'
                ? null
                : DateTime.parse(
                    _updatedFieldOperationsObjectMap['dateOfSecondWeeding']),
        isUpToDateInServer:
            _updatedFieldOperationsObjectMap['isUpToDateInServer'],
      );
    }
    notifyListeners();
  }
}
