import "package:flutter/material.dart";

import '../components/homePageScreen/HomePageScreenOption.dart';
import './PlotScreen.dart';

class TraitsScreen extends StatelessWidget {
  const TraitsScreen({Key? key}) : super(key: key);
  static const routeName = "/plots-screen";

  static const listOfVarieties = [
    "101",
    "102",
    "103",
    "104",
    "105",
    "106",
    "201",
    "202",
    "203",
    "204",
    "205",
    "206",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plots"),
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
