import 'package:flutter/foundation.dart';

import '../models/PostHarvestModel.dart';

import '../helpers/db_helper.dart';

class PostHarvestProvider with ChangeNotifier {
  List<PostHarvestModel> _postHarvestObjectsList = [];

  List<PostHarvestModel> get getPostHarvestObjectsList {
    return [..._postHarvestObjectsList];
  }

  List<PostHarvestModel> get postHarvestObjectsToBeSynced {
    return _postHarvestObjectsList
        .where(
          (element) => element.isUpToDateInServer == 'No',
        )
        .toList();
  }

  bool isExisting(String plotId) {
    final relevantList =
        _postHarvestObjectsList.where((element) => element.plotId == plotId);
    if (relevantList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  PostHarvestModel findByPlot(String plotId) {
    return _postHarvestObjectsList
        .firstWhere((element) => element.plotId == plotId);
  }

  Future<void> updatePostHarvestObject(
    PostHarvestModel updatedPostHarvestObject,
    bool isExisting,
  ) async {
    if (isExisting) {
      _postHarvestObjectsList[_postHarvestObjectsList.indexWhere(
              (element) => element.id == updatedPostHarvestObject.id)] =
          updatedPostHarvestObject;
      notifyListeners();
    } else {
      _postHarvestObjectsList.add(updatedPostHarvestObject);
    }

    await DBHelper.insert(
      'postHarvest',
      {
        'id': updatedPostHarvestObject.id,
        'lastUpdated': updatedPostHarvestObject.lastUpdated.toIso8601String(),
        'plotId': updatedPostHarvestObject.plotId,
        'yieldOfDriedCobs': updatedPostHarvestObject.yieldOfDriedCobs,
        'yieldOfDriedCobsComments':
            updatedPostHarvestObject.yieldOfDriedCobsComments,
        'grainHardness': updatedPostHarvestObject.grainHardness,
        'grainHardnessComments': updatedPostHarvestObject.grainHardnessComments,
        'yieldOfDriedPanicles': updatedPostHarvestObject.yieldOfDriedPanicles,
        'yieldOfDriedPaniclesComments':
            updatedPostHarvestObject.yieldOfDriedPaniclesComments,
        'yieldOfDriedHeads': updatedPostHarvestObject.yieldOfDriedHeads,
        'yieldOfDriedHeadsComments':
            updatedPostHarvestObject.yieldOfDriedHeadsComments,
        'yieldOfDriedPods': updatedPostHarvestObject.yieldOfDriedPods,
        'yieldOfDriedPodsComments':
            updatedPostHarvestObject.yieldOfDriedPodsComments,
        'grainsYield': updatedPostHarvestObject.grainsYield,
        'grainsYieldComments': updatedPostHarvestObject.grainsYieldComments,
        'grainSizeAppreciation': updatedPostHarvestObject.grainSizeAppreciation,
        'grainSizeAppreciationComments':
            updatedPostHarvestObject.grainSizeAppreciationComments,
        'grainColourAppreciation':
            updatedPostHarvestObject.grainColourAppreciation,
        'grainColourAppreciationComments':
            updatedPostHarvestObject.grainColourAppreciationComments,
        'isUpToDateInServer': updatedPostHarvestObject.isUpToDateInServer,
        'existsInServer': updatedPostHarvestObject.existsInServer,
      },
    );
  }

  Future<void> fetchAndSetPostHarvestObjects() async {
    final dataList = await DBHelper.getData('postHarvest');
    _postHarvestObjectsList = dataList
        .map(
          (postHarvestObject) => PostHarvestModel(
            id: postHarvestObject['id'],
            lastUpdated: DateTime.parse(postHarvestObject['lastUpdated']),
            plotId: postHarvestObject['plotId'],
            yieldOfDriedCobs: postHarvestObject['yieldOfDriedCobs'],
            yieldOfDriedCobsComments:
                postHarvestObject['yieldOfDriedCobsComments'],
            grainHardness: postHarvestObject['yieldOfDriedCobsComments'],
            grainHardnessComments: postHarvestObject['grainHardnessComments'],
            yieldOfDriedPanicles: postHarvestObject['yieldOfDriedPanicles'],
            yieldOfDriedPaniclesComments:
                postHarvestObject['yieldOfDriedPaniclesComments'],
            yieldOfDriedHeads: postHarvestObject['yieldOfDriedHeads'],
            yieldOfDriedHeadsComments:
                postHarvestObject['yieldOfDriedHeadsComments'],
            yieldOfDriedPods: postHarvestObject['yieldOfDriedPods'],
            yieldOfDriedPodsComments:
                postHarvestObject['yieldOfDriedPodsComments'],
            grainsYield: postHarvestObject['grainsYield'],
            grainsYieldComments: postHarvestObject['grainsYieldComments'],
            grainSizeAppreciation: postHarvestObject['grainSizeAppreciation'],
            grainSizeAppreciationComments:
                postHarvestObject['grainSizeAppreciationComments'],
            grainColourAppreciation:
                postHarvestObject['grainColourAppreciation'],
            grainColourAppreciationComments:
                postHarvestObject['grainColourAppreciationComments'],
            isUpToDateInServer: postHarvestObject['isUpToDateInServer'],
            existsInServer: postHarvestObject['existsInServer'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
