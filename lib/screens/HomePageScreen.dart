import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/FieldOperationsProvider.dart';
import '../providers/CurrentSeasonVarietyProvider.dart';
import '../providers/FertilizationProvider.dart';
import '../providers/FieldProfileProvider.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';
import '../components/UI/FloatingActionButtonComp.dart';

import 'TraitsScreen.dart';
import 'FieldProfileScreen.dart';
import 'FieldOperationsScreen.dart';
import 'CurrentSeasonVarietyScreen.dart';
import 'FertilizationScreen.dart';

import '../constants/Seasons.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, Rodgers 😃"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            HomePageScreenOption(
              title: "Traits",
              routeName: TraitsScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Field Profile",
              routeName: FieldProfileScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Field Operations",
              routeName: FieldOperationsScreen.routeName,
            ),
            HomePageScreenOption(
              title: "${Seasons.currentSeason} Variety",
              routeName: CurrentSeasonVarietyScreen.routeName,
            ),
            HomePageScreenOption(
              title: "Fertilization",
              routeName: FertilizationScreen.routeName,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
