import 'package:flutter/material.dart';

import '../../screens/EditValueScreen.dart';
import '../../screens/EditCheckBoxesScreen.dart';

class ListWidgetComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final bool isDateField;
  final bool isNumberField;
  final Function onChangeDateValueHandler;
  final Function onChangeTextValueHandler;
  final Function onSubmitHandler;
  final bool isDropDownField;
  final List listOfValues;
  final bool isLeadingToCheckBoxScreen;
  final bool isTrait;

  ListWidgetComponent({
    required this.title,
    this.subtitle = "",
    this.value = "",
    this.isDateField = false,
    this.isNumberField = false,
    required this.onChangeDateValueHandler,
    required this.onChangeTextValueHandler,
    required this.onSubmitHandler,
    this.isDropDownField = false,
    this.listOfValues = const [],
    this.isLeadingToCheckBoxScreen = false,
    this.isTrait = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (isLeadingToCheckBoxScreen) {
          Navigator.of(context).pushNamed(
            EditCheckBoxesScreen.routeName,
            arguments: {
              "title": title,
              "onChangeTextValueHandler": onChangeTextValueHandler,
              "onSubmitHandler": onSubmitHandler,
              "listOfValues": listOfValues,
            },
          );
        } else {
          Navigator.of(context).pushNamed(
            EditValueScreen.routeName,
            arguments: {
              "title": title,
              "subtitle": value,
              "isDateField": isDateField,
              "isNumberField": isNumberField,
              "onChangeDateValueHandler": onChangeDateValueHandler,
              "onChangeTextValueHandler": onChangeTextValueHandler,
              "onSubmitHandler": onSubmitHandler,
              "isDropDownField": isDropDownField,
              "listOfValues": listOfValues,
              'isTrait': isTrait,
            },
          );
        }
      },
    );
  }
}
