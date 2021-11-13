import 'package:flutter/material.dart';

import 'package:recase/recase.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/FieldOperationsProvider.dart';
import '../providers/AuthProvider.dart';

import '../models/FieldOperationsModel.dart';

import '../components/UI/ListWidgetComponent.dart';

class FieldOperationsScreen extends StatefulWidget {
  const FieldOperationsScreen({Key? key}) : super(key: key);

  static const routeName = '/field-operations';

  @override
  State<FieldOperationsScreen> createState() => _FieldOperationsScreenState();
}

class _FieldOperationsScreenState extends State<FieldOperationsScreen> {
  var updatedFieldOperationsObject;
  Set finalOptionsSet = <String>{};
  var finalString;
  var ploughingValue;
  var rippingValue;
  var plantingBasinsValue;
  var byHandValue;
  var otherValue;

  @override
  void initState() {
    super.initState();

    updatedFieldOperationsObject = Provider.of<FieldOperationsProvider>(
      context,
      listen: false,
    ).getFieldOperationsObject;

    finalOptionsSet =
        updatedFieldOperationsObject.methodOfLandPreparation.split(',').toSet();
    ploughingValue = finalOptionsSet.contains('Ploughing') ||
        finalOptionsSet.contains('Geje');
    rippingValue = finalOptionsSet.contains('Ripping') ||
        finalOptionsSet.contains('Maripa');
    plantingBasinsValue = finalOptionsSet.contains('Planting-Basins') ||
        finalOptionsSet.contains('Mazenge');
    byHandValue = finalOptionsSet.contains('By-Hand') ||
        finalOptionsSet.contains('Manja');
    otherValue =
        finalOptionsSet.contains('Other') || finalOptionsSet.contains('Zina');

    finalString = finalOptionsSet.join(',');
  }

