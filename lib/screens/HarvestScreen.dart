import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class HarvestScreen extends StatelessWidget {
  const HarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/harvest';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotName = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Harvest - Plot $plotName'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Date of Harvest',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDateField: true,
          ),
          ListWidgetComponent(
            title: 'Number of Plants per Plot',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Number of Harvested Cobs per Plot',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Harvested Cobs per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Number of Harvested Panicles per Plot',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Harvested Panicles per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Number of Harvested Heads per Plot',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Harvested Heads per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Number of Harvested Pods per Plot',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Harvested Pods per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
