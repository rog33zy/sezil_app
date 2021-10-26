import 'package:flutter/foundation.dart';

import '../models/PostPlantingModel.dart';

import '../helpers/db_helper.dart';

class PostPlantingProvider with ChangeNotifier {
  List<PostPlantingModel> _postPlantingObjectsList = [];

  List<PostPlantingModel> get getPostPlantingObjectsList {
    return [..._postPlantingObjectsList];
  }

  bool isExisting(String plotId) {
    final relevantList =
        _postPlantingObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  PostPlantingModel findByPlot(String plotId) {
    return _postPlantingObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updatePostPlantingObject(
    PostPlantingModel updatedPostPlantingObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _postPlantingObjectsList[_postPlantingObjectsList.indexWhere(
              (element) => element.id == updatedPostPlantingObject.id)] =
          updatedPostPlantingObject;
      notifyListeners();
    } else {
      _postPlantingObjectsList.add(updatedPostPlantingObject);
    }

    await DBHelper.insert(
      'postPlanting',
      {
        'id': updatedPostPlantingObject.id,
        'lastUpdated': updatedPostPlantingObject.lastUpdated!.toIso8601String(),
        'plotId': updatedPostPlantingObject.plotId,
        'seedlingVigour': updatedPostPlantingObject.seedlingVigour,
        'seedlingVigourComments':
            updatedPostPlantingObject.seedlingVigourComments,
        'plantStand': updatedPostPlantingObject.plantStand,
        'plantStandComments': updatedPostPlantingObject.plantStandComments,
        'pestResistance': updatedPostPlantingObject.pestResistance,
        'pestResistanceComments':
            updatedPostPlantingObject.pestResistanceComments,
        'diseasesResistance': updatedPostPlantingObject.diseasesResistance,
        'diseasesResistanceComments':
            updatedPostPlantingObject.diseasesResistanceComments,
        'isUpToDateInServer': updatedPostPlantingObject.isUpToDateInServer,
      },
    );
  }

  Future<void> fetchAndSetPostPlantingObjects() async {
    final dataList = await DBHelper.getData('postPlanting');
    _postPlantingObjectsList = dataList
        .map(
          (postPlantingObject) => PostPlantingModel(
            id: postPlantingObject['id'],
            lastUpdated: DateTime.parse(postPlantingObject['lastUpdated']),
            plotId: postPlantingObject['plotId'],
            seedlingVigour: postPlantingObject['seedlingVigour'],
            seedlingVigourComments:
                postPlantingObject['seedlingVigourComments'],
            plantStand: postPlantingObject['plantStand'],
            plantStandComments: postPlantingObject['plantStandComments'],
            pestResistance: postPlantingObject['pestResistance'],
            pestResistanceComments:
                postPlantingObject['pestResistanceComments'],
            diseasesResistance: postPlantingObject['diseasesResistance'],
            diseasesResistanceComments:
                postPlantingObject['diseasesResistanceComments'],
            isUpToDateInServer: postPlantingObject['isUpToDateInServer'],
          ),
        )
        .toList();
  }
}
