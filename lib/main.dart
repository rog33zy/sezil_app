import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './config/palette.dart';

import './providers/FieldOperationsProvider.dart';
import './providers/CurrentSeasonVarietyProvider.dart';

import './screens/HomePageScreen.dart';
import 'screens/TraitsScreen.dart';
import './screens/PlotScreen.dart';
import './screens/FieldOperationsScreen.dart';
import './screens/EditValueScreen.dart';
import './screens/FieldProfileScreen.dart';
import './screens/CurrentSeasonVarietyScreen.dart';
import './screens/FertilizationScreen.dart';
import './screens/DetailedFertilizationScreen.dart';
import './screens/PostPlantingScreen.dart';
import './screens/FloweringScreen.dart';
import './screens/PreHarvestScreen.dart';
import './screens/HarvestScreen.dart';
import './screens/PostHarvestScreen.dart';
import './screens/EditCheckBoxesScreen.dart';
import './screens/QRViewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FieldOperationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CurrentSeasonVarietyProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Palette.gnaColorSwatch,
        ),
        home: HomePageScreen(),
        routes: {
          TraitsScreen.routeName: (ctx) => TraitsScreen(),
          FieldProfileScreen.routeName: (ctx) => FieldProfileScreen(),
          FieldOperationsScreen.routeName: (ctx) => FieldOperationsScreen(),
          CurrentSeasonVarietyScreen.routeName: (ctx) =>
              CurrentSeasonVarietyScreen(),
          FertilizationScreen.routeName: (ctx) => FertilizationScreen(),
          PlotScreen.routeName: (ctx) => PlotScreen(),
          EditValueScreen.routeName: (ctx) => EditValueScreen(),
          DetailedFertilizationScreen.routeName: (ctx) =>
              DetailedFertilizationScreen(),
          PostPlantingScreen.routeName: (ctx) => PostPlantingScreen(),
          FloweringScreen.routeName: (ctx) => FloweringScreen(),
          PreHarvestScreen.routeName: (ctx) => PreHarvestScreen(),
          HarvestScreen.routeName: (ctx) => HarvestScreen(),
          PostHarvestScreen.routeName: (ctx) => PostHarvestScreen(),
          EditCheckBoxesScreen.routeName: (ctx) => EditCheckBoxesScreen(),
          QRViewScreen.routeName: (ctx) => QRViewScreen(),
        },
      ),
    );
  }
}
