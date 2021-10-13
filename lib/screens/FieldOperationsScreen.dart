import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/FieldOperationsProvider.dart';

import '../models/FieldOperationsModel.dart';

import '../components/UI/ListWidgetComponent.dart';

class FieldOperationsScreen extends StatefulWidget {
  const FieldOperationsScreen({Key? key}) : super(key: key);

  static const routeName = "/field-operations";

  @override
  _FieldOperationsScreenState createState() => _FieldOperationsScreenState();
}

class _FieldOperationsScreenState extends State<FieldOperationsScreen> {
  @override
  Widget build(BuildContext context) {
    FieldOperationsModel fieldOperationsModel =
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
      setState(() {
        updatedFieldOperationsObject.dateOfLandPreparation = value;
      });
    }

    void methodOfLandPrepHandler(value) {
      setState(() {
        updatedFieldOperationsObject.methodOfLandPreparation = value;
      });
    }

    void dateOfPlantingHandler(value) {
      setState(() {
        updatedFieldOperationsObject.dateOfPlanting = value;
      });
    }

    void dateOfThinningHandler(value) {
      setState(() {
        updatedFieldOperationsObject.dateOfThinning = value;
      });
    }

    void dateOfFirstWeedingHandler(value) {
      setState(() {
        updatedFieldOperationsObject.dateOfFirstWeeding = value;
      });
    }

    void dateOfSecondWeedingHandler(value) {
      setState(() {
        updatedFieldOperationsObject.dateOfSecondWeeding = value;
      });
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
        title: Text("Field Operations"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: "Date of Land Preparation",
            subtitle: fieldOperationsModel.dateOfLandPreparation == null
                ? "Blank"
                : _formatDate(fieldOperationsModel.dateOfLandPreparation!),
            value: fieldOperationsModel.dateOfLandPreparation == null
                ? "Blank"
                : fieldOperationsModel.dateOfLandPreparation!.toIso8601String(),
            isDateField: true,
            onChangeDateValueHandler: dateOfLandPrepHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: "Method of Land Preparation",
            subtitle: fieldOperationsModel.methodOfLandPreparation,
            value: fieldOperationsModel.methodOfLandPreparation,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: methodOfLandPrepHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              "Ploughing",
              "Ripping",
              "Planting-Basins",
              "By-Hand",
              "Other",
            ],
          ),
          ListWidgetComponent(
            title: "Date of Planting",
            value: fieldOperationsModel.dateOfPlanting == null
                ? "Blank"
                : fieldOperationsModel.dateOfPlanting!.toIso8601String(),
            subtitle: fieldOperationsModel.dateOfPlanting == null
                ? "Blank"
                : _formatDate(fieldOperationsModel.dateOfPlanting!),
            isDateField: true,
            onChangeDateValueHandler: dateOfPlantingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: "Date of Thinning",
            value: fieldOperationsModel.dateOfThinning == null
                ? "Blank"
                : fieldOperationsModel.dateOfThinning!.toIso8601String(),
            subtitle: fieldOperationsModel.dateOfThinning == null
                ? "Blank"
                : _formatDate(fieldOperationsModel.dateOfThinning!),
            isDateField: true,
            onChangeDateValueHandler: dateOfThinningHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: "Date of First Weeding",
            value: fieldOperationsModel.dateOfFirstWeeding == null
                ? "Blank"
                : fieldOperationsModel.dateOfFirstWeeding!.toIso8601String(),
            subtitle: fieldOperationsModel.dateOfFirstWeeding == null
                ? "Blank"
                : _formatDate(fieldOperationsModel.dateOfFirstWeeding!),
            isDateField: true,
            onChangeDateValueHandler: dateOfFirstWeedingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
          ),
          ListWidgetComponent(
            title: "Date of Second Weeding",
            value: fieldOperationsModel.dateOfSecondWeeding == null
                ? "Blank"
                : fieldOperationsModel.dateOfSecondWeeding!.toIso8601String(),
            subtitle: fieldOperationsModel.dateOfSecondWeeding == null
                ? "Blank"
                : _formatDate(fieldOperationsModel.dateOfSecondWeeding!),
            isDateField: true,
            onChangeDateValueHandler: dateOfSecondWeedingHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
          ),
        ],
      ),
    );
  }

  String _formatDate(dateTimeObject) {
    return DateFormat.yMMMd().format(dateTimeObject);
  }
}
