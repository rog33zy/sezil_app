import 'package:flutter/material.dart';

class HomePageFloatingActionButtonComp extends StatelessWidget {
  const HomePageFloatingActionButtonComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: 'HomePage',
        tooltip: "Homepage",
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        backgroundColor: Color(0xFFFF6C00),
        child: Icon(
          Icons.house,
        ),
      ),
    );
  }
}
