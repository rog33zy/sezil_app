import 'package:flutter/material.dart';

import '../constants/SeasonCrop.dart';
import '../constants/Varieties.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';
import './PlotScreen.dart';

class TraitsScreen extends StatelessWidget {
  const TraitsScreen({Key? key}) : super(key: key);
  static const routeName = '/plots-screen';

  static final listOfVarieties = Varieties.varieties[SeasonCrop.Crop] as List;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plots'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listOfVarieties.length,
          (index) {
            return HomePageScreenOption(
              title: listOfVarieties[index],
              routeName: PlotScreen.routeName,
              argument: listOfVarieties[index],
            );
          },
        ),
      ),
    );
  }
}
