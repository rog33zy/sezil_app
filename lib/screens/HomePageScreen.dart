import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Rodgers"),
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
