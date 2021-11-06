import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../constants/BaseUrls.dart';

import '../helpers/db_helper.dart';

import '../models/PostHarvestModel.dart';
import '../models/FieldProfileModel.dart';
import '../models/FieldOperationsModel.dart';
import '../models/CurrentSeasonVarietyModel.dart';
import '../models/FertilizationModel.dart';

class SynchronizeTraitsProvider2 with ChangeNotifier {
  String? accessToken;
  String? farmerId;
  String? crop;
  List<PostHarvestModel>? postHarvestObjectsToBeSynced;
  List<FertilizationModel>? fertilizationObjectsToBeSynced;
  FieldProfileModel? fieldProfileObjectToBeSynced;
  FieldOperationsModel? fieldOperationObjectToBeSynced;
  CurrentSeasonVarietyModel? currentSeasonVarietyObjectToBeSynced;

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

  // set setPostHarvestObjectsToBeSynced(
  //     List<PostHarvestModel> postHarvestObjectsToBeSynced) {
  //   this.postHarvestObjectsToBeSynced = postHarvestObjectsToBeSynced;
  //   notifyListeners();
  // }
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

  Future<void> postPostHarvestObjectsToServer() async {
    for (int i = 0; i < postHarvestObjectsToBeSynced!.length; i++) {
      final unsyncedObject = postHarvestObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'yield_of_dried_cobs': unsyncedObject.yieldOfDriedCobs,
        'yield_of_dried_cobs_comments': unsyncedObject.yieldOfDriedCobsComments,
        'grain_hardness': unsyncedObject.grainHardness,
        'grain_hardness_comments': unsyncedObject.grainHardnessComments,
        'yield_of_dried_panicles': unsyncedObject.yieldOfDriedPanicles,
        'yield_of_dried_panicles_comments':
            unsyncedObject.yieldOfDriedPaniclesComments,
        'yield_of_dried_heads': unsyncedObject.yieldOfDriedHeads,
        'yield_of_dried_heads_comments':
            unsyncedObject.yieldOfDriedHeadsComments,
        'yield_of_dried_pods': unsyncedObject.yieldOfDriedPods,
        'yield_of_dried_pods_comments': unsyncedObject.yieldOfDriedPodsComments,
        'grains_yield': unsyncedObject.grainsYield,
        'grains_yield_comments': unsyncedObject.grainsYieldComments,
        'grain_size_appreciation': unsyncedObject.grainSizeAppreciation,
        'grain_size_appreciation_comments':
            unsyncedObject.grainSizeAppreciationComments,
        'grain_colour_appreciation': unsyncedObject.grainColourAppreciation,
        'grain_colour_appreciation_comments':
            unsyncedObject.grainColourAppreciationComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/post_harvest_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'postHarvest',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'yieldOfDriedCobs': responseData['yield_of_dried_cobs'],
          'yieldOfDriedCobsComments':
              responseData['yield_of_dried_cobs_comments'],
          'grainHardness': responseData['grain_hardness'],
          'grainHardnessComments': responseData['grain_hardness_comments'],
          'yieldOfDriedPanicles': responseData['yield_of_dried_panicles'],
          'yieldOfDriedPaniclesComments':
              responseData['yield_of_dried_panicles_comments'],
          'yieldOfDriedHeads': responseData['yield_of_dried_heads'],
          'yieldOfDriedHeadsComments':
              responseData['yield_of_dried_heads_comments'],
          'yieldOfDriedPods': responseData['yield_of_dried_pods'],
          'yieldOfDriedPodsComments':
              responseData['yield_of_dried_pods_comments'],
          'grainsYield': responseData['grains_yield'],
          'grainsYieldComments': responseData['grains_yield_comments'],
          'grainSizeAppreciation': responseData['grain_size_appreciation'],
          'grainSizeAppreciationComments':
              responseData['grain_size_appreciation_comments'],
          'grainColourAppreciation': responseData['grain_colour_appreciation'],
          'grainColourAppreciationComments':
              responseData['grain_colour_appreciation_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }
}
