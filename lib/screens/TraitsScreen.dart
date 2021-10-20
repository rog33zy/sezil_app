import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../constants/Varieties.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';
import './PlotScreen.dart';

class TraitsScreen extends StatelessWidget {
  const TraitsScreen({Key? key}) : super(key: key);
  static const routeName = '/plots-screen';

  

  @override
  Widget build(BuildContext context) {
    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;

   final listOfVarieties = Varieties.varieties[crop] as List;
    return Scaffold(
      appBar: AppBar(
        title: Text('Plots'),
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
