import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helpers/id_generator_helper.dart';

import '../constants/SeasonCrop.dart';

import '../providers/PreHarvestProvider.dart';

import '../models/PreHarvestModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PreHarvestScreen extends StatelessWidget {
  const PreHarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/pre-harvest';

  final crop = SeasonCrop.Crop;

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<PreHarvestProvider>(
      context,
      listen: false,
    ).isExisting(plotId);
    if (!isObjectExisiting) {
      PreHarvestModel newPreHarvestObject = PreHarvestModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );
      Provider.of<PreHarvestProvider>(
        context,
        listen: false,
      ).updatePreHarvestObject(
        newPreHarvestObject,
        false,
      );
    }

    final PreHarvestModel preHarvestObject = Provider.of<PreHarvestProvider>(
      context,
      listen: true,
    ).findByPlot(plotId);

    final PreHarvestModel updatedPreHarvestObject =
        Provider.of<PreHarvestProvider>(
      context,
      listen: false,
    ).findByPlot(plotId);

    void lodgingResistanceHandler(String value) {
      updatedPreHarvestObject.lodgingResistance = value;
    }

    void lodgingResistanceCommentsHandler(String value) {
      updatedPreHarvestObject.lodgingResistanceComments = value;
    }

    void huskCoverHandler(String value) {
      updatedPreHarvestObject.huskCover = value;
    }

    void huskCoverCommentsHandler(String value) {
      updatedPreHarvestObject.huskCoverComments = value;
    }

    void cobSizeHandler(String value) {
      updatedPreHarvestObject.cobSize = value;
    }

    void cobSizeCommentsHandler(String value) {
      updatedPreHarvestObject.cobSizeComments = value;
    }

    void numberOfCobsPerPlantHandler(String value) {
      updatedPreHarvestObject.numberOfCobsPerPlant = value;
    }

    void numberOfCobsPerPlantCommentsHandler(String value) {
      updatedPreHarvestObject.numberOfCobsPerPlantComments = value;
    }

    void plantHeightHandler(String value) {
      updatedPreHarvestObject.plantHeight = value;
    }

    void plantHeightCommentsHandler(String value) {
      updatedPreHarvestObject.plantHeightComments = value;
    }

    void birdDamageHandler(String value) {
      updatedPreHarvestObject.birdDamage = value;
    }

    void birdDamageCommentsHandler(String value) {
      updatedPreHarvestObject.birdDamageComments = value;
    }

    void panicleAppreciationHandler(String value) {
      updatedPreHarvestObject.panicleAppreciation = value;
    }

    void panicleAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.panicleAppreciationComments = value;
    }

    void grainQualityAppreciationHandler(String value) {
      updatedPreHarvestObject.grainQualityAppreciation = value;
    }

    void grainQualityAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.grainQualityAppreciationComments = value;
    }

    void headSizeAppreciationHandler(String value) {
      updatedPreHarvestObject.headSizeAppreciation = value;
    }

    void headSizeAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.headSizeAppreciationComments = value;
    }

    void plantGrowthHabitAppreciationHandler(String value) {
      updatedPreHarvestObject.plantGrowthHabitAppreciation = value;
    }

    void plantGrowthHabitAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.plantGrowthHabitAppreciationComments = value;
    }

    void podLengthAppreciationHandler(String value) {
      updatedPreHarvestObject.podLengthAppreciation = value;
    }

    void podLengthAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.podLengthAppreciationComments = value;
    }

    void willingnessHandler(String value) {
      updatedPreHarvestObject.willingnessToCultivateNextSeason = value;
    }

    void willingnessCommentsHandler(String value) {
      updatedPreHarvestObject.willingnessToCultivateNextSeasonComments = value;
    }

    void onSubmitHandler() {
      updatedPreHarvestObject.lastUpdated = DateTime.now();
      updatedPreHarvestObject.isUpToDateInServer = 'No';

      Provider.of<PreHarvestProvider>(
        context,
        listen: false,
      ).updatePreHarvestObject(
        updatedPreHarvestObject,
        true,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pre Harvest - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: 'Lodging Resistance',
              subtitle: preHarvestObject.lodgingResistance,
              value: preHarvestObject.lodgingResistance,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: lodgingResistanceHandler,
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
              onChangeGenComValueHandler: lodgingResistanceCommentsHandler,
              genComSubtitle: preHarvestObject.lodgingResistanceComments,
            ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: 'Husk Cover',
              subtitle: preHarvestObject.huskCover,
              value: preHarvestObject.huskCover,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: huskCoverHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Fully',
                '2-Partially',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: huskCoverCommentsHandler,
              genComSubtitle: preHarvestObject.huskCoverComments,
            ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: 'Cob Size',
              subtitle: preHarvestObject.cobSize,
              value: preHarvestObject.cobSize,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: cobSizeHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: cobSizeCommentsHandler,
              genComSubtitle: preHarvestObject.cobSizeComments,
            ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: 'Number of Cobs per Plant',
              subtitle: preHarvestObject.numberOfCobsPerPlant,
              value: preHarvestObject.numberOfCobsPerPlant,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfCobsPerPlantHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: numberOfCobsPerPlantCommentsHandler,
              genComSubtitle: preHarvestObject.numberOfCobsPerPlantComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Plant Height',
              subtitle: preHarvestObject.plantHeight,
              value: preHarvestObject.plantHeight,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: plantHeightHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: plantHeightCommentsHandler,
              genComSubtitle: preHarvestObject.plantHeightComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Bird Damage',
              subtitle: preHarvestObject.birdDamage,
              value: preHarvestObject.birdDamage,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: birdDamageHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Slight Damage',
                '2-Light Damage',
                '3-Moderate',
                '4-Heavy',
                '5-Very Heavy',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: birdDamageCommentsHandler,
              genComSubtitle: preHarvestObject.birdDamageComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Panicle Appreciation',
              subtitle: preHarvestObject.panicleAppreciation,
              value: preHarvestObject.panicleAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: panicleAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: panicleAppreciationCommentsHandler,
              genComSubtitle: preHarvestObject.panicleAppreciationComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Grain Quality Appreciation',
              subtitle: preHarvestObject.grainQualityAppreciation,
              value: preHarvestObject.grainQualityAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: grainQualityAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler:
                  grainQualityAppreciationCommentsHandler,
              genComSubtitle: preHarvestObject.grainQualityAppreciationComments,
            ),
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: 'Head Size Appreciation',
              subtitle: preHarvestObject.headSizeAppreciation,
              value: preHarvestObject.headSizeAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: headSizeAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: headSizeAppreciationCommentsHandler,
              genComSubtitle: preHarvestObject.headSizeAppreciationComments,
            ),
          if (crop == 'Beans')
            ListWidgetComponent(
              title: 'Plant Growth Habit Appreciation',
              subtitle: preHarvestObject.plantGrowthHabitAppreciation,
              value: preHarvestObject.plantGrowthHabitAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: plantGrowthHabitAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler:
                  plantGrowthHabitAppreciationCommentsHandler,
              genComSubtitle:
                  preHarvestObject.plantGrowthHabitAppreciationComments,
            ),
          if (crop == 'Beans')
            ListWidgetComponent(
              title: 'Pod Length Appreciation',
              subtitle: preHarvestObject.podLengthAppreciation,
              value: preHarvestObject.podLengthAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: podLengthAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: <String>[
                '1-Very Good',
                '2-Good',
                '3-Fair',
                '4-Bad',
                '5-Very Bad',
              ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: podLengthAppreciationCommentsHandler,
              genComSubtitle: preHarvestObject.podLengthAppreciationComments,
            ),
          ListWidgetComponent(
            title: 'Willingness to Cultivate Next Season',
            subtitle: preHarvestObject.willingnessToCultivateNextSeason,
            value: preHarvestObject.willingnessToCultivateNextSeason,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: willingnessHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Yes, Very Sure',
              '2-Yes',
              '3-Perhaps, Not Sure',
              '4-No',
              '5-Definitely Not',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: willingnessCommentsHandler,
            genComSubtitle:
                preHarvestObject.willingnessToCultivateNextSeasonComments,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
