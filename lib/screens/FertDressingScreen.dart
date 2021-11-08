import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import './DetailedFertilizationScreen.dart';

class FertDressingScreen extends StatelessWidget {
  const FertDressingScreen({Key? key}) : super(key: key);

  static const routeName = '/fert-dressing';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final season = argumentsMap['argument'];

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

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
            title: isFarmer! ? 'Fataleza Wa Pansi' : 'Basal Dressing',
            routeName: DetailedFertilizationScreen.routeName,
            argument: {
              'typeOfDressing': 'Basal',
              'season': season,
            },
          ),
          HomePageScreenOption(
            title: isFarmer ? 'Fataleza Wo Belekesa' : 'Top Dressing',
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
