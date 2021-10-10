import "package:flutter/material.dart";

import '../components/homePageScreen/HomePageScreenOption.dart';
import './PlotScreen.dart';

class TraitsScreen extends StatelessWidget {
  const TraitsScreen({Key? key}) : super(key: key);
  static const routeName = "/plots-screen";

  static const listOfVarieties = [
    "Lungwebungu-01",
    "Lungwebungu-02",
    "Wamusanga-01",
    "Wamusanga-02",
    "Bubebe-01",
    "Bubebe-02",
    "Lungwebungu-01",
    "Lungwebungu-02",
    "Wamusanga-01",
    "Wamusanga-02",
    "Bubebe-01",
    "Bubebe-02",
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
