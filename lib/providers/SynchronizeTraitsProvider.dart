import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../constants/BaseUrls.dart';
import '../constants/Seasons.dart';

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
  String season = Seasons.currentSeason;
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

  int get totalNumberOfItemsToBeSynced {
    return postPlantingObjectsToBeSynced!.length +
        floweringObjectsToBeSynced!.length +
        postFloweringObjectsToBeSynced!.length +
        preHarvestObjectsToBeSynced!.length +
        harvestObjectsToBeSynced!.length;
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
        'season': season,
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
        'season': season,
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
        'pest_and_diseases_resistance':
            unsyncedObject.pestAndDiseasesResistance,
        'pest_and_diseases_resistance_comments':
            unsyncedObject.pestAndDiseasesResistanceComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/flowering_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'flowering',
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
          'pestAndDiseasesResistance':
              responseData['pest_and_diseases_resistance'],
          'pestAndDiseasesResistanceComments':
              responseData['pest_and_diseases_resistance_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }

  Future<void> postPostFloweringObjectsToServer() async {
    for (int i = 0; i < postFloweringObjectsToBeSynced!.length; i++) {
      final unsyncedObject = postFloweringObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'season': season,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'pest_resistance': unsyncedObject.pestResistance,
        'pest_resistance_comments': unsyncedObject.pestResistanceComments,
        'diseases_resistance': unsyncedObject.diseasesResistance,
        'diseases_resistance_comments':
            unsyncedObject.diseasesResistanceComments,
        'pest_and_diseases_resistance':
            unsyncedObject.pestAndDiseasesResistance,
        'pest_and_diseases_resistance_comments':
            unsyncedObject.pestAndDiseasesResistanceComments,
        'drought_tolerance': unsyncedObject.droughtTolerance,
        'drought_tolerance_comments': unsyncedObject.droughtToleranceComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/post_flowering_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'postFlowering',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'pestResistance': responseData['pest_resistance'],
          'pestResistanceComments': responseData['pest_resistance_comments'],
          'diseasesResistance': responseData['diseases_resistance'],
          'diseasesResistanceComments':
              responseData['diseases_resistance_comments'],
          'pestAndDiseasesResistance':
              responseData['pest_and_diseases_resistance'],
          'pestAndDiseasesResistanceComments':
              responseData['pest_and_diseases_resistance_comments'],
          'droughtTolerance': responseData['drought_tolerance'],
          'droughtToleranceComments':
              responseData['drought_tolerance_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }

  Future<void> postPreHarvestObjectsToServer() async {
    for (int i = 0; i < preHarvestObjectsToBeSynced!.length; i++) {
      final unsyncedObject = preHarvestObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'season': season,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'lodging_resistance': unsyncedObject.lodgingResistance,
        'lodging_resistance_comments': unsyncedObject.lodgingResistanceComments,
        'husk_cover': unsyncedObject.huskCover,
        'husk_cover_comments': unsyncedObject.huskCoverComments,
        'cob_size_appreciation': unsyncedObject.cobSizeAppreciation,
        'cob_size_appreciation_comments':
            unsyncedObject.cobSizeAppreciationComments,
        'number_of_cobs_per_plant_appreciation':
            unsyncedObject.numberOfCobsPerPlantAppreciation,
        'number_of_cobs_per_plant_appreciation_comments':
            unsyncedObject.numberOfCobsPerPlantAppreciationComments,
        'plant_height': unsyncedObject.plantHeight,
        'plant_height_comments': unsyncedObject.plantHeightComments,
        'bird_damage': unsyncedObject.birdDamage,
        'bird_damage_comments': unsyncedObject.birdDamageComments,
        'panicle_appreciation': unsyncedObject.panicleAppreciation,
        'panicle_appreciation_comments':
            unsyncedObject.panicleAppreciationComments,
        'grain_quality_appreciation': unsyncedObject.grainQualityAppreciation,
        'grain_quality_appreciation_comments':
            unsyncedObject.grainQualityAppreciationComments,
        'head_size_appreciation': unsyncedObject.headSizeAppreciation,
        'head_size_appreciation_comments':
            unsyncedObject.headSizeAppreciationComments,
        'number_of_heads_appreciation':
            unsyncedObject.numberOfHeadsAppreciation,
        'number_of_heads_appreciation_comments':
            unsyncedObject.numberOfHeadsAppreciationComments,
        'plant_growth_habit_appreciation':
            unsyncedObject.plantGrowthHabitAppreciation,
        'plant_growth_habit_appreciation_comments':
            unsyncedObject.plantGrowthHabitAppreciationComments,
        'pod_length_appreciation': unsyncedObject.podLengthAppreciation,
        'pod_length_appreciation_comments':
            unsyncedObject.podLengthAppreciationComments,
        'willingness_to_cultivate_next_season':
            unsyncedObject.willingnessToCultivateNextSeason,
        'willingness_to_cultivate_next_season_comments':
            unsyncedObject.willingnessToCultivateNextSeasonComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/pre_harvest_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'preHarvest',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'lodgingResistance': responseData['lodging_resistance'],
          'lodgingResistanceComments':
              responseData['lodging_resistance_comments'],
          'huskCover': responseData['husk_cover'],
          'huskCoverComments': responseData['husk_cover_comments'],
          'cobSizeAppreciation': responseData['cob_size_appreciation'],
          'cobSizeAppreciationComments':
              responseData['cob_size_appreciation_comments'],
          'numberOfCobsPerPlantAppreciation':
              responseData['number_of_cobs_per_plant_appreciation'],
          'numberOfCobsPerPlantAppreciationComments':
              responseData['number_of_cobs_per_plant_appreciation_comments'],
          'plantHeight': responseData['plant_height'],
          'plantHeightComments': responseData['plant_height_comments'],
          'birdDamage': responseData['bird_damage'],
          'birdDamageComments': responseData['bird_damage_comments'],
          'panicleAppreciation': responseData['panicle_appreciation'],
          'panicleAppreciationComments':
              responseData['panicle_appreciation_comments'],
          'grainQualityAppreciation':
              responseData['grain_quality_appreciation'],
          'grainQualityAppreciationComments':
              responseData['grain_quality_appreciation_comments'],
          'headSizeAppreciation': responseData['head_size_appreciation'],
          'headSizeAppreciationComments':
              responseData['head_size_appreciation_comments'],
          'numberOfHeadsAppreciation':
              responseData['number_of_heads_appreciation'],
          'numberOfHeadsAppreciationComments':
              responseData['number_of_heads_appreciation_comments'],
          'plantGrowthHabitAppreciation':
              responseData['plant_growth_habit_appreciation'],
          'plantGrowthHabitAppreciationComments':
              responseData['plant_growth_habit_appreciation_comments'],
          'podLengthAppreciation': responseData['pod_length_appreciation'],
          'podLengthAppreciationComments':
              responseData['pod_length_appreciation_comments'],
          'willingnessToCultivateNextSeason':
              responseData['willingness_to_cultivate_next_season'],
          'willingnessToCultivateNextSeasonComments':
              responseData['willingness_to_cultivate_next_season_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }

  Future<void> postHarvestObjectsToServer() async {
    for (int i = 0; i < harvestObjectsToBeSynced!.length; i++) {
      final unsyncedObject = harvestObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'season': season,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated.toIso8601String(),
        'plot_id': unsyncedObject.plotId,
        'harvest_date': unsyncedObject.harvestDate!.toIso8601String(),
        'number_of_plants': unsyncedObject.numberOfPlants,
        'number_of_plants_comments': unsyncedObject.numberOfPlantsComments,
        'number_of_harvested_cobs': unsyncedObject.numberOfHarvestedCobs,
        'number_of_harvested_cobs_comments':
            unsyncedObject.numberOfHarvestedCobsComments,
        'yield_of_harvested_cobs': unsyncedObject.yieldOfHarvestedCobs,
        'yield_of_harvested_cobs_comments':
            unsyncedObject.yieldOfHarvestedCobsComments,
        'number_of_harvested_panicles':
            unsyncedObject.numberOfHarvestedPanicles,
        'number_of_harvested_panicles_comments':
            unsyncedObject.numberOfHarvestedPaniclesComments,
        'yield_of_harvested_panicles': unsyncedObject.yieldOfHarvestedPanicles,
        'yield_of_harvested_panicles_comments':
            unsyncedObject.yieldOfHarvestedPaniclesComments,
        'number_of_harvested_heads': unsyncedObject.numberOfHarvestedHeads,
        'number_of_harvested_heads_comments':
            unsyncedObject.numberOfHarvestedHeadsComments,
        'yield_of_harvested_heads': unsyncedObject.yieldOfHarvestedHeads,
        'yield_of_harvested_heads_comments':
            unsyncedObject.yieldOfHarvestedHeadsComments,
        'number_of_harvested_pods': unsyncedObject.numberOfHarvestedPods,
        'number_of_harvested_pods_comments':
            unsyncedObject.numberOfHarvestedPodsComments,
        'yield_of_harvested_pods': unsyncedObject.yieldOfHarvestedPods,
        'yield_of_harvested_pods_comments':
            unsyncedObject.yieldOfHarvestedPodsComments,
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'traits/harvest_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'harvest',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'plotId': responseData['plot_id'],
          'harvestDate': responseData['harvest_date'],
          'numberOfPlants': responseData['number_of_plants'],
          'numberOfPlantsComments': responseData['number_of_plants_comments'],
          'numberOfHarvestedCobs': responseData['number_of_harvested_cobs'],
          'numberOfHarvestedCobsComments':
              responseData['number_of_harvested_cobs_comments'],
          'yieldOfHarvestedCobs': responseData['yield_of_harvested_cobs'],
          'yieldOfHarvestedCobsComments':
              responseData['yield_of_harvested_cobs_comments'],
          'numberOfHarvestedPanicles':
              responseData['number_of_harvested_panicles'],
          'numberOfHarvestedPaniclesComments':
              responseData['number_of_harvested_panicles_comments'],
          'yieldOfHarvestedPanicles':
              responseData['yield_of_harvested_panicles'],
          'yieldOfHarvestedPaniclesComments':
              responseData['yield_of_harvested_panicles_comments'],
          'numberOfHarvestedHeads': responseData['number_of_harvested_heads'],
          'numberOfHarvestedHeadsComments':
              responseData['number_of_harvested_heads_comments'],
          'yieldOfHarvestedHeads': responseData['yield_of_harvested_heads'],
          'yieldOfHarvestedHeadsComments':
              responseData['yield_of_harvested_heads_comments'],
          'numberOfHarvestedPods': responseData['number_of_harvested_pods'],
          'numberOfHarvestedPodsComments':
              responseData['number_of_harvested_pods_comments'],
          'yieldOfHarvestedPods': responseData['yield_of_harvested_pods'],
          'yieldOfHarvestedPodsComments':
              responseData['yield_of_harvested_pods_comments'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }
}
