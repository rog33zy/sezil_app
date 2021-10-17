import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/FieldOperationsProvider.dart';

import '../models/FieldOperationsModel.dart';

import '../components/UI/ListWidgetComponent.dart';

class FieldOperationsScreen extends StatelessWidget {
  const FieldOperationsScreen({Key? key}) : super(key: key);

  static const routeName = '/field-operations';

  @override
  Widget build(BuildContext context) {
    FieldOperationsModel fieldOperationsObject =
        Provider.of<FieldOperationsProvider>(
      context,
      listen: true,
    ).getFieldOperationsObject;

    FieldOperationsModel updatedFieldOperationsObject =
        Provider.of<FieldOperationsProvider>(
      context,
      listen: false,
    ).getFieldOperationsObject;

    void dateOfLandPrepHandler(value) {
      updatedFieldOperationsObject.dateOfLandPreparation = value;
    }

    void methodOfLandPrepHandler(value) {
      updatedFieldOperationsObject.methodOfLandPreparation = value;
    }

    void dateOfPlantingHandler(value) {
      updatedFieldOperationsObject.dateOfPlanting = value;
    }

    void dateOfThinningHandler(value) {
      updatedFieldOperationsObject.dateOfThinning = value;
    }

    void dateOfFirstWeedingHandler(value) {
      updatedFieldOperationsObject.dateOfFirstWeeding = value;
    }

    void dateOfSecondWeedingHandler(value) {
      updatedFieldOperationsObject.dateOfSecondWeeding = value;
    }

    void onSubmitHandler() {
      updatedFieldOperationsObject.lastUpdated = DateTime.now();
      updatedFieldOperationsObject.isUpToDateInServer = 'No';
      Provider.of<FieldOperationsProvider>(
        context,
        listen: false,
      ).updateFieldOperationsObject(updatedFieldOperationsObject);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Field Operations'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Date of Land Preparation',
            subtitle: fieldOperationsObject.dateOfLandPreparation == null
                ? 'Blank'
                : _formatDate(fieldOperationsObject.dateOfLandPreparation!),
            value: fieldOperationsObject.dateOfLandPreparation == null
                ? 'Blank'
                : fieldOperationsObject.dateOfLandPreparation!
                    .toIso8601String(),
            isDateField: true,
            onChangeDateValueHandler: dateOfLandPrepHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Method of Land Preparation',
            subtitle: fieldOperationsObject.methodOfLandPreparation,
            value: fieldOperationsObject.methodOfLandPreparation,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: methodOfLandPrepHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              'Ploughing',
              'Ripping',
              'Planting-Basins',
              'By-Hand',
              'Other',
            ],
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Date of Planting',
            value: fieldOperationsObject.dateOfPlanting == null
                ? 'Blank'
                : fieldOperationsObject.dateOfPlanting!.toIso8601String(),
            subtitle: fieldOperationsObject.dateOfPlanting == null
                ? 'Blank'
                : _formatDate(fieldOperationsObject.dateOfPlanting!),
            isDateField: true,
            onChangeDateValueHandler: dateOfPlantingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Date of Thinning',
            value: fieldOperationsObject.dateOfThinning == null
                ? 'Blank'
                : fieldOperationsObject.dateOfThinning!.toIso8601String(),
            subtitle: fieldOperationsObject.dateOfThinning == null
                ? 'Blank'
                : _formatDate(fieldOperationsObject.dateOfThinning!),
            isDateField: true,
            onChangeDateValueHandler: dateOfThinningHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Date of First Weeding',
            value: fieldOperationsObject.dateOfFirstWeeding == null
                ? 'Blank'
                : fieldOperationsObject.dateOfFirstWeeding!.toIso8601String(),
            subtitle: fieldOperationsObject.dateOfFirstWeeding == null
                ? 'Blank'
                : _formatDate(fieldOperationsObject.dateOfFirstWeeding!),
            isDateField: true,
            onChangeDateValueHandler: dateOfFirstWeedingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Date of Second Weeding',
            value: fieldOperationsObject.dateOfSecondWeeding == null
                ? 'Blank'
                : fieldOperationsObject.dateOfSecondWeeding!.toIso8601String(),
            subtitle: fieldOperationsObject.dateOfSecondWeeding == null
                ? 'Blank'
                : _formatDate(fieldOperationsObject.dateOfSecondWeeding!),
            isDateField: true,
            onChangeDateValueHandler: dateOfSecondWeedingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
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
