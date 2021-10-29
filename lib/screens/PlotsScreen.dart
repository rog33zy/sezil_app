import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../constants/Varieties.dart';

import '../components/homePageScreen/HomePageScreenOption.dart';

class PlotsScreen extends StatelessWidget {
  const PlotsScreen({Key? key}) : super(key: key);
  static const routeName = '/plots-screen';

  @override
  Widget build(BuildContext context) {
    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;

    final listOfVarieties = Varieties.varieties[crop] as List;

    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final routeName = argumentsMap['argument'];
    final traitsName = argumentsMap['argument2'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Plots - $traitsName'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listOfVarieties.length,
          (index) {
            return HomePageScreenOption(
              title: listOfVarieties[index],
              routeName: routeName,
              argument: listOfVarieties[index],
            );
          },
        ),
      ),
    );
  }
}
