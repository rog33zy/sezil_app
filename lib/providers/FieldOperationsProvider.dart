import 'package:flutter/foundation.dart';
import 'package:sezil_app/helpers/id_generator_helper.dart';

import '../models/FieldOperationsModel.dart';

import '../helpers/db_helper.dart';
import '../helpers/id_generator_helper.dart';

class FieldOperationsProvider with ChangeNotifier {
  FieldOperationsModel _fieldOperationsObject =
      FieldOperationsModel(id: IDGeneratorHelper.generateId());

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
            ? null
            : updatedFieldOperationsObject.lastUpdated!.toIso8601String(),
        'dateOfLandPreparation':
            updatedFieldOperationsObject.dateOfLandPreparation == null
                ? null
                : updatedFieldOperationsObject.dateOfLandPreparation!
                    .toIso8601String(),
        'methodOfLandPreparation':
            updatedFieldOperationsObject.methodOfLandPreparation,
        'dateOfPlanting': updatedFieldOperationsObject.dateOfPlanting == null
            ? null
            : updatedFieldOperationsObject.dateOfPlanting!.toIso8601String(),
        'dateOfThinning': updatedFieldOperationsObject.dateOfThinning == null
            ? null
            : updatedFieldOperationsObject.dateOfThinning!.toIso8601String(),
        'dateOfFirstWeeding':
            updatedFieldOperationsObject.dateOfFirstWeeding == null
                ? null
                : updatedFieldOperationsObject.dateOfFirstWeeding!
                    .toIso8601String(),
        'dateOfSecondWeeding':
            updatedFieldOperationsObject.dateOfSecondWeeding == null
                ? null
                : updatedFieldOperationsObject.dateOfSecondWeeding!
                    .toIso8601String(),
        'isUpToDateInServer': "No",
      },
    );
  }

  Future<void> fetchAndSetFieldOperationsObject() async {
    final dataList = await DBHelper.getData('fieldOperations');
    if (dataList.isEmpty) {
      _fieldOperationsObject =
          FieldOperationsModel(id: IDGeneratorHelper.generateId());
    } else {
      final _updatedMap = dataList[0];
      _fieldOperationsObject = FieldOperationsModel(
        id: _updatedMap['id'],
        lastUpdated: _updatedMap['lastUpdated'] == null
            ? null
            : DateTime.parse(_updatedMap['lastUpdated']),
        dateOfLandPreparation: _updatedMap['dateOfLandPreparation'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfLandPreparation']),
        methodOfLandPreparation: _updatedMap['methodOfLandPreparation'],
        dateOfPlanting: _updatedMap['dateOfPlanting'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfPlanting']),
        dateOfThinning: _updatedMap['dateOfThinning'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfThinning']),
        dateOfFirstWeeding: _updatedMap['dateOfFirstWeeding'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfFirstWeeding']),
        dateOfSecondWeeding: _updatedMap['dateOfSecondWeeding'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfSecondWeeding']),
        isUpToDateInServer: _updatedMap['isUpToDateInServer'],
      );
    }
    notifyListeners();
  }
}
