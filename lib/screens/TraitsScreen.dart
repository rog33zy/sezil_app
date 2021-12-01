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
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final String crop = authProvider.crop;
    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    return Scaffold(
      appBar: AppBar(
        title: isFarmer! ? const Text('Maonekedwe ') : const Text('Traits'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(
              height: 10.0,
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Pambuyo Po Byala' : 'Post-Planting',
              routeName: PlotsScreen.routeName,
              argument: PostPlantingScreen.routeName,
              argument2: isFarmer ? 'Pambuyo Po Byala' : 'Post Planting',
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Maluwa' : 'Flowering',
              routeName: PlotsScreen.routeName,
              argument: FloweringScreen.routeName,
              argument2: isFarmer ? 'Maluwa' : 'Flowering',
            ),
            if (crop != 'Sorghum')
              HomePageScreenOption(
                title: isFarmer ? 'Posatila Maluwa' : 'Post-Flowering',
                routeName: PlotsScreen.routeName,
                argument: PostFloweringScreen.routeName,
                argument2: isFarmer ? 'Posatila Maluwa' : 'Post Flowering',
              ),
            HomePageScreenOption(
              title: isFarmer ? 'Musana Kolole' : 'Pre-Harvest',
              routeName: PlotsScreen.routeName,
              argument: PreHarvestScreen.routeName,
              argument2: isFarmer ? 'Musana Kolole' : 'Pre Harvest',
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Kukolola' : 'Harvest',
              routeName: PlotsScreen.routeName,
              argument: HarvestScreen.routeName,
              argument2: isFarmer ? 'Kukolola' : 'Harvest',
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Pambuyo Po Kolola' : 'Post-Harvest',
              routeName: PlotsScreen.routeName,
              argument: PostHarvestScreen.routeName,
              argument2: isFarmer ? 'Pambuyo Po Kolola' : 'Post Harvest',
            ),
          ],
        ),
      ),
    );
  }
}
