import 'package:flutter/material.dart';

class FieldHistoryScreen extends StatelessWidget {
  const FieldHistoryScreen({Key? key}) : super(key: key);

  static const routeName = '/field-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field History'),
      ),
      body: Center(
        child: Text('This is the field history screen'),
      ),
    );
  }
}
