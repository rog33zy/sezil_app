import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../helpers/db_helper.dart';

import '../constants/BaseUrls.dart';

import '../models/UserModel.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  String? _username;
  String? _firstName;
  String? _farmerId;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool? _isHRAdmin;
  bool? _isSezilMotherTrialFarmer;
  String _crop = 'Maize';

  bool get isAuth {
    return _accessToken != null;
  }

  String? get accessToken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _accessToken != null) {
      return _accessToken;
    }
    return null;
  }

  String? get username {
    return _username;
  }

  String? get firstName {
    return _firstName;
  }

  String? get farmerId {
    return _farmerId;
  }

  bool? get isHRAdmin {
    return _isHRAdmin;
  }

  bool? get isSezilMotherTrialFarmer {
    return _isSezilMotherTrialFarmer;
  }

  String get crop {
    return _crop;
  }

  Future<void> _authenticateUser(UserModel userObject,
      {bool isRefreshing = false}) async {
    Uri url;
    if (isRefreshing) {
      url = Uri.parse(
        'https://${BaseUrls.authBaseUrl}/api/authenticate/mobile_get_refresh_token/',
      );
    } else {
      url = Uri.parse(
        'https://${BaseUrls.authBaseUrl}/api/authenticate/mobile_login/',
      );
    }

    try {
      var response;

      if (isRefreshing) {
        response = await http.post(
          url,
          body: json.encode(
            {
              'refresh_token': _refreshToken,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      } else {
        response = await http.post(
          url,
          body: json.encode(
            {
              "username": userObject.username,
              "password": userObject.password,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }

      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];
      final refreshToken = responseData['refresh_token'];
      final expiryDate = responseData['refresh_token_expiry_date'];

      Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

      _accessToken = accessToken;
      _refreshToken = refreshToken;
      _username = payload['user']['username'];
      _firstName = payload['user']['first_name'];
      _expiryDate = DateTime.parse(expiryDate);

      if (payload['user']['is_human_resource_admin'] == null) {
        _isHRAdmin = false;
      } else {
        _isHRAdmin = payload['user']['is_human_resource_admin'];
      }

      if (payload['user']['is_sezil_mother_trial_farmer'] == null) {
        _isSezilMotherTrialFarmer = false;
      } else {
        _isSezilMotherTrialFarmer =
            payload['user']['is_sezil_mother_trial_farmer'];
      }

      if (_isSezilMotherTrialFarmer!) {
        final url2 = Uri.parse(
          'https://${BaseUrls.sezilUrl}/api/accounts/farmer_details/$_username/',
        );

        final response2 = await http.get(
          url2,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $accessToken',
          },
        );
        final response2Data = json.decode(response2.body);
        _farmerId = response2Data['farmer_id'];
        _crop = response2Data['crop'];
      }

      if (!isRefreshing && isSezilMotherTrialFarmer!) {
        await _getPostPlantingObjectsFromServer();
        await _getFloweringObjectsFromServer();
        await _getPostFloweringObjectsFromServer();
        await _getPreHarvestObjectsFromServer();
        await _getHarvestObjectsFromServer();
        await _getPostHarvestObjectsFromServer();
        await _getCurrentSeasonVarietyObjectsFromServer();
        await _getFertilizationObjectsFromServer();
        await _getFieldOperationObjectsFromServer();
        await _getFieldProfileObjectsFromServer();
      }

      _autoLogout();

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'accessToken': _accessToken,
          'refreshToken': _refreshToken,
          'username': _username,
          'firstName': _firstName,
          'expiryDate': _expiryDate!.toIso8601String(),
          'isHRAdmin': _isHRAdmin,
          'isSourceFieldSupervisor': _isSezilMotherTrialFarmer,
          'crop': _crop,
          'farmerId': _farmerId,
        },
      );
      prefs.setString(
        'userData',
        userData,
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(UserModel userObject) async {
    return _authenticateUser(userObject);
  }

  Future<void> refreshToken() async {
    return _authenticateUser(UserModel(), isRefreshing: true);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData = prefs.getString('userData');
    final extractedUserData = json.decode(
      userData!,
    ) as Map<String, dynamic>;

    final expiryDate = DateTime.parse(
      extractedUserData['expiryDate']!,
    );

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _accessToken = extractedUserData['accessToken'];
    _refreshToken = extractedUserData['refreshToken'];
    _username = extractedUserData['username'];
    _firstName = extractedUserData['firstName'];
    _isHRAdmin = extractedUserData['isHRAdmin'];
    _isSezilMotherTrialFarmer = extractedUserData['isSourceFieldSupervisor'];
    _expiryDate = expiryDate;
    _crop = extractedUserData['crop'];
    _farmerId = extractedUserData['farmerId'];

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _accessToken = null;
    _firstName = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inDays;
    _authTimer = Timer(
      Duration(days: timeToExpiry),
      logout,
    );
  }

  dynamic _getObjectsFromServerHandler(postingUrlPortion) async {
    final postingUrl = Uri.parse(
      'https://${BaseUrls.sezilUrl}/api/$postingUrlPortion/$_farmerId/',
    );

    final response = await http.get(
      postingUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      },
    );
    if (response.statusCode == 404) {
      return;
    }
    final responseData = json.decode(response.body);
    return responseData;
  }

  Future<void> _getPostPlantingObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_post_planting_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'postPlanting',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'seedlingVigour': objectToBeSynced['seedling_vigour'],
            'seedlingVigourComments':
                objectToBeSynced['seedling_vigour_comments'],
            'plantStand': objectToBeSynced['plant_stand'],
            'plantStandComments': objectToBeSynced['plant_stand_comments'],
            'pestResistance': objectToBeSynced['pest_resistance'],
            'pestResistanceComments':
                objectToBeSynced['pest_resistance_comments'],
            'diseasesResistance': objectToBeSynced['diseases_resistance'],
            'diseasesResistanceComments':
                objectToBeSynced['diseases_resistance_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getFloweringObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_flowering_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'flowering',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'growingCycleAppreciation':
                objectToBeSynced['growing_cycle_appreciation'],
            'growingCycleAppreciationComments':
                objectToBeSynced['growing_cycle_appreciation_comments'],
            'pestResistance': objectToBeSynced['pest_resistance'],
            'pestResistanceComments':
                objectToBeSynced['pest_resistance_comments'],
            'diseasesResistance': objectToBeSynced['diseases_resistance'],
            'diseasesResistanceComments':
                objectToBeSynced['diseases_resistance_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getPostFloweringObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_post_flowering_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'postFlowering',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'pestResistance': objectToBeSynced['pest_resistance'],
            'pestResistanceComments':
                objectToBeSynced['pest_resistance_comments'],
            'diseasesResistance': objectToBeSynced['diseases_resistance'],
            'diseasesResistanceComments':
                objectToBeSynced['diseases_resistance_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getPreHarvestObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_pre_harvest_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'preHarvest',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'lodgingResistance': objectToBeSynced['lodging_resistance'],
            'lodgingResistanceComments':
                objectToBeSynced['lodging_resistance_comments'],
            'huskCover': objectToBeSynced['husk_cover'],
            'huskCoverComments': objectToBeSynced['husk_cover_comments'],
            'cobSizeAppreciation': objectToBeSynced['cob_size_appreciation'],
            'cobSizeAppreciationComments':
                objectToBeSynced['cob_size_appreciation_comments'],
            'numberOfCobsPerPlantAppreciation':
                objectToBeSynced['number_of_cobs_per_plant_appreciation'],
            'numberOfCobsPerPlantAppreciationComments': objectToBeSynced[
                'number_of_cobs_per_plant_appreciation_comments'],
            'plantHeight': objectToBeSynced['plant_height'],
            'plantHeightComments': objectToBeSynced['plant_height_comments'],
            'birdDamage': objectToBeSynced['bird_damage'],
            'birdDamageComments': objectToBeSynced['bird_damage_comments'],
            'panicleAppreciation': objectToBeSynced['panicle_appreciation'],
            'panicleAppreciationComments':
                objectToBeSynced['panicle_appreciation_comments'],
            'grainQualityAppreciation':
                objectToBeSynced['grain_quality_appreciation'],
            'grainQualityAppreciationComments':
                objectToBeSynced['grain_quality_appreciation_comments'],
            'headSizeAppreciation': objectToBeSynced['head_size_appreciation'],
            'headSizeAppreciationComments':
                objectToBeSynced['head_size_appreciation_comments'],
            'numberOfHeadsAppreciation':
                objectToBeSynced['number_of_heads_appreciation'],
            'numberOfHeadsAppreciationComments':
                objectToBeSynced['number_of_heads_appreciation_comments'],
            'plantGrowthHabitAppreciation':
                objectToBeSynced['plant_growth_habit_appreciation'],
            'plantGrowthHabitAppreciationComments':
                objectToBeSynced['plant_growth_habit_appreciation_comments'],
            'podLengthAppreciation':
                objectToBeSynced['pod_length_appreciation'],
            'podLengthAppreciationComments':
                objectToBeSynced['pod_length_appreciation_comments'],
            'willingnessToCultivateNextSeason':
                objectToBeSynced['willingness_to_cultivate_next_season'],
            'willingnessToCultivateNextSeasonComments': objectToBeSynced[
                'willingness_to_cultivate_next_season_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getHarvestObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_harvest_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'harvest',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'harvestDate': objectToBeSynced['harvest_date'],
            'numberOfPlants': objectToBeSynced['number_of_plants'],
            'numberOfPlantsComments':
                objectToBeSynced['number_of_plants_comments'],
            'numberOfHarvestedCobs':
                objectToBeSynced['number_of_harvested_cobs'],
            'numberOfHarvestedCobsComments':
                objectToBeSynced['number_of_harvested_cobs_comments'],
            'yieldOfHarvestedCobs': objectToBeSynced['yield_of_harvested_cobs'],
            'yieldOfHarvestedCobsComments':
                objectToBeSynced['yield_of_harvested_cobs_comments'],
            'numberOfHarvestedPanicles':
                objectToBeSynced['number_of_harvested_panicles'],
            'numberOfHarvestedPaniclesComments':
                objectToBeSynced['number_of_harvested_panicles_comments'],
            'yieldOfHarvestedPanicles':
                objectToBeSynced['yield_of_harvested_panicles'],
            'yieldOfHarvestedPaniclesComments':
                objectToBeSynced['yield_of_harvested_panicles_comments'],
            'numberOfHarvestedHeads':
                objectToBeSynced['number_of_harvested_heads'],
            'numberOfHarvestedHeadsComments':
                objectToBeSynced['number_of_harvested_heads_comments'],
            'yieldOfHarvestedHeads':
                objectToBeSynced['yield_of_harvested_heads'],
            'yieldOfHarvestedHeadsComments':
                objectToBeSynced['yield_of_harvested_heads_comments'],
            'numberOfHarvestedPods':
                objectToBeSynced['number_of_harvested_pods'],
            'numberOfHarvestedPodsComments':
                objectToBeSynced['number_of_harvested_pods_comments'],
            'yieldOfHarvestedPods': objectToBeSynced['yield_of_harvested_pods'],
            'yieldOfHarvestedPodsComments':
                objectToBeSynced['yield_of_harvested_pods_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getPostHarvestObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'traits/get_post_harvest_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'postHarvest',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'plotId': objectToBeSynced['plot_id'],
            'yieldOfDriedCobs': objectToBeSynced['yield_of_dried_cobs'],
            'yieldOfDriedCobsComments':
                objectToBeSynced['yield_of_dried_cobs_comments'],
            'grainHardness': objectToBeSynced['grain_hardness'],
            'grainHardnessComments':
                objectToBeSynced['grain_hardness_comments'],
            'yieldOfDriedPanicles': objectToBeSynced['yield_of_dried_panicles'],
            'yieldOfDriedPaniclesComments':
                objectToBeSynced['yield_of_dried_panicles_comments'],
            'yieldOfDriedHeads': objectToBeSynced['yield_of_dried_heads'],
            'yieldOfDriedHeadsComments':
                objectToBeSynced['yield_of_dried_heads_comments'],
            'yieldOfDriedPods': objectToBeSynced['yield_of_dried_pods'],
            'yieldOfDriedPodsComments':
                objectToBeSynced['yield_of_dried_pods_comments'],
            'grainsYield': objectToBeSynced['grains_yield'],
            'grainsYieldComments': objectToBeSynced['grains_yield_comments'],
            'grainSizeAppreciation':
                objectToBeSynced['grain_size_appreciation'],
            'grainSizeAppreciationComments':
                objectToBeSynced['grain_size_appreciation_comments'],
            'grainColourAppreciation':
                objectToBeSynced['grain_colour_appreciation'],
            'grainColourAppreciationComments':
                objectToBeSynced['grain_colour_appreciation_comments'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getCurrentSeasonVarietyObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'current_season_variety/get_current_season_variety_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'currentSeasonVariety',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'varietyName': objectToBeSynced['variety_name'],
            'previousSeasonHarvest':
                objectToBeSynced['previous_season_harvest'],
            'previousSeasonHectarage':
                objectToBeSynced['previous_season_hectarage'],
            'sourceOfSeed': objectToBeSynced['source_of_seed'],
            'numberOfYearsGrown': objectToBeSynced['number_of_years_grown'],
            'percentFarmersGrowingVariety':
                objectToBeSynced['percent_farmers_growing_variety'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getFertilizationObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'fertilization/get_fertilization_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'fertilization',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'season': objectToBeSynced['season'],
            'typeOfDressing': objectToBeSynced['type_of_dressing'],
            'nameOfOrganicFertilizer':
                objectToBeSynced['name_of_organic_fertilizer'],
            'nameOfSyntheticFertilizer':
                objectToBeSynced['name_of_synthetic_fertilizer'],
            'quantityApplied': objectToBeSynced['quantity_applied'],
            'timeOfApplication': objectToBeSynced['time_of_application'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getFieldProfileObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'field_profile/get_field_profile_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'fieldProfile',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'fieldSize': objectToBeSynced['field_size'],
            'soilType': objectToBeSynced['soil_type'],
            'latitude': objectToBeSynced['latitude'],
            'longitude': objectToBeSynced['longitude'],
            'cropGrownPrevSeason': objectToBeSynced['crop_grown_prev_season'],
            'cropGrownTwoSeasonsAgo':
                objectToBeSynced['crop_grown_two_seasons_ago'],
            'prevSeasonWeedingManual':
                objectToBeSynced['prev_season_weeding_manual'],
            'prevSeasonWeedingChemicalName':
                objectToBeSynced['prev_season_weeding_chemical_name'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getFieldOperationObjectsFromServer() async {
    try {
      final List<dynamic> responseData = await _getObjectsFromServerHandler(
        'field_operations/get_field_operations_objects',
      );

      for (int i = 0; i < responseData.length; i++) {
        final objectToBeSynced = responseData[i];
        await DBHelper.insert(
          'fieldOperations',
          {
            'id': objectToBeSynced['id'],
            'lastUpdated': objectToBeSynced['last_updated'],
            'dateOfLandPreparation':
                objectToBeSynced['date_of_land_preparation'],
            'methodOfLandPreparation':
                objectToBeSynced['method_of_land_preparation'],
            'dateOfPlanting': objectToBeSynced['date_of_planting'],
            'dateOfThinning': objectToBeSynced['date_of_thinning'],
            'dateOfFirstWeeding': objectToBeSynced['date_of_first_weeding'],
            'firstWeedingIsManual': objectToBeSynced['first_weeding_is_manual'],
            'firstWeedingHerbicideName':
                objectToBeSynced['first_weeding_herbicide_name'],
            'firstWeedingHerbicideQty':
                objectToBeSynced['first_weeding_herbicide_qty'],
            'dateOfPesticideApplication':
                objectToBeSynced['date_of_pesticide_application'],
            'pesticideName': objectToBeSynced['pesticide_name'],
            'pesticideApplicationQty':
                objectToBeSynced['pesticide_application_qty'],
            'dateOfSecondWeeding': objectToBeSynced['date_of_second_weeding'],
            'secondWeedingIsManual':
                objectToBeSynced['second_weeding_is_manual'],
            'secondWeedingHerbicideName':
                objectToBeSynced['second_weeding_herbicide_name'],
            'secondWeedingHerbicideQty':
                objectToBeSynced['second_weeding_herbicide_qty'],
            'isUpToDateInServer': 'Yes',
            'existsInServer': 'Yes',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
