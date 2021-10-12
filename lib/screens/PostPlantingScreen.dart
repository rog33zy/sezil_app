import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PostPlantingScreen extends StatelessWidget {
  const PostPlantingScreen({Key? key}) : super(key: key);

  static const routeName = '/post-planting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Planting'),
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Seedling Vigour',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very Good',
              '2-Good',
              '3-Fair',
              '4-Bad',
              '5-Very Bad',
            ],
            isTrait: true,
          ),
          ListWidgetComponent(
            title: 'Plant Stand',
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
