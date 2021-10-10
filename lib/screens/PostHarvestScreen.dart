import 'package:flutter/material.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PostHarvestScreen extends StatelessWidget {
  const PostHarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/post-harvest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post-Harvest'),
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
          ),
          ListWidgetComponent(
            title: 'Grain Hardness',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Panicles per Plot (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Heads (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Pods (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Grain Yield (Kg)',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Grain Size',
            subtitle: 'Blank',
            value: 'Blank',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Grain Colour',
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
