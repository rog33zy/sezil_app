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
      firstWeedingIsManual: _fieldOperationsObject.firstWeedingIsManual,
      firstWeedingHerbicideName:
          _fieldOperationsObject.firstWeedingHerbicideName,
      firstWeedingHerbicideQty: _fieldOperationsObject.firstWeedingHerbicideQty,
      dateOfPesticideApplication:
          _fieldOperationsObject.dateOfPesticideApplication,
      pesticideName: _fieldOperationsObject.pesticideName,
      pesticideApplicationQty: _fieldOperationsObject.pesticideApplicationQty,
      dateOfSecondWeeding: _fieldOperationsObject.dateOfSecondWeeding,
      secondWeedingIsManual: _fieldOperationsObject.secondWeedingIsManual,
      secondWeedingHerbicideName:
          _fieldOperationsObject.secondWeedingHerbicideName,
      secondWeedingHerbicideQty:
          _fieldOperationsObject.secondWeedingHerbicideQty,
      isUpToDateInServer: _fieldOperationsObject.isUpToDateInServer,
      existsInServer: _fieldOperationsObject.existsInServer,
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
        'firstWeedingIsManual':
            updatedFieldOperationsObject.firstWeedingIsManual,
        'firstWeedingHerbicideName':
            updatedFieldOperationsObject.firstWeedingHerbicideName,
        'firstWeedingHerbicideQty':
            updatedFieldOperationsObject.firstWeedingHerbicideQty,
        'dateOfPesticideApplication':
            updatedFieldOperationsObject.dateOfPesticideApplication == null
                ? null
                : updatedFieldOperationsObject.dateOfPesticideApplication!
                    .toIso8601String(),
        'pesticideName': updatedFieldOperationsObject.pesticideName,
        'pesticideApplicationQty':
            updatedFieldOperationsObject.pesticideApplicationQty,
        'dateOfSecondWeeding':
            updatedFieldOperationsObject.dateOfSecondWeeding == null
                ? null
                : updatedFieldOperationsObject.dateOfSecondWeeding!
                    .toIso8601String(),
        'secondWeedingIsManual':
            updatedFieldOperationsObject.secondWeedingIsManual,
        'secondWeedingHerbicideName':
            updatedFieldOperationsObject.secondWeedingHerbicideName,
        'secondWeedingHerbicideQty':
            updatedFieldOperationsObject.secondWeedingHerbicideQty,
        'isUpToDateInServer': 'No',
        'existsInServer': updatedFieldOperationsObject.existsInServer,
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
        firstWeedingIsManual: _updatedMap['firstWeedingIsManual'],
        firstWeedingHerbicideName: _updatedMap['firstWeedingHerbicideName'],
        firstWeedingHerbicideQty: _updatedMap['firstWeedingHerbicideQty'],
        dateOfPesticideApplication:
            _updatedMap['dateOfPesticideApplication'] == null
                ? null
                : _updatedMap['dateOfPesticideApplication'],
        pesticideName: _updatedMap['pesticideName'],
        pesticideApplicationQty: _updatedMap['pesticideApplicationQty'],
        dateOfSecondWeeding: _updatedMap['dateOfSecondWeeding'] == null
            ? null
            : DateTime.parse(_updatedMap['dateOfSecondWeeding']),
        secondWeedingIsManual: _updatedMap['secondWeedingIsManual'],
        secondWeedingHerbicideName: _updatedMap['secondWeedingHerbicideName'],
        secondWeedingHerbicideQty: _updatedMap['secondWeedingHerbicideQty'],
        isUpToDateInServer: _updatedMap['isUpToDateInServer'],
        existsInServer: _updatedMap['existsInServer'],
      );
    }
    notifyListeners();
  }
}
