import 'package:flutter/material.dart';

import '../constants/Seasons.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/LabeledCheckbox.dart';

class CurrentSeasonVarietyScreen extends StatefulWidget {
  const CurrentSeasonVarietyScreen({Key? key}) : super(key: key);

  static const routeName = '/current-season-variety';

  @override
  _CurrentSeasonVarietyScreenState createState() =>
      _CurrentSeasonVarietyScreenState();
}

class _CurrentSeasonVarietyScreenState
    extends State<CurrentSeasonVarietyScreen> {
  Set finalOptions = <String>{};
  bool reasonOneValue = false;
  bool reasonTwoValue = false;
  bool reasonThreeValue = false;

  void onChangedReasonOne(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      reasonOneValue = newValue;
      if (newValue) {
        finalOptions.add(pickedValue);
      } else {
        finalOptions.remove(pickedValue);
      }
    });
  }

  void onChangedReasonTwo(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      reasonTwoValue = newValue;
      if (newValue) {
        finalOptions.add(pickedValue);
      } else {
        finalOptions.remove(pickedValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List reasonsOptions = [
      {
        'label': 'Reason 1',
        'value': reasonOneValue,
        'onChanged': onChangedReasonOne,
      },
      {
        'label': 'Reason 2',
        'value': reasonTwoValue,
        'onChanged': onChangedReasonTwo,
      },
    ];
    print(finalOptions);
    return Scaffold(
      appBar: AppBar(
        title: Text('${Seasons.currentSeason} Variety'),
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Variety\'s Name',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Reasons for Growing Variety',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isLeadingToCheckBoxScreen: true,
            listOfValues: reasonsOptions,
          ),
          ListWidgetComponent(
            title: 'Main Features of Variety',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: '${Seasons.previousSeason} Harvest (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: '${Seasons.previousSeason} Hectarage Grown (ha)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Source of Seed',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Num of Years You\'ve Grown This Variety',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Percent of Farmers Who Grow This Variety in Village',
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
