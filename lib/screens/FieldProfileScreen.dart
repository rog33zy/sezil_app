import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';

import '../constants/Seasons.dart';

class FieldProfileScreen extends StatelessWidget {
  const FieldProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/field-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field Profile"),
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
          ),
          ListWidgetComponent(
            title: 'Soil Type',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Field Coordinates',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.previousSeason} Season',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Crop Grown ${Seasons.seasonBeforeLast} Season',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
        ],
      ),
    );
  }
}
