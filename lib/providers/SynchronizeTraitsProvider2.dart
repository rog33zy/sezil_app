import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../constants/BaseUrls.dart';
import '../constants/Seasons.dart';

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
  String season = Seasons.currentSeason;
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

  int get fieldProfileCount {
    int fieldProfileCount = 0;
    try {
      if (fieldProfileObjectToBeSynced!.isUpToDateInServer == 'No' &&
          fieldProfileObjectToBeSynced?.lastUpdated != null) {
        fieldProfileCount = 1;
      }
    } catch (error) {
      fieldProfileCount = 0;
    }
    return fieldProfileCount;
  }

  int get fieldOperationsCount {
    int fieldOperationsCount = 0;
    try {
      if (fieldOperationObjectToBeSynced!.isUpToDateInServer == 'No' &&
          fieldOperationObjectToBeSynced?.lastUpdated != null) {
        fieldOperationsCount = 1;
      }
    } catch (error) {
      fieldOperationsCount = 0;
    }
    return fieldOperationsCount;
  }

  int get currentSeasonVarietyCount {
    int currentSeasonVarietyCount = 0;
    try {
      if (currentSeasonVarietyObjectToBeSynced!.isUpToDateInServer == 'No' &&
          currentSeasonVarietyObjectToBeSynced?.lastUpdated != null) {
        currentSeasonVarietyCount = 1;
      }
    } catch (error) {}
    return currentSeasonVarietyCount;
  }

  int get totalNumberOfItemsToBeSynced2 {
    int fieldProfileCount = this.fieldProfileCount;
    int fieldOperationsCount = this.fieldOperationsCount;
    int currentSeasonVarietyCount = this.currentSeasonVarietyCount;

    return postHarvestObjectsToBeSynced!.length +
        fertilizationObjectsToBeSynced!.length +
        fieldProfileCount +
        fieldOperationsCount +
        currentSeasonVarietyCount;
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

  Future<void> postPostHarvestObjectsToServer() async {
    for (int i = 0; i < postHarvestObjectsToBeSynced!.length; i++) {
      final unsyncedObject = postHarvestObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'season': season,
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

  Future<void> postCurrentSeasonVarietyObjectsToServer() async {
    final unsyncedObject = currentSeasonVarietyObjectToBeSynced!;
    String checkObjectExistsResponse = unsyncedObject.existsInServer;
    var body = {
      'id': unsyncedObject.id,
      'season': season,
      'crop': crop,
      'farmer_id': farmerId,
      'last_updated': unsyncedObject.lastUpdated!.toIso8601String(),
      'variety_name': unsyncedObject.varietyName,
      'previous_season_harvest': unsyncedObject.previousSeasonHarvest,
      'previous_season_hectarage': unsyncedObject.previousSeasonHectarage,
      'source_of_seed': unsyncedObject.sourceOfSeed,
      'number_of_years_grown': unsyncedObject.numberOfYearsGrown,
      'percent_farmers_growing_variety':
          unsyncedObject.percentFarmersGrowingVariety,
    };
    final Map<String, dynamic> responseData = await postUnsyncedObjectsToServer(
      body,
      'current_season_variety/current_season_variety_objects',
      checkObjectExistsResponse,
      unsyncedObject,
    );
    await DBHelper.insert(
      'currentSeasonVariety',
      {
        'id': responseData['id'],
        'lastUpdated': responseData['last_updated'],
        'varietyName': responseData['variety_name'],
        'previousSeasonHarvest': responseData['previous_season_harvest'],
        'previousSeasonHectarage': responseData['previous_season_hectarage'],
        'sourceOfSeed': responseData['source_of_seed'],
        'numberOfYearsGrown': responseData['number_of_years_grown'],
        'percentFarmersGrowingVariety':
            responseData['percent_farmers_growing_variety'],
        'isUpToDateInServer': 'Yes',
        'existsInServer': 'Yes',
      },
    );
    notifyListeners();
  }

  Future<void> postFertilizationObjectsToServer() async {
    for (int i = 0; i < fertilizationObjectsToBeSynced!.length; i++) {
      final unsyncedObject = fertilizationObjectsToBeSynced![i];
      String checkObjectExistsResponse = unsyncedObject.existsInServer;
      var body = {
        'id': unsyncedObject.id,
        'crop': crop,
        'farmer_id': farmerId,
        'last_updated': unsyncedObject.lastUpdated!.toIso8601String(),
        'season': unsyncedObject.season,
        'type_of_dressing': unsyncedObject.typeOfDressing,
        'name_of_organic_fertilizer': unsyncedObject.nameOfOrganicFertilizer,
        'name_of_synthetic_fertilizer':
            unsyncedObject.nameOfSyntheticFertilizer,
        'quantity_applied': unsyncedObject.quantityApplied,
        'time_of_application': unsyncedObject.timeOfApplication == null
            ? null
            : unsyncedObject.timeOfApplication!.toIso8601String(),
      };

      final Map<String, dynamic> responseData =
          await postUnsyncedObjectsToServer(
        body,
        'fertilization/fertilization_objects',
        checkObjectExistsResponse,
        unsyncedObject,
      );
      await DBHelper.insert(
        'fertilization',
        {
          'id': responseData['id'],
          'lastUpdated': responseData['last_updated'],
          'season': responseData['season'],
          'typeOfDressing': responseData['type_of_dressing'],
          'nameOfOrganicFertilizer': responseData['name_of_organic_fertilizer'],
          'nameOfSyntheticFertilizer':
              responseData['name_of_synthetic_fertilizer'],
          'quantityApplied': responseData['quantity_applied'],
          'timeOfApplication': responseData['time_of_application'],
          'isUpToDateInServer': 'Yes',
          'existsInServer': 'Yes',
        },
      );
      notifyListeners();
    }
  }

  Future<void> postFieldProfileObjectsToServer() async {
    final unsyncedObject = fieldProfileObjectToBeSynced!;
    String checkObjectExistsResponse = unsyncedObject.existsInServer;
    var body = {
      'id': unsyncedObject.id,
      'season': season,
      'crop': crop,
      'farmer_id': farmerId,
      'last_updated': unsyncedObject.lastUpdated!.toIso8601String(),
      'field_size': unsyncedObject.fieldSize,
      'soil_type': unsyncedObject.soilType,
      'latitude': unsyncedObject.latitude,
      'longitude': unsyncedObject.longitude,
      'crop_grown_prev_season': unsyncedObject.cropGrownPrevSeason,
      'crop_grown_two_seasons_ago': unsyncedObject.cropGrownTwoSeasonsAgo,
      'prev_season_weeding_manual': unsyncedObject.prevSeasonWeedingManual,
      'prev_season_weeding_chemical_name':
          unsyncedObject.prevSeasonWeedingChemicalName,
    };

    final Map<String, dynamic> responseData = await postUnsyncedObjectsToServer(
      body,
      'field_profile/field_profile_objects',
      checkObjectExistsResponse,
      unsyncedObject,
    );
    await DBHelper.insert(
      'fieldProfile',
      {
        'id': responseData['id'],
        'lastUpdated': responseData['last_updated'],
        'fieldSize': responseData['field_size'],
        'soilType': responseData['soil_type'],
        'latitude': responseData['latitude'],
        'longitude': responseData['longitude'],
        'cropGrownPrevSeason': responseData['crop_grown_prev_season'],
        'cropGrownTwoSeasonsAgo': responseData['crop_grown_two_seasons_ago'],
        'prevSeasonWeedingManual':
            responseData['prev_season_weeding_manual'],
        'prevSeasonWeedingChemicalName':
            responseData['prev_season_weeding_chemical_name'],
        'isUpToDateInServer': 'Yes',
        'existsInServer': 'Yes',
      },
    );
    notifyListeners();
  }

  Future<void> postFieldOperationObjectsToServer() async {
    final unsyncedObject = fieldOperationObjectToBeSynced!;
    String checkObjectExistsResponse = unsyncedObject.existsInServer;

    Map<String, dynamic> body = {
      'id': unsyncedObject.id,
      'season': season,
      'crop': crop,
      'farmer_id': farmerId,
      'last_updated': unsyncedObject.lastUpdated == null
          ? null
          : unsyncedObject.lastUpdated!.toIso8601String(),
      'date_of_land_preparation': unsyncedObject.dateOfLandPreparation == null
          ? null
          : unsyncedObject.dateOfLandPreparation!.toIso8601String(),
      'method_of_land_preparation': unsyncedObject.methodOfLandPreparation,
      'date_of_planting': unsyncedObject.dateOfPlanting == null
          ? null
          : unsyncedObject.dateOfPlanting!.toIso8601String(),
      'date_of_thinning': unsyncedObject.dateOfThinning == null
          ? null
          : unsyncedObject.dateOfThinning!.toIso8601String(),
      'date_of_first_weeding': unsyncedObject.dateOfFirstWeeding == null
          ? null
          : unsyncedObject.dateOfFirstWeeding!.toIso8601String(),
      'first_weeding_is_manual': unsyncedObject.firstWeedingIsManual,
      'first_weeding_herbicide_name': unsyncedObject.firstWeedingHerbicideName,
      'first_weeding_herbicide_qty': unsyncedObject.firstWeedingHerbicideQty,
      'date_of_pesticide_application':
          unsyncedObject.dateOfPesticideApplication == null
              ? null
              : unsyncedObject.dateOfPesticideApplication!.toIso8601String(),
      'pesticide_name': unsyncedObject.pesticideName,
      'pesticide_application_qty': unsyncedObject.pesticideApplicationQty,
      'date_of_second_weeding': unsyncedObject.dateOfSecondWeeding == null
          ? null
          : unsyncedObject.dateOfSecondWeeding!.toIso8601String(),
      'second_weeding_is_manual': unsyncedObject.secondWeedingIsManual,
      'second_weeding_herbicide_name':
          unsyncedObject.secondWeedingHerbicideName,
      'second_weeding_herbicide_qty': unsyncedObject.secondWeedingHerbicideQty,
    };

    final Map<String, dynamic> responseData = await postUnsyncedObjectsToServer(
      body,
      'field_operations/field_operations_objects',
      checkObjectExistsResponse,
      unsyncedObject,
    );
    await DBHelper.insert(
      'fieldOperations',
      {
        'id': responseData['id'],
        'lastUpdated': responseData['last_updated'],
        'dateOfLandPreparation': responseData['date_of_land_preparation'],
        'methodOfLandPreparation': responseData['method_of_land_preparation'],
        'dateOfPlanting': responseData['date_of_planting'],
        'dateOfThinning': responseData['date_of_thinning'],
        'dateOfFirstWeeding': responseData['date_of_first_weeding'],
        'firstWeedingIsManual': responseData['first_weeding_is_manual'],
        'firstWeedingHerbicideName':
            responseData['first_weeding_herbicide_name'],
        'firstWeedingHerbicideQty': responseData['first_weeding_herbicide_qty'],
        'dateOfPesticideApplication':
            responseData['date_of_pesticide_application'],
        'pesticideName': responseData['pesticide_name'],
        'pesticideApplicationQty': responseData['pesticide_application_qty'],
        'dateOfSecondWeeding': responseData['date_of_second_weeding'],
        'secondWeedingIsManual': responseData['second_weeding_is_manual'],
        'secondWeedingHerbicideName':
            responseData['second_weeding_herbicide_name'],
        'secondWeedingHerbicideQty':
            responseData['second_weeding_herbicide_qty'],
        'isUpToDateInServer': 'Yes',
        'existsInServer': 'Yes',
      },
    );
    notifyListeners();
  }
}
