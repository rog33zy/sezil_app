import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/PreHarvestProvider.dart';

import '../models/PreHarvestModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/PlotsFloatingButtons.dart';

class PreHarvestScreen extends StatelessWidget {
  PreHarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/pre-harvest';

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

    void cobSizeAppreciationHandler(String value) {
      updatedPreHarvestObject.cobSizeAppreciation = value;
    }

    void cobSizeAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.cobSizeAppreciationComments = value;
    }

    void numberOfCobsPerPlantAppreciationHandler(String value) {
      updatedPreHarvestObject.numberOfCobsPerPlantAppreciation = value;
    }

    void numberOfCobsPerPlantAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.numberOfCobsPerPlantAppreciationComments = value;
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

    void numberOfHeadsAppreciationHandler(String value) {
      updatedPreHarvestObject.numberOfHeadsAppreciation = value;
    }

    void numberOfHeadsAppreciationCommentsHandler(String value) {
      updatedPreHarvestObject.numberOfHeadsAppreciationComments = value;
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
        title: isFarmer!
            ? Text('Musana Kolole - Plot $plotId')
            : Text('Pre Harvest - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: isFarmer
                  ? 'Kukanikiza Kwa Kupindika Pamwamba Pa Tsinde Pafupi Ndi Nthaka'
                  : 'Lodging Resistance',
              subtitle: preHarvestObject.lodgingResistance,
              value: preHarvestObject.lodgingResistance,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: lodgingResistanceHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Kukanikiza Kwambili',
                      '2-Kukanikiza',
                      '3-Kukanikiza Mwapakati',
                      '4-Kukanikiza Pangono',
                      '5-Kukanikiza Pangono Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer ? 'Chikhoko' : 'Husk Cover',
              subtitle: preHarvestObject.huskCover,
              value: preHarvestObject.huskCover,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: huskCoverHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Mbali Yonse',
                      '2-Mbai Ina',
                    ]
                  : <String>[
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
              title: isFarmer
                  ? 'Kuthokoza Kukula Kwa Cisonkho'
                  : 'Cob Size Appreciation',
              subtitle: preHarvestObject.cobSizeAppreciation,
              value: preHarvestObject.cobSizeAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: cobSizeAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
                      '1-Very Good',
                      '2-Good',
                      '3-Fair',
                      '4-Bad',
                      '5-Very Bad',
                    ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler: cobSizeAppreciationCommentsHandler,
              genComSubtitle: preHarvestObject.cobSizeAppreciationComments,
            ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: isFarmer
                  ? 'Kuthokoza Nambala Ya Zisononkho'
                  : 'Number of Cobs per Plant Appreciation',
              subtitle: preHarvestObject.numberOfCobsPerPlantAppreciation,
              value: preHarvestObject.numberOfCobsPerPlantAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfCobsPerPlantAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
                      '1-Very Good',
                      '2-Good',
                      '3-Fair',
                      '4-Bad',
                      '5-Very Bad',
                    ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler:
                  numberOfCobsPerPlantAppreciationCommentsHandler,
              genComSubtitle:
                  preHarvestObject.numberOfCobsPerPlantAppreciationComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: isFarmer
                  ? 'Kuthokoza Ku Talika Kwa Mbeu'
                  : 'Plant Height Appreciation',
              subtitle: preHarvestObject.plantHeight,
              value: preHarvestObject.plantHeight,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: plantHeightHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer ? 'Kuonongeka Ndi Mbalame' : 'Bird Damage',
              subtitle: preHarvestObject.birdDamage,
              value: preHarvestObject.birdDamage,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: birdDamageHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Kuonongeka Pang\'ono Kwambili',
                      '2-Kuonongeka Pang\'ono',
                      '3-Kuonongeka Mwa Pakati',
                      '4-Kuonongeka Kwambili',
                      '5-Kuonongeka Kwakulu Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer
                  ? 'Kuthokoza Nsonga Za Tiligu'
                  : 'Panicle Appreciation',
              subtitle: preHarvestObject.panicleAppreciation,
              value: preHarvestObject.panicleAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: panicleAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer
                  ? 'Kuthokoza Maonekedwe a Mbeu'
                  : 'Grain Quality Appreciation',
              subtitle: preHarvestObject.grainQualityAppreciation,
              value: preHarvestObject.grainQualityAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: grainQualityAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer
                  ? 'Kuthokoza Kukula Kwa Mutu'
                  : 'Head Size Appreciation',
              subtitle: preHarvestObject.headSizeAppreciation,
              value: preHarvestObject.headSizeAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: headSizeAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: isFarmer
                  ? 'Kuthokoza Nambala Ya Mitu'
                  : 'Number of Heads Appreciation',
              subtitle: preHarvestObject.numberOfHeadsAppreciation,
              value: preHarvestObject.numberOfHeadsAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfHeadsAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
                      '1-Very Good',
                      '2-Good',
                      '3-Fair',
                      '4-Bad',
                      '5-Very Bad',
                    ],
              isTrait: true,
              isTextField: false,
              onChangeGenComValueHandler:
                  numberOfHeadsAppreciationCommentsHandler,
              genComSubtitle:
                  preHarvestObject.numberOfHeadsAppreciationComments,
            ),
          if (crop == 'Beans')
            ListWidgetComponent(
              title: isFarmer
                  ? 'Kuthokoza Makulidwe a Mbeu'
                  : 'Plant Growth Habit Appreciation',
              subtitle: preHarvestObject.plantGrowthHabitAppreciation,
              value: preHarvestObject.plantGrowthHabitAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: plantGrowthHabitAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
              title: isFarmer
                  ? 'Kuthokoza Kutalika Kwa Nkhonje'
                  : 'Pod Length Appreciation',
              subtitle: preHarvestObject.podLengthAppreciation,
              value: preHarvestObject.podLengthAppreciation,
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: podLengthAppreciationHandler,
              onSubmitHandler: onSubmitHandler,
              isDropDownField: true,
              listOfValues: isFarmer
                  ? <String>[
                      '1-Bwino Kwambili',
                      '2-Bwino',
                      '3-Pakati Ni Pakati',
                      '4-Woipa',
                      '5-Woipa Kwambili',
                    ]
                  : <String>[
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
            title: isFarmer
                ? 'Kuzipeleka Kulima Nyengo Ikubwela'
                : 'Willingness to Cultivate Next Season',
            subtitle: preHarvestObject.willingnessToCultivateNextSeason,
            value: preHarvestObject.willingnessToCultivateNextSeason,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: willingnessHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: isFarmer
                ? <String>[
                    '1-Inde, Kwambili',
                    '2-Inde',
                    '3-Mulindichikayiko',
                    '4-Ai',
                    '5-Ai Kwambili',
                  ]
                : <String>[
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
      floatingActionButton: PlotsFloatingButtons(
        routeName: routeName,
        crop: crop,
        plotId: plotId,
      ),
    );
  }
}