  void onChangedPloughingValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      ploughingValue = newValue;
      optionHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedRippingValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      rippingValue = newValue;
      optionHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedPlantingBasinsValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      plantingBasinsValue = newValue;
      optionHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedByHandValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      byHandValue = newValue;
      optionHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedOtherValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      otherValue = newValue;
      optionHandler(
        newValue,
        pickedValue,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    FieldOperationsModel fieldOperationsObject =
        Provider.of<FieldOperationsProvider>(
      context,
      listen: true,
    ).getFieldOperationsObject;

    List methodOfLandPreparationOptions = [
      {
        'label': isFarmer! ? 'Geje' : 'Ploughing',
        'value': ploughingValue as bool,
        'onChanged': onChangedPloughingValue,
      },
      {
        'label': isFarmer ? 'Maripa' : 'Ripping',
        'value': rippingValue as bool,
        'onChanged': onChangedRippingValue,
      },
      {
        'label': isFarmer ? 'Mazenge' : 'Planting-Basins',
        'value': plantingBasinsValue as bool,
        'onChanged': onChangedPlantingBasinsValue,
      },
      {
        'label': isFarmer ? 'Manja' : 'By-Hand',
        'value': byHandValue as bool,
        'onChanged': onChangedByHandValue,
      },
      {
        'label': isFarmer ? 'Zina' : 'Other',
        'value': otherValue as bool,
        'onChanged': onChangedOtherValue,
      },
    ];

    void dateOfLandPrepHandler(value) {
      updatedFieldOperationsObject.dateOfLandPreparation = value;
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

    void firstWeedingIsManualHandler(value) {
      updatedFieldOperationsObject.firstWeedingIsManual = value;
    }

    void firstWeedingHerbicideNameHandler(String value) {
      updatedFieldOperationsObject.firstWeedingHerbicideName = value.titleCase;
    }

    void firstWeedingHerbicideQtyHandler(String value) {
      updatedFieldOperationsObject.firstWeedingHerbicideQty =
          double.parse(value.titleCase);
    }

    void dateOfPesticideApplicationHandler(value) {
      updatedFieldOperationsObject.dateOfPesticideApplication = value;
    }

    void pesticideNameHandler(String value) {
      updatedFieldOperationsObject.pesticideName = value.titleCase;
    }

    void pesticideApplicationQtyHandler(String value) {
      updatedFieldOperationsObject.pesticideApplicationQty =
          double.parse(value.titleCase);
    }

    void dateOfSecondWeedingHandler(value) {
      updatedFieldOperationsObject.dateOfSecondWeeding = value;
    }

    void secondWeedingIsManualHandler(value) {
      updatedFieldOperationsObject.secondWeedingIsManual = value;
    }

    void secondWeedingHerbicideNameHandler(String value) {
      updatedFieldOperationsObject.secondWeedingHerbicideName = value.titleCase;
    }

    void secondWeedingHerbicideQtyHandler(String value) {
      updatedFieldOperationsObject.secondWeedingHerbicideQty =
          double.parse(value.titleCase);
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
        title: isFarmer ? Text('Nchito Za Mumunda') : Text('Field Operations'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title:
                isFarmer ? 'Tsiku Lokonza Munda' : 'Date of Land Preparation',
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
            title: isFarmer
                ? 'Njira Yo Konzela Munda'
                : 'Method of Land Preparation',
            subtitle: fieldOperationsObject.methodOfLandPreparation == ''
                ? 'Blank'
                : fieldOperationsObject.methodOfLandPreparation,
            value: fieldOperationsObject.methodOfLandPreparation,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: methodOfLandPreparationOptions,
            isTextField: false,
            isLeadingToCheckBoxScreen: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Tsiku Lo Byala' : 'Date of Planting',
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
            title: isFarmer ? 'Tsiku Lo Nyula Mbeu' : 'Date of Thinning',
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
            title:
                isFarmer ? 'Tsiku Lopalila Koyamba' : 'Date of First Weeding',
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
            title: isFarmer
                ? 'Muna Palila Ndi Manja Koyamba?'
                : 'Was First Weeding Manual?',
            subtitle: fieldOperationsObject.firstWeedingIsManual,
            value: fieldOperationsObject.firstWeedingIsManual,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: firstWeedingIsManualHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: isFarmer
                ? <String>[
                    'Inde',
                    'Ai',
                  ]
                : <String>[
                    'Yes',
                    'No',
                  ],
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Dzina La Munkhwala Wophera Udzu Munaswenzesa Kupalila Koyamba'
                : 'First Weeding Herbicide Name',
            subtitle: fieldOperationsObject.firstWeedingHerbicideName,
            value: fieldOperationsObject.firstWeedingHerbicideName,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: firstWeedingHerbicideNameHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Unyinji Wa Munkhwala Munaswenzesa Koyamba Muma Kg'
                : 'First Weeding Herbicide Qty (Kg)',
            subtitle: fieldOperationsObject.firstWeedingHerbicideQty == null
                ? 'Blank'
                : fieldOperationsObject.firstWeedingHerbicideQty.toString(),
            value: fieldOperationsObject.firstWeedingHerbicideQty == null
                ? 'Blank'
                : fieldOperationsObject.firstWeedingHerbicideQty.toString(),
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: firstWeedingHerbicideQtyHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Tsiku Lomwe Munaika Munkhwala Wophera Tudoyo'
                : 'Date of Pesticide Application',
            value: fieldOperationsObject.dateOfPesticideApplication == null
                ? 'Blank'
                : fieldOperationsObject.dateOfPesticideApplication!
                    .toIso8601String(),
            subtitle: fieldOperationsObject.dateOfPesticideApplication == null
                ? 'Blank'
                : _formatDate(
                    fieldOperationsObject.dateOfPesticideApplication!),
            isDateField: true,
            onChangeDateValueHandler: dateOfPesticideApplicationHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Dzina la Munkhwala Wophera Tudoyo Munaswenzesa'
                : 'Pesticide Name',
            subtitle: fieldOperationsObject.pesticideName,
            value: fieldOperationsObject.pesticideName,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: pesticideNameHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Unyinji Wa Munkhwala Munaswenzesa Muma Kg'
                : 'Pesticide Qty (Kg)',
            subtitle: fieldOperationsObject.pesticideApplicationQty == null
                ? 'Blank'
                : fieldOperationsObject.pesticideApplicationQty.toString(),
            value: fieldOperationsObject.pesticideApplicationQty == null
                ? 'Blank'
                : fieldOperationsObject.pesticideApplicationQty.toString(),
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: pesticideApplicationQtyHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Tsiku Lopalila Kachiwili'
                : 'Date of Second Weeding',
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
          ListWidgetComponent(
            title: isFarmer
                ? 'Muna Palila Ndi Manja Kachiwiri?'
                : 'Was Second Weeding Manual?',
            subtitle: fieldOperationsObject.secondWeedingIsManual,
            value: fieldOperationsObject.secondWeedingIsManual,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: secondWeedingIsManualHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: isFarmer
                ? <String>[
                    'Inde',
                    'Ai',
                  ]
                : <String>[
                    'Yes',
                    'No',
                  ],
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Dzina La Munkhwala Wophera Udzu Munaswenzesa Kupalila Kachiwiri'
                : 'Second Weeding Herbicide Name',
            subtitle: fieldOperationsObject.secondWeedingHerbicideName,
            value: fieldOperationsObject.secondWeedingHerbicideName,
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: secondWeedingHerbicideNameHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Unyinji Wa Munkhwala Munaswenzesa Kachiwiri Muma Kg'
                : 'Second Weeding Herbicide Qty (Kg)',
            subtitle: fieldOperationsObject.secondWeedingHerbicideQty == null
                ? 'Blank'
                : fieldOperationsObject.secondWeedingHerbicideQty.toString(),
            value: fieldOperationsObject.secondWeedingHerbicideQty == null
                ? 'Blank'
                : fieldOperationsObject.secondWeedingHerbicideQty.toString(),
            isDateField: false,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: secondWeedingHerbicideQtyHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: () {},
          ),
        ],
      ),
    );
  }

  String _formatDate(dateTimeObject) {
    return DateFormat.yMMMd().format(dateTimeObject);
  }

  void optionHandler(newValue, pickedValue) {
    if (newValue) {
      finalOptionsSet.add(pickedValue);
    } else {
      finalOptionsSet.remove(pickedValue);
    }
    finalOptionsSet.remove('Blank');

    finalString = finalOptionsSet.join(',');

    updatedFieldOperationsObject.methodOfLandPreparation = finalString;

    updatedFieldOperationsObject.lastUpdated = DateTime.now();
    updatedFieldOperationsObject.isUpToDateInServer = 'No';

    Provider.of<FieldOperationsProvider>(
      context,
      listen: false,
    ).updateFieldOperationsObject(updatedFieldOperationsObject);
  }
}
