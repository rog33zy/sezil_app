import 'package:flutter/material.dart';

import '../components/UI/LabeledCheckbox.dart';

class EditCheckBoxesScreen extends StatelessWidget {
  const EditCheckBoxesScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-check-boxes';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final title = argumentsMap['title'];
    final items = argumentsMap['listOfValues'] as List<dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return LabeledCheckbox(
            label: items[index]['label'],
            onChangedTwo: items[index]['onChanged'],
          );
        },
      ),
    );
  }
}
