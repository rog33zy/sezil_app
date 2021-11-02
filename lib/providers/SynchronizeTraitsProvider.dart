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

  Future<void> postPostPlantingObjectsToServer() async {
    for (int i = 0; i < postPlantingObjectsToBeSynced!.length; i++) {
      final unsyncedObject = postPlantingObjectsToBeSynced![i];
      final checkObjectExistsUrl = Uri.parse(
          'https://${BaseUrls.sezilUrl}/api/traits/check_post_planting_object/${unsyncedObject.id}/');
      final checkObjectExistsResponse = await http.get(
        checkObjectExistsUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      var postingUrl;
      var response;
      var body = {
        'id': unsyncedObject.id,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated,
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

      if (checkObjectExistsResponse.statusCode == 200) {
        postingUrl = Uri.parse(
          'https://${BaseUrls.sezilUrl}/api/traits/post_planting_objects/${unsyncedObject.id}/',
        );
        response = await http.patch(
          postingUrl,
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $accessToken',
          },
        );
      } else if (checkObjectExistsResponse.statusCode == 404) {
        postingUrl = Uri.parse(
          'https://${BaseUrls.sezilUrl}/api/traits/post_planting_objects/',
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
        },
      );

      notifyListeners();
    }
  }
}
