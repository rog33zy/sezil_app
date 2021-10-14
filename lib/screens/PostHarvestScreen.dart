import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PostHarvestScreen extends StatelessWidget {
  const PostHarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/post-harvest';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotName = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Harvest - Plot $plotName'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Yield of Dried Cobs (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Grain Hardness',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very Soft',
              '2-Soft',
              '3-Medium',
              '4-Hard',
              '5-Very Hard',
            ],
            isTrait: true,
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Panicles per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Heads (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Pods (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Grain Yield (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isNumberField: true,
          ),
          ListWidgetComponent(
            title: 'Grain Size',
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
            isTextField: false,
          ),
          ListWidgetComponent(
            title: 'Grain Colour',
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
            isTextField: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
