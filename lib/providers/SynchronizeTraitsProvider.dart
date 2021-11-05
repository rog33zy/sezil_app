import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../constants/BaseUrls.dart';

import '../helpers/db_helper.dart';

import '../models/PostPlantingModel.dart';
import '../models/FloweringModel.dart';
import '../models/PostFloweringModel.dart';
import '../models/PreHarvestModel.dart';
import '../models/HarvestModel.dart';

class SynchronizeTraitsProvider with ChangeNotifier {
  String? accessToken;
  String? farmerId;
  String? crop;
  List<PostPlantingModel>? postPlantingObjectsToBeSynced;
  List<FloweringModel>? floweringObjectsToBeSynced;
  List<PostFloweringModel>? postFloweringObjectsToBeSynced;
  List<PreHarvestModel>? preHarvestObjectsToBeSynced;
  List<HarvestModel>? harvestObjectsToBeSynced;

  set setToken(String? accessToken) {
    this.accessToken = accessToken;
    notifyListeners();
  }

  set setFarmerId(String? farmerId) {
    this.farmerId = farmerId;
    notifyListeners();
  }

  set setCrop(String? crop) {
    this.crop = crop;
    notifyListeners();
  }

  set setPostPlantingObjectsToBeSynced(
      List<PostPlantingModel> postPlantingObjectsToBeSynced) {
    this.postPlantingObjectsToBeSynced = postPlantingObjectsToBeSynced;
    notifyListeners();
  }

  int get totalNumberOfItemsToBeSynced {
    return postPlantingObjectsToBeSynced!.length;
  }

  dynamic postUnsyncedObjectsToServer(
    body,
    postingUrlPortion,
    checkObjectExistsResponse,
    unsyncedObject,
  ) async {
    var postingUrl;
    var response;

    if (checkObjectExistsResponse == 'Yes') {
      postingUrl = Uri.parse(
        'https://${BaseUrls.sezilUrl}/api/$postingUrlPortion/${unsyncedObject.id}/',
      );
      response = await http.patch(
        postingUrl,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
    } else if (checkObjectExistsResponse == 'No') {
      postingUrl = Uri.parse(
        'https://${BaseUrls.sezilUrl}/api/$postingUrlPortion/',
      );

      response = await http.post(
        postingUrl,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
    }

    final responseData = json.decode(response.body);
    return responseData;
  }

  Future<void> postPostPlantingObjectsToServer() async {
    for (int i = 0; i < postPlantingObjectsToBeSynced!.length; i++) {
      final unsyncedObject = postPlantingObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated!.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'seedling_vigour': unsyncedObject.seedlingVigour,
        'seedling_vigour_comments': unsyncedObject.seedlingVigourComments,
        'plant_stand': unsyncedObject.plantStand,
        'plant_stand_comments': unsyncedObject.plantStandComments,
        'pest_resistance': unsyncedObject.pestResistance,
        'pest_resistance_comments': unsyncedObject.pestResistanceComments,
        'diseases_resistance': unsyncedObject.diseasesResistance,
        'diseases_resistance_comments':
            unsyncedObject.diseasesResistanceComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/post_planting_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'postPlanting',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'seedlingVigour': responseData['seedling_vigour'],
          'seedlingVigourComments': responseData['seedling_vigour_comments'],
          'plantStand': responseData['plant_stand'],
          'plantStandComments': responseData['plant_stand_comments'],
          'pestResistance': responseData['pest_resistance'],
          'pestResistanceComments': responseData['pest_resistance_comments'],
          'diseasesResistance': responseData['diseases_resistance'],
          'diseasesResistanceComments':
              responseData['diseases_resistance_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }

  Future<void> postFloweringObjectsToServer() async {
    for (int i = 0; i < floweringObjectsToBeSynced!.length; i++) {
      final unsyncedObject = floweringObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'growing_cycle_appreciation': unsyncedObject.growingCycleAppreciation,
        'growing_cycle_appreciation_comments':
            unsyncedObject.growingCycleAppreciationComments,
        'pest_resistance': unsyncedObject.pestResistance,
        'pest_resistance_comments': unsyncedObject.pestResistanceComments,
        'diseases_resistance': unsyncedObject.diseasesResistance,
        'diseases_resistance_comments':
            unsyncedObject.diseasesResistanceComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/flowering_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'postPlanting',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'growingCycleAppreciation':
              responseData['growing_cycle_appreciation'],
          'growingCycleAppreciationComments':
              responseData['growing_cycle_appreciation_comments'],
          'pestResistance': responseData['pest_resistance'],
          'pestResistanceComments': responseData['pest_resistance_comments'],
          'diseasesResistance': responseData['diseases_resistance'],
          'diseasesResistanceComments':
              responseData['diseases_resistance_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }
}
