import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class FloweringScreen extends StatelessWidget {
  const FloweringScreen({Key? key}) : super(key: key);

  static const routeName = '/flowering';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowering'),
      ),
      body: ListView(
        children:[
          ListWidgetComponent(
            title: 'Growing Cycle Appreciation',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Pest Resistance',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Disease Resistance',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
