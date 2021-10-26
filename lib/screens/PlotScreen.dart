import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

import 'PostPlantingScreen.dart';
import 'FloweringScreen.dart';
import 'PreHarvestScreen.dart';
import 'HarvestScreen.dart';
import 'PostHarvestScreen.dart';
import 'PostFloweringScreen.dart';

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
    final plotId = argumentsMap['argument'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Plot $plotId'),
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
              argument: plotId,
            ),
            HomePageScreenOption(
              title: "Flowering",
              routeName: FloweringScreen.routeName,
              argument: plotId,
            ),
            if (crop != 'Sorghum')
              HomePageScreenOption(
                title: "Post-Flowering",
                routeName: PostFloweringScreen.routeName,
                argument: plotId,
              ),
            HomePageScreenOption(
              title: "Pre-Harvest",
              routeName: PreHarvestScreen.routeName,
              argument: plotId,
            ),
            HomePageScreenOption(
              title: "Harvest",
              routeName: HarvestScreen.routeName,
              argument: plotId,
            ),
            HomePageScreenOption(
              title: "Post-Harvest",
              routeName: PostHarvestScreen.routeName,
              argument: plotId,
            ),
          ],
        ),
      ),
    );
  }
}
