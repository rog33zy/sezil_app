import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import './FertDressingScreen.dart';

class FertilizationScreen extends StatelessWidget {
  const FertilizationScreen({Key? key}) : super(key: key);

  static const routeName = '/fertilization';

  static const listOfSeasons = [
    {
      'season': '2020-2021',
      'isClickable': true,
    },
    {
      'season': '2021-2022',
      'isClickable': true,
    },
    {
      'season': '2022-2023',
      'isClickable': false,
    },
    {
      'season': '2023-2024',
      'isClickable': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    return Scaffold(
      appBar: AppBar(
        title: isFarmer! ? Text('Fataleza') : Text('Fertilization'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listOfSeasons.length,
          (index) {
            return HomePageScreenOption(
              title: listOfSeasons[index]['season'] as String,
              routeName: FertDressingScreen.routeName,
              argument: listOfSeasons[index]['season'] as String,
              isClickable: listOfSeasons[index]['isClickable'] as bool,
            );
          },
        ),
      ),
    );
  }
}
