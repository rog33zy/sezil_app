import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import '../providers/CurrentSeasonVarietyProvider.dart';
import '../providers/AuthProvider.dart';

import '../models/CurrentSeasonVarietyModel.dart';

import '../constants/Seasons.dart';

import '../components/UI/ListWidgetComponent.dart';

class CurrentSeasonVarietyScreen extends StatelessWidget {
  const CurrentSeasonVarietyScreen({Key? key}) : super(key: key);

  static const routeName = '/current-season-variety';

  @override
  Widget build(BuildContext context) {
    CurrentSeasonVarietyModel currentSeasonVarietyObject =
        Provider.of<CurrentSeasonVarietyProvider>(
      context,
      listen: true,
    ).getCurrentSeasonVarietyObject;

    CurrentSeasonVarietyModel updatedCurrentSeasonVarietyObject =
        Provider.of<CurrentSeasonVarietyProvider>(
      context,
      listen: false,
    ).getCurrentSeasonVarietyObject;

    void varietyNameHandler(String value) {
      updatedCurrentSeasonVarietyObject.varietyName = value.titleCase;
    }

    void prevSeasonHarvestHandler(value) {
      updatedCurrentSeasonVarietyObject.previousSeasonHarvest =
          double.parse(value);
    }

    void prevSeasonHectarageHandler(value) {
      updatedCurrentSeasonVarietyObject.previousSeasonHectarage =
          double.parse(value);
    }

    void sourceOfSeedHandler(String value) {
      updatedCurrentSeasonVarietyObject.sourceOfSeed = value.titleCase;
    }

    void yearsGrownHandler(value) {
      updatedCurrentSeasonVarietyObject.numberOfYearsGrown = int.parse(value);
    }

    void percentGrownHandler(value) {
      updatedCurrentSeasonVarietyObject.percentFarmersGrowingVariety =
          int.parse(value);
    }

    void onSubmitHandler() {
      updatedCurrentSeasonVarietyObject.lastUpdated = DateTime.now();
      updatedCurrentSeasonVarietyObject.isUpToDateInServer = 'No';

      Provider.of<CurrentSeasonVarietyProvider>(
        context,
        listen: false,
      ).updateCurrentSeasonVarietyObject(updatedCurrentSeasonVarietyObject);
      Navigator.of(context).pop();
    }

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final isFarmer = authProvider.isSezilMotherTrialFarmer;

    return Scaffold(
      appBar: AppBar(
        title: isFarmer!
            ? Text(
                '${Seasons.currentSeason} Mtundu Wa Mbeu',
                style: TextStyle(fontSize: 17.5),
              )
            : Text('${Seasons.currentSeason} Variety'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: isFarmer ? 'Dzina La Mbeu' : 'Variety\'s Name',
            subtitle: currentSeasonVarietyObject.varietyName,
            value: currentSeasonVarietyObject.varietyName,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: varietyNameHandler,
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Zokolola Za ${Seasons.previousSeason}'
                : '${Seasons.previousSeason} Harvest (Kg)',
            subtitle: currentSeasonVarietyObject.previousSeasonHarvest == null
                ? 'Blank'
                : currentSeasonVarietyObject.previousSeasonHarvest.toString(),
            value: currentSeasonVarietyObject.previousSeasonHarvest == null
                ? ''
                : currentSeasonVarietyObject.previousSeasonHarvest.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: prevSeasonHarvestHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Kukula Kwa Munda Munalima Mu ${Seasons.previousSeason} (Ha)'
                : '${Seasons.previousSeason} Hectarage Grown (ha)',
            subtitle: currentSeasonVarietyObject.previousSeasonHectarage == null
                ? 'Blank'
                : currentSeasonVarietyObject.previousSeasonHectarage.toString(),
            value: currentSeasonVarietyObject.previousSeasonHectarage == null
                ? ''
                : currentSeasonVarietyObject.previousSeasonHectarage.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: prevSeasonHectarageHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Komwe Munachosa Mbeu' : 'Source of Seed',
            subtitle: currentSeasonVarietyObject.sourceOfSeed,
            value: currentSeasonVarietyObject.sourceOfSeed,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: sourceOfSeedHandler,
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Dzaka Zomwe Mwakhala Mukulima Mbeu Iyi'
                : 'Num of Years You\'ve Grown This Variety',
            subtitle: currentSeasonVarietyObject.numberOfYearsGrown == null
                ? 'Blank'
                : currentSeasonVarietyObject.numberOfYearsGrown.toString(),
            value: currentSeasonVarietyObject.numberOfYearsGrown == null
                ? ''
                : currentSeasonVarietyObject.numberOfYearsGrown.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: yearsGrownHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Peresenti Ya Alimi Akulima Mbeu Iyi Mumuzi'
                : 'Percent of Farmers Who Grow This Variety in Village',
            subtitle:
                currentSeasonVarietyObject.percentFarmersGrowingVariety == null
                    ? 'Blank'
                    : currentSeasonVarietyObject.percentFarmersGrowingVariety
                        .toString(),
            value:
                currentSeasonVarietyObject.percentFarmersGrowingVariety == null
                    ? ''
                    : currentSeasonVarietyObject.percentFarmersGrowingVariety
                        .toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: percentGrownHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
        ],
      ),
    );
  }
}
