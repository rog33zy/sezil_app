import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/FieldOperationsProvider.dart';
import '../providers/CurrentSeasonVarietyProvider.dart';
import '../providers/FertilizationProvider.dart';
import '../providers/FieldProfileProvider.dart';
import '../providers/PostPlantingProvider.dart';
import '../providers/FloweringProvider.dart';
import '../providers/PostFloweringProvider.dart';
import '../providers/PreHarvestProvider.dart';
import '../providers/HarvestProvider.dart';
import '../providers/PostHarvestProvider.dart';
import '../providers/AuthProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';
// import '../components/UI/QRViewFloatingActionButtonComp.dart';
import '../components/UI/AppDrawer.dart';

import 'FieldProfileScreen.dart';
import 'FieldOperationsScreen.dart';
// import 'CurrentSeasonVarietyScreen.dart';
import 'FertilizationScreen.dart';
import 'TraitsScreen.dart';

// import '../constants/Seasons.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    Provider.of<FieldOperationsProvider>(
      context,
      listen: false,
    ).fetchAndSetFieldOperationsObject();

    Provider.of<CurrentSeasonVarietyProvider>(
      context,
      listen: false,
    ).fetchAndSetCurrentSeasonVarietyObject();

    Provider.of<FertilizationProvider>(
      context,
      listen: false,
    ).fetchAndSetFertilizationObjects();

    Provider.of<FieldProfileProvider>(
      context,
      listen: false,
    ).fetchAndSetFieldProfileObject();

    Provider.of<PostPlantingProvider>(
      context,
      listen: false,
    ).fetchAndSetPostPlantingObjects();

    Provider.of<FloweringProvider>(
      context,
      listen: false,
    ).fetchAndSetFloweringObjects();

    Provider.of<PostFloweringProvider>(
      context,
      listen: false,
    ).fetchAndSetPostFloweringObjects();

    Provider.of<PreHarvestProvider>(
      context,
      listen: false,
    ).fetchAndSetPreHarvestObjects();

    Provider.of<HarvestProvider>(
      context,
      listen: false,
    ).fetchAndSetHarvestObjects();

    Provider.of<PostHarvestProvider>(
      context,
      listen: false,
    ).fetchAndSetPostHarvestObjects();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${authProvider.firstName!} 😃'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: const Color(0xFF257150),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            HomePageScreenOption(
              title: isFarmer! ? 'Maonekedwe' : 'Traits',
              routeName: TraitsScreen.routeName,
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Mbiri Ya Munda' : 'Field Profile',
              routeName: FieldProfileScreen.routeName,
            ),
            HomePageScreenOption(
              title: isFarmer ? 'Nchito Za Mumunda' : 'Field Operations',
              routeName: FieldOperationsScreen.routeName,
            ),
            // HomePageScreenOption(
            //   title: isFarmer
            //       ? '${Seasons.currentSeason} Mtundu Wa Mbeu'
            //       : '${Seasons.currentSeason} Variety',
            //   routeName: CurrentSeasonVarietyScreen.routeName,
            // ),
            HomePageScreenOption(
              title: isFarmer ? 'Fataleza' : 'Fertilization',
              routeName: FertilizationScreen.routeName,
            ),
          ],
        ),
      ),
      // floatingActionButton: QRViewFloatingActionButtonComp(),
      drawer: const AppDrawer(),
    );
  }
}
