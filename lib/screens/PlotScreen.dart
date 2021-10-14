import 'package:flutter/material.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import 'PostPlantingScreen.dart';
import 'FloweringScreen.dart';
import 'PreHarvestScreen.dart';
import 'HarvestScreen.dart';
import 'PostHarvestScreen.dart';

class PlotScreen extends StatelessWidget {
  const PlotScreen({Key? key}) : super(key: key);

  static const routeName = "/plot-screen";

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotName = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Plot $plotName'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            HomePageScreenOption(
              title: "Post-Planting",
              routeName: PostPlantingScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Flowering",
              routeName: FloweringScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Pre-Harvest",
              routeName: PreHarvestScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Harvest",
              routeName: HarvestScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Post-Harvest",
              routeName: PostHarvestScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}
