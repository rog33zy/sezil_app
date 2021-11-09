import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/FertilizationProvider.dart';
import '../providers/AuthProvider.dart';

import '../models/FertilizationModel.dart';

import '../components/UI/ListWidgetComponent.dart';

class DetailedFertilizationScreen extends StatelessWidget {
  const DetailedFertilizationScreen({Key? key}) : super(key: key);

  static const routeName = '/detailed-fertilization';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final season = argumentsMap['argument']['season'];
    final typeOfDressing = argumentsMap['argument']['typeOfDressing'];

    final bool isObjectExisiting = Provider.of<FertilizationProvider>(
      context,
      listen: false,
    ).isExisting(season, typeOfDressing);

    if (!isObjectExisiting) {
      FertilizationModel newFertilizationObject = FertilizationModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        typeOfDressing: typeOfDressing,
        season: season,
      );
      Provider.of<FertilizationProvider>(
        context,
        listen: false,
      ).updateFertilizationObject(
        newFertilizationObject,
        false,
      );
    }

    FertilizationModel fertilizationObject = Provider.of<FertilizationProvider>(
      context,
      listen: true,
    ).findFertObject(season, typeOfDressing);

    FertilizationModel updatedFertilizationObject =
        Provider.of<FertilizationProvider>(
      context,
      listen: false,
    ).findFertObject(season, typeOfDressing);

    void organicFertilizerHandler(value) {
      updatedFertilizationObject.nameOfOrganicFertilizer = value;
    }

    void syntheticFertilizerHandler(String value) {
      updatedFertilizationObject.nameOfSyntheticFertilizer = value;
    }

    void quantityAppliedHandler(value) {
      updatedFertilizationObject.quantityApplied = double.parse(value);
    }

    void timeOfApplicationHandler(value) {
      updatedFertilizationObject.timeOfApplication = value;
    }

    void onSubmitHandler() {
      updatedFertilizationObject.lastUpdated = DateTime.now();
      updatedFertilizationObject.isUpToDateInServer = 'No';

      Provider.of<FertilizationProvider>(
        context,
        listen: false,
      ).updateFertilizationObject(
        updatedFertilizationObject,
        true,
      );

      Navigator.of(context).pop();
    }

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    var chewaTypeOfDressing;

    if (typeOfDressing == 'Basal') {
      chewaTypeOfDressing = 'Wa Pansi';
    } else if (typeOfDressing == 'Top') {
      chewaTypeOfDressing = 'Wo Belekesa';
    }

    return Scaffold(
      appBar: AppBar(
        title: isFarmer!
            ? Text(
                '$season $chewaTypeOfDressing',
              )
            : Text(
                '$season $typeOfDressing Dressing',
                style: TextStyle(fontSize: 19),
              ),
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: isFarmer
                ? 'Fataleza Wopangidwa Kuzinthu Zamoyo'
                : 'Organic Fertilizer',
            subtitle: fertilizationObject.nameOfOrganicFertilizer,
            value: fertilizationObject.nameOfOrganicFertilizer,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: organicFertilizerHandler,
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
            listOfValues: isFarmer
                ? <String>[
                    'Manyowa a Ng\'ombe',
                    'Ena',
                    'Palibe',
                  ]
                : <String>[
                    'Kraal Manure',
                    'Other',
                    'None',
                  ],
            isDropDownField: true,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Fataleza Wopangidwa Kumankhwala'
                : 'Synthetic Fertilizer',
            subtitle: fertilizationObject.nameOfSyntheticFertilizer,
            value: fertilizationObject.nameOfSyntheticFertilizer,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: syntheticFertilizerHandler,
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
            listOfValues: isFarmer
                ? <String>[
                    'D Compount 10-20-10',
                    'Urea 46% N',
                    'Ammonium Nitrate',
                    'Ena',
                    'Palibe',
                  ]
                : <String>[
                    'D Compount 10-20-10',
                    'Urea 46% N',
                    'Ammonium Nitrate',
                    'Other',
                    'None',
                  ],
            isDropDownField: true,
            isTextField: false,
          ),
          ListWidgetComponent(
            title:
                isFarmer ? 'Unyingi Wa Fataleza (Kg)' : 'Quantity Applied (Kg)',
            subtitle: fertilizationObject.quantityApplied == null
                ? 'Blank'
                : fertilizationObject.quantityApplied.toString(),
            value: fertilizationObject.quantityApplied == null
                ? 'Blank'
                : fertilizationObject.quantityApplied.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: quantityAppliedHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title:
                isFarmer ? 'Nthawi Yo Thila Fataleza' : 'Time of Application',
            subtitle: fertilizationObject.timeOfApplication == null
                ? 'Blank'
                : _formatDate(
                    fertilizationObject.timeOfApplication,
                  ),
            value: fertilizationObject.timeOfApplication == null
                ? 'Blank'
                : fertilizationObject.timeOfApplication!.toIso8601String(),
            onChangeDateValueHandler: timeOfApplicationHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            isDateField: true,
            onChangeGenComValueHandler: () {},
          ),
        ],
      ),
    );
  }

  String _formatDate(dateTimeObject) {
    return DateFormat.yMMMd().format(dateTimeObject);
  }
}
