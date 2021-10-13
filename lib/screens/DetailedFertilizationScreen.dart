import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';

class DetailedFertilizationScreen extends StatelessWidget {
  const DetailedFertilizationScreen({Key? key}) : super(key: key);

  static const routeName = '/detailed-fertilization';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final season = argumentsMap['argument'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$season Fert Details'),
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Type of Fertilizer',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Name of Fertilizer',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Quantity Applied (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Time of Application',
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
