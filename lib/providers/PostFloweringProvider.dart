import 'package:flutter/foundation.dart';

import '../models/PostFloweringModel.dart';

import '../helpers/db_helper.dart';

class PostFloweringProvider with ChangeNotifier {
  List<PostFloweringModel> _postFloweringObjectsList = [];

  List<PostFloweringModel> get getPostFloweringObjectsList {
    return [..._postFloweringObjectsList];
  }

  List<PostFloweringModel> get postFloweringObjectsToBeSynced {
    return _postFloweringObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String plotId) {
    final relevantList =
        _postFloweringObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  PostFloweringModel findByPlot(String plotId) {
    return _postFloweringObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updatePostFloweringObject(
    PostFloweringModel updatedPostFloweringObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _postFloweringObjectsList[_postFloweringObjectsList.indexWhere(
              (element) => element.id == updatedPostFloweringObject.id)] =
          updatedPostFloweringObject;
      notifyListeners();
    } else {
      _postFloweringObjectsList.add(updatedPostFloweringObject);
    }

    await DBHelper.insert(
      'postFlowering',
      {
        'id': updatedPostFloweringObject.id,
        'lastUpdated': updatedPostFloweringObject.lastUpdated.toIso8601String(),
        'plotId': updatedPostFloweringObject.plotId,
        'pestResistance': updatedPostFloweringObject.pestResistance,
        'pestResistanceComments':
            updatedPostFloweringObject.pestResistanceComments,
        'diseasesResistance': updatedPostFloweringObject.diseasesResistance,
        'diseasesResistanceComments':
            updatedPostFloweringObject.diseasesResistanceComments,
        'isUpToDateInServer': updatedPostFloweringObject.isUpToDateInServer,
        'existsInServer': updatedPostFloweringObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetPostFloweringObjects() async {
    final dataList = await DBHelper.getData('postFlowering');
    _postFloweringObjectsList = dataList
        .map(
          (postFloweringObject) => PostFloweringModel(
            id: postFloweringObject['id'],
            lastUpdated: DateTime.parse(postFloweringObject['lastUpdated']),
            plotId: postFloweringObject['plotId'],
            pestResistance: postFloweringObject['pestResistance'],
            pestResistanceComments:
                postFloweringObject['pestResistanceComments'],
            diseasesResistance: postFloweringObject['diseasesResistance'],
            diseasesResistanceComments:
                postFloweringObject['diseasesResistanceComments'],
            isUpToDateInServer: postFloweringObject['isUpToDateInServer'],
            existsInServer: postFloweringObject['existsInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
