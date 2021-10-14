import 'package:flutter/material.dart';

import 'package:location/location.dart';

import '../components/UI/ListWidgetComponent.dart';

import '../constants/Seasons.dart';

class FieldProfileScreen extends StatelessWidget {
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

  Future<void> getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      print(locData.latitude);
      print(locData.longitude);
    } catch (error) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Field Size (ha)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Soil Type',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
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
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: getCurrentLocation,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.previousSeason} Season',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: cropTypes,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.seasonBeforeLast} Season',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: cropTypes,
            isTextField: false,
          ),
        ],
      ),
    );
  }
}
