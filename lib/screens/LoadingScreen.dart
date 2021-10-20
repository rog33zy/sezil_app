import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          child: Image.asset(
            'assets/images/gna_source_logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
