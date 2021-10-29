import 'package:flutter/material.dart';

class HomePageScreenOption extends StatelessWidget {
  final String title;
  final String routeName;
  final dynamic argument;
  final dynamic argument2;
  final bool isClickable;

  HomePageScreenOption({
    required this.title,
    required this.routeName,
    this.argument,
    this.isClickable = true,
    this.argument2 = '',
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
                'argument2': argument2,
              },
            );
          } else {
            return null;
          }
        },
        child: Card(
          color: isClickable ? Color(0xFF257150) : Colors.grey[500],
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
