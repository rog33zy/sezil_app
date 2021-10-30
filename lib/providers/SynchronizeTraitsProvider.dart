import 'package:flutter/foundation.dart';

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

  set setToken(String? token) {
    this.accessToken = token;
    notifyListeners();
  }
}
