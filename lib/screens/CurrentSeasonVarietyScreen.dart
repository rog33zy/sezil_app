import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import '../providers/CurrentSeasonVarietyProvider.dart';

import '../models/CurrentSeasonVarietyModel.dart';

import '../constants/Seasons.dart';

import '../components/UI/ListWidgetComponent.dart';

class CurrentSeasonVarietyScreen extends StatefulWidget {
  const CurrentSeasonVarietyScreen({Key? key}) : super(key: key);

  static const routeName = '/current-season-variety';

  @override
  _CurrentSeasonVarietyScreenState createState() =>
      _CurrentSeasonVarietyScreenState();
}

class _CurrentSeasonVarietyScreenState
    extends State<CurrentSeasonVarietyScreen> {
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
      setState(() {
        updatedCurrentSeasonVarietyObject.varietyName = value.titleCase;
      });
    }

    void prevSeasonHarvestHandler(value) {
      setState(() {
        updatedCurrentSeasonVarietyObject.previousSeasonHarvest =
            double.parse(value);
      });
    }

    void prevSeasonHectarageHandler(value) {
      setState(() {
        updatedCurrentSeasonVarietyObject.previousSeasonHectarage =
            double.parse(value);
      });
    }

    void sourceOfSeedHandler(String value) {
      setState(() {
        updatedCurrentSeasonVarietyObject.sourceOfSeed = value.titleCase;
      });
    }

    void yearsGrownHandler(value) {
      setState(() {
        updatedCurrentSeasonVarietyObject.numberOfYearsGrown =
            int.parse(value);
      });
    }

    void percentGrownHandler(value) {
      setState(() {
        updatedCurrentSeasonVarietyObject.percentFarmersGrowingVariety =
            int.parse(value);
      });
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

    return Scaffold(
      appBar: AppBar(
        title: Text('${Seasons.currentSeason} Variety'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Variety\'s Name',
            subtitle: currentSeasonVarietyObject.varietyName,
            value: currentSeasonVarietyObject.varietyName,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: varietyNameHandler,
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: '${Seasons.previousSeason} Harvest (Kg)',
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
          ),
          ListWidgetComponent(
            title: '${Seasons.previousSeason} Hectarage Grown (ha)',
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
          ),
          ListWidgetComponent(
            title: 'Source of Seed',
            subtitle: currentSeasonVarietyObject.sourceOfSeed,
            value: currentSeasonVarietyObject.sourceOfSeed,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: sourceOfSeedHandler,
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: 'Num of Years You\'ve Grown This Variety',
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
          ),
          ListWidgetComponent(
            title: 'Percent of Farmers Who Grow This Variety in Village',
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
          ),
        ],
      ),
    );
  }
}
