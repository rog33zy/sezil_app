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
import 'PlotsScreen.dart';

class TraitsScreen extends StatelessWidget {
  TraitsScreen({Key? key}) : super(key: key);

  static const routeName = '/traits-screen';

  @override
  Widget build(BuildContext context) {
    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;
    return Scaffold(
      appBar: AppBar(
        title: Text('Traits'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            HomePageScreenOption(
              title: 'Post-Planting',
              routeName: PlotsScreen.routeName,
              argument: PostPlantingScreen.routeName,
              argument2: 'Post Planting',
            ),
            HomePageScreenOption(
              title: 'Flowering',
              routeName: PlotsScreen.routeName,
              argument: FloweringScreen.routeName,
              argument2: 'Flowering',
            ),
            if (crop != 'Sorghum')
              HomePageScreenOption(
                title: 'Post-Flowering',
                routeName: PlotsScreen.routeName,
                argument: PostFloweringScreen.routeName,
                argument2: 'Post Flowering',
              ),
            HomePageScreenOption(
              title: 'Pre-Harvest',
              routeName: PlotsScreen.routeName,
              argument: PreHarvestScreen.routeName,
              argument2: 'Pre Harvest',
            ),
            HomePageScreenOption(
              title: 'Harvest',
              routeName: PlotsScreen.routeName,
              argument: HarvestScreen.routeName,
              argument2: 'Harvest',
            ),
            HomePageScreenOption(
              title: 'Post-Harvest',
              routeName: PlotsScreen.routeName,
              argument: PostHarvestScreen.routeName,
              argument2: 'Post Harvest',
            ),
          ],
        ),
      ),
    );
  }
}
