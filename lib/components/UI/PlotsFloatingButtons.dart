import 'package:flutter/material.dart';

import '../../helpers/next_field_helper.dart';

import './NextPlotFloatingActionButtonComp.dart';
import './HomePageFloatingActionButtonComp.dart';

class PlotsFloatingButtons extends StatelessWidget {
  const PlotsFloatingButtons({
    Key? key,
    required this.routeName,
    required this.crop,
    required this.plotId,
  }) : super(key: key);

  final String routeName;
  final String crop;
  final String plotId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        NextPlotFloatingActionButtonComp(
          routeName: routeName,
          argument: NextFieldHelper.findNextFieldPlotId(
            crop,
            plotId,
          ),
        ),
        SizedBox(
          height: 14,
        ),
        HomePageFloatingActionButtonComp(),
      ],
    );
  }
}
