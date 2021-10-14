import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/FieldProfileProvider.dart';

import '../models/FieldProfileModel.dart';

import '../components/UI/ListWidgetComponent.dart';

import '../constants/Seasons.dart';

class FieldProfileScreen extends StatefulWidget {
  const FieldProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/field-profile';

  static const cropTypes = <String>[
    'Maize',
    'Sorghum',
    'Beans',
    'Soybeans',
    'Groundnuts',
    'Cowpeas',
    'Sunflower',
    'Fallow-Land',
    'Other',
  ];

  @override
  _FieldProfileScreenState createState() => _FieldProfileScreenState();
}

class _FieldProfileScreenState extends State<FieldProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FieldProfileModel fieldProfileObject = Provider.of<FieldProfileProvider>(
      context,
      listen: true,
    ).getFieldProfileObject;

    FieldProfileModel updatedFieldProfileObject =
        Provider.of<FieldProfileProvider>(
      context,
      listen: false,
    ).getFieldProfileObject;

    void fieldSizeHandler(value) {
      setState(() {
        updatedFieldProfileObject.fieldSize = double.parse(value);
      });
    }

    void soilTypeHandler(value) {
      setState(() {
        updatedFieldProfileObject.soilType = value;
      });
    }

    void fieldCoordinatesHandler() async {
      final locData = await Location().getLocation();

      updatedFieldProfileObject.latitude = locData.latitude;
      updatedFieldProfileObject.longitude = locData.longitude;

      updatedFieldProfileObject.lastUpdated = DateTime.now();
      updatedFieldProfileObject.isUpToDateInServer = 'No';

      Provider.of<FieldProfileProvider>(
        context,
        listen: false,
      ).updateFieldProfileObject(updatedFieldProfileObject);

      Navigator.of(context).pop();
    }

    void cropGrownPrevSeasonHandler(value) {
      setState(() {
        updatedFieldProfileObject.cropGrownPrevSeason = value;
      });
    }

    void cropGrownSeasonBeforeLastHandler(value) {
      setState(() {
        updatedFieldProfileObject.cropGrownTwoSeasonsAgo = value;
      });
    }

    void onSubmitHandler() {
      updatedFieldProfileObject.lastUpdated = DateTime.now();
      updatedFieldProfileObject.isUpToDateInServer = 'No';

      Provider.of<FieldProfileProvider>(
        context,
        listen: false,
      ).updateFieldProfileObject(updatedFieldProfileObject);

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Field Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Field Size (ha)',
            subtitle: fieldProfileObject.fieldSize == null
                ? 'Blank'
                : fieldProfileObject.fieldSize.toString(),
            value: fieldProfileObject.fieldSize == null
                ? 'Blank'
                : fieldProfileObject.fieldSize.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: fieldSizeHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Soil Type',
            subtitle: fieldProfileObject.soilType,
            value: fieldProfileObject.soilType,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: soilTypeHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            isTextField: false,
            listOfValues: <String>[
              'Light',
              'Heavy',
              'Other',
            ],
          ),
          ListWidgetComponent(
            title: 'Field Coordinates',
            subtitle: fieldProfileObject.latitude == null
                ? 'Blank'
                : '${fieldProfileObject.latitude}, ${fieldProfileObject.longitude}',
            value: fieldProfileObject.latitude == null
                ? 'Blank'
                : '${fieldProfileObject.latitude}, ${fieldProfileObject.longitude}',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: fieldCoordinatesHandler,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.previousSeason} Season',
            subtitle: fieldProfileObject.cropGrownPrevSeason,
            value: fieldProfileObject.cropGrownPrevSeason,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: cropGrownPrevSeasonHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: FieldProfileScreen.cropTypes,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.seasonBeforeLast} Season',
            subtitle: fieldProfileObject.cropGrownTwoSeasonsAgo,
            value: fieldProfileObject.cropGrownTwoSeasonsAgo,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: cropGrownSeasonBeforeLastHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: FieldProfileScreen.cropTypes,
            isTextField: false,
          ),
        ],
      ),
    );
  }
}
