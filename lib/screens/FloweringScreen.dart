import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/FloweringProvider.dart';

import '../models/FloweringModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/PlotsFloatingButtons.dart';

class FloweringScreen extends StatelessWidget {
  FloweringScreen({Key? key}) : super(key: key);

  static const routeName = '/flowering';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final String crop = authProvider.crop;
    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<FloweringProvider>(
      context,
      listen: false,
    ).isExisting(plotId);

    if (!isObjectExisiting) {
      FloweringModel newFloweringObject = FloweringModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );

      Provider.of<FloweringProvider>(
        context,
        listen: false,
      ).updateFloweringObject(
        newFloweringObject,
        false,
      );
    }

    final FloweringModel floweringObject = Provider.of<FloweringProvider>(
      context,
      listen: true,
    ).findByPlot(plotId);

    final FloweringModel updatedFloweringObject =
        Provider.of<FloweringProvider>(
      context,
      listen: false,
    ).findByPlot(plotId);

    void growingCycleAppreciationHandler(value) {
      updatedFloweringObject.growingCycleAppreciation = value;
    }

    void growingCycleAppreciationCommentsHandler(value) {
      updatedFloweringObject.growingCycleAppreciationComments = value;
    }

    void pestResistanceHandler(value) {
      updatedFloweringObject.pestResistance = value;
    }

    void pestResistanceCommentsHandler(value) {
      updatedFloweringObject.pestResistanceComments = value;
    }

    void diseasesResistanceHandler(value) {
      updatedFloweringObject.diseasesResistance = value;
    }

    void diseasesResistanceCommentsHandler(value) {
      updatedFloweringObject.diseasesResistanceComments = value;
    }

    void onSubmitHandler() {
      updatedFloweringObject.lastUpdated = DateTime.now();
      updatedFloweringObject.isUpToDateInServer = 'No';

      Provider.of<FloweringProvider>(
        context,
        listen: false,
      ).updateFloweringObject(
        updatedFloweringObject,
        true,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: isFarmer!
            ? Text(
                'Maluwa - Plot $plotId',
              )
            : Text(
                'Flowering - Plot $plotId',
              ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Growing Cycle Appreciation',
            subtitle: floweringObject.growingCycleAppreciation,
            value: floweringObject.growingCycleAppreciation,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: growingCycleAppreciationHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Too Early Maturing',
              '2-Early Maturing',
              '3-Adapted For The Locality',
              '4-Late Maturing',
              '5-Too Late Maturing',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: growingCycleAppreciationCommentsHandler,
            genComSubtitle: floweringObject.growingCycleAppreciationComments,
          ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: isFarmer ? 'Kukakaniza Kwa Tudoyo' : 'Pest Resistance',
              subtitle: floweringObject.pestResistance,
              value: floweringObject.pestResistance,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: pestResistanceHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very High',
                '2-High',
                '3-Moderate',
                '4-Low',
                '5-Very Low',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: pestResistanceCommentsHandler,
              genComSubtitle: floweringObject.pestResistanceComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: isFarmer ? 'Kukakaniza Kwa Matenda' : 'Disease Resistance',
              subtitle: floweringObject.diseasesResistance,
              value: floweringObject.diseasesResistance,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: diseasesResistanceHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very High',
                '2-High',
                '3-Moderate',
                '4-Low',
                '5-Very Low',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: diseasesResistanceCommentsHandler,
              genComSubtitle: floweringObject.diseasesResistanceComments,
            ),
        ],
      ),
      floatingActionButton: PlotsFloatingButtons(
        routeName: routeName,
        crop: crop,
        plotId: plotId,
      ),
    );
  }
}
