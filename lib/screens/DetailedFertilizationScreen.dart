import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/FertilizationProvider.dart';

import '../models/FertilizationModel.dart';

import '../components/UI/ListWidgetComponent.dart';

class DetailedFertilizationScreen extends StatefulWidget {
  const DetailedFertilizationScreen({Key? key}) : super(key: key);

  static const routeName = '/detailed-fertilization';

  @override
  _DetailedFertilizationScreenState createState() =>
      _DetailedFertilizationScreenState();
}

class _DetailedFertilizationScreenState
    extends State<DetailedFertilizationScreen> {
  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final season = argumentsMap['argument'];

    FertilizationModel fertilizationObject = Provider.of<FertilizationProvider>(
      context,
      listen: true,
    ).findBySeason(season);

    FertilizationModel updatedFertilizationObject =
        Provider.of<FertilizationProvider>(
      context,
      listen: false,
    ).findBySeason(season);

    void typeOfFertilizationHandler(value) {
      setState(() {
        updatedFertilizationObject.typeOfFertilizer = value;
      });
    }

    void nameOfFertilizerHandler(value) {
      setState(() {
        updatedFertilizationObject.nameOfFertilizer = value;
      });
    }

    void quantityAppliedHandler(value) {
      setState(() {
        updatedFertilizationObject.quantityApplied = double.parse(value);
      });
    }

    void timeOfApplicationHandler(value) {
      setState(() {
        updatedFertilizationObject.timeOfApplication = value;
      });
    }

    void onSubmitHandler() {
      updatedFertilizationObject.lastUpdated = DateTime.now();
      updatedFertilizationObject.isUpToDateInServer = 'No';

      Provider.of<FertilizationProvider>(
        context,
        listen: false,
      ).updateFertilizationObject(updatedFertilizationObject);

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$season Fert Details'),
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Type of Fertilizer',
            subtitle: fertilizationObject.typeOfFertilizer,
            value: fertilizationObject.typeOfFertilizer,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: typeOfFertilizationHandler,
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: 'Name of Fertilizer',
            subtitle: fertilizationObject.nameOfFertilizer,
            value: fertilizationObject.nameOfFertilizer,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: nameOfFertilizerHandler,
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: 'Quantity Applied (Kg)',
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
          ),
          ListWidgetComponent(
            title: 'Time of Application',
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
          ),
        ],
      ),
    );
  }

  String _formatDate(dateTimeObject) {
    return DateFormat.yMMMd().format(dateTimeObject);
  }
}
