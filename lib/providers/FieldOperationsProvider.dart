import 'package:flutter/foundation.dart';

import '../models/FieldOperationsModel.dart';

import '../helpers/db_helper.dart';

class FieldOperationsProvider with ChangeNotifier {
  FieldOperationsModel _fieldOperationsModel = FieldOperationsModel();

  FieldOperationsModel get getFieldOperationsModel {
    FieldOperationsModel _newFieldOperationsModel = new FieldOperationsModel(
      dateOfLandPreparation: _fieldOperationsModel.dateOfLandPreparation,
      methodOfLandPreparation: _fieldOperationsModel.methodOfLandPreparation,
      dateOfPlanting: _fieldOperationsModel.dateOfPlanting,
      dateOfThinning: _fieldOperationsModel.dateOfThinning,
      dateOfFirstWeeding: _fieldOperationsModel.dateOfFirstWeeding,
      dateOfSecondWeeding: _fieldOperationsModel.dateOfSecondWeeding,
    );
    return _newFieldOperationsModel;
  }

  Future<void>? updateFieldOperationsModel(
      FieldOperationsModel fieldOperationsModel) async {
    _fieldOperationsModel = fieldOperationsModel;

    notifyListeners();

    await DBHelper.insert(
      'fieldOperations',
      {
        'id': fieldOperationsModel.id,
        'fieldId': fieldOperationsModel.fieldId,
        'dateOfLandPreparation':
            fieldOperationsModel.dateOfLandPreparation == null
                ? ''
                : fieldOperationsModel.dateOfLandPreparation!.toIso8601String(),
        'methodOfLandPreparation': fieldOperationsModel.methodOfLandPreparation,
        'dateOfPlanting': fieldOperationsModel.dateOfPlanting == null
            ? ''
            : fieldOperationsModel.dateOfPlanting!.toIso8601String(),
        'dateOfThinning': fieldOperationsModel.dateOfThinning == null
            ? ''
            : fieldOperationsModel.dateOfThinning!.toIso8601String(),
        'dateOfFirstWeeding': fieldOperationsModel.dateOfFirstWeeding == null
            ? ''
            : fieldOperationsModel.dateOfFirstWeeding!.toIso8601String(),
        'dateOfSecondWeeding': fieldOperationsModel.dateOfSecondWeeding == null
            ? ''
            : fieldOperationsModel.dateOfSecondWeeding!.toIso8601String(),
        'isUpToDateInServer': "No",
      },
    );
  }

  Future<void> fetchAndSetFieldOperationsModel() async {
    final dataList = await DBHelper.getData('fieldOperations');
    if (dataList.isEmpty) {
      _fieldOperationsModel = FieldOperationsModel();
    }
    final _updatedFieldOperationsModelMap = dataList[0];
    _fieldOperationsModel = FieldOperationsModel(
      id: _updatedFieldOperationsModelMap['id'],
      fieldId: _updatedFieldOperationsModelMap['fieldId'],
      dateOfLandPreparation:
          _updatedFieldOperationsModelMap['dateOfLandPreparation'] == ''
              ? null
              : DateTime.parse(
                  _updatedFieldOperationsModelMap['dateOfLandPreparation']),
      methodOfLandPreparation:
          _updatedFieldOperationsModelMap['methodOfLandPreparation'],
      dateOfPlanting: _updatedFieldOperationsModelMap['dateOfPlanting'] == ''
          ? null
          : DateTime.parse(_updatedFieldOperationsModelMap['dateOfPlanting']),
      dateOfThinning: _updatedFieldOperationsModelMap['dateOfThinning'] == ''
          ? null
          : DateTime.parse(_updatedFieldOperationsModelMap['dateOfThinning']),
      dateOfFirstWeeding:
          _updatedFieldOperationsModelMap['dateOfFirstWeeding'] == ''
              ? null
              : DateTime.parse(
                  _updatedFieldOperationsModelMap['dateOfFirstWeeding']),
      dateOfSecondWeeding:
          _updatedFieldOperationsModelMap['dateOfSecondWeeding'] == ''
              ? null
              : DateTime.parse(
                  _updatedFieldOperationsModelMap['dateOfSecondWeeding']),
      isUpToDateInServer: _updatedFieldOperationsModelMap['isUpToDateInServer'],
    );
    notifyListeners();
  }
}
