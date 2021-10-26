import 'package:flutter/material.dart';

class NextPlotFloatingActionButtonComp extends StatelessWidget {
  const NextPlotFloatingActionButtonComp({
    Key? key,
    required this.routeName,
    required this.argument,
  }) : super(key: key);

  final routeName;
  final argument;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'nextPlot',
      tooltip: 'Next Plot',
      // backgroundColor: Colors.deepOrange,
      onPressed: () {
        if (argument == '301') {
          Navigator.of(context).pushNamed('/');
        } else {
          Navigator.of(context).pushNamed(
            routeName,
            arguments: {
              'argument': argument,
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Plot Changed to $argument'),
              duration: const Duration(milliseconds: 1500),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 14.0, // Inner padding for SnackBar content.
              ),
            ),
          );
        }
      },
      child: Icon(
        Icons.arrow_right_alt_sharp,
      ),
    );
  }
}
