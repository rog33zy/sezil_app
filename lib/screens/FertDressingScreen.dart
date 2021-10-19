import 'package:flutter/material.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import './DetailedFertilizationScreen.dart';

class FertDressingScreen extends StatelessWidget {
  const FertDressingScreen({Key? key}) : super(key: key);

  static const routeName = '/fert-dressing';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final season = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Dressing'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          HomePageScreenOption(
            title: 'Basal Dressing',
            routeName: DetailedFertilizationScreen.routeName,
            argument: {
              'typeOfDressing': 'Basal',
              'season': season,
            },
          ),
          HomePageScreenOption(
            title: 'Top Dressing',
            routeName: DetailedFertilizationScreen.routeName,
            argument: {
              'typeOfDressing': 'Top',
              'season': season,
            },
          ),
        ],
      ),
    );
  }
}
