import 'package:flutter/material.dart';

class HomePageScreenOption extends StatelessWidget {
  final String title;
  final String routeName;
  final String? argument;
  final bool isClickable;

  HomePageScreenOption({
    required this.title,
    required this.routeName,
    this.argument,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: InkWell(
        onTap: () {
          if (isClickable) {
            Navigator.of(context).pushNamed(
              routeName,
              arguments: {
                'argument': argument,
              },
            );
          } else {
            return null;
          }
        },
        child: Card(
          color: isClickable ? Theme.of(context).primaryColor : Colors.grey[500],
          elevation: 4.0,
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}
