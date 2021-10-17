import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class FloweringScreen extends StatelessWidget {
  const FloweringScreen({Key? key}) : super(key: key);

  static const routeName = '/flowering';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotName = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowering - Plot $plotName'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Growing Cycle Appreciation',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: <String>[
              '1-Too Early Maturing',
              '2-Early Maturing',
              '3-Adapted For The Locality',
              '4-Late Maturing',
              '5-Too Late Maturing',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Pest Resistance',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very High',
              '2-High',
              '3-Moderate',
              '4-Low',
              '5-Very Low',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Disease Resistance',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very High',
              '2-High',
              '3-Moderate',
              '4-Low',
              '5-Very Low',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
