import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import 'PostPlantingScreen.dart';
import 'FloweringScreen.dart';
import 'PreHarvestScreen.dart';
import 'HarvestScreen.dart';
import 'PostHarvestScreen.dart';

class PlotScreen extends StatelessWidget {
  PlotScreen({Key? key}) : super(key: key);

  static const routeName = "/plot-screen";

  @override
  Widget build(BuildContext context) {
    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;
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
              argument: plotName,
            ),
            HomePageScreenOption(
              title: "Flowering",
              routeName: FloweringScreen.routeName,
              argument: plotName,
            ),
            if (crop == 'Sunflower')
              HomePageScreenOption(
                title: "Post-Flowering",
                routeName: FloweringScreen.routeName,
                argument: plotName,
              ),
            HomePageScreenOption(
              title: "Pre-Harvest",
              routeName: PreHarvestScreen.routeName,
              argument: plotName,
            ),
            HomePageScreenOption(
              title: "Harvest",
              routeName: HarvestScreen.routeName,
              argument: plotName,
            ),
            HomePageScreenOption(
              title: "Post-Harvest",
              routeName: PostHarvestScreen.routeName,
              argument: plotName,
            ),
          ],
        ),
      ),
    );
  }
}
