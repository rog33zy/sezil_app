import 'package:flutter/material.dart';

import '../components/forms/GenericTextField.dart';
import '../components/forms/DropdownTextField.dart';

class EditValueScreen extends StatelessWidget {
  static const routeName = "/edit-value";

  final _formKey = GlobalKey<FormState>();

  String? Function(String?) generalValidator() {
    return (value) {
      if (value!.isEmpty) {
        return 'Please enter a value';
      }
      return null;
    };
  }

  String? Function(String?) dateOfBirthValidator() {
    return (value) {
      if (value == null || value.length <= 0) {
        return 'Please enter date of birth';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final title = argumentsMap['title'];
    final subtitle = argumentsMap['subtitle'];
    final isDateField = argumentsMap['isDateField'];
    final isNumberField = argumentsMap['isNumberField'];
    final onChangeTextValueHandler = argumentsMap['onChangeTextValueHandler'];
    final onChangeDateValueHandler = argumentsMap['onChangeDateValueHandler'];
    final onSubmitHandler = argumentsMap['onSubmitHandler'];
    final isDropDownField = argumentsMap['isDropDownField'];
    final listOfValues = argumentsMap['listOfValues'];
    final isTrait = argumentsMap['isTrait'];
    final isTextField = argumentsMap['isTextField'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: editValueForm(
        title,
        isNumberField,
        isDateField,
        subtitle,
        onChangeTextValueHandler,
        onChangeDateValueHandler,
        onSubmitHandler,
        isDropDownField,
        listOfValues,
        isTrait,
        isTextField,
      ),
    );
  }

  Form editValueForm(
    title,
    isNumberField,
    isDateField,
    subtitle,
    onChangeTextValueHandler,
    onChangeDateValueHandler,
    onSubmitHandler,
    isDropDownField,
    listOfValues,
    isTrait,
    isTextField,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          if (isTextField)
            GenericTextField(
              labelText: title,
              validator:
                  isDateField ? dateOfBirthValidator() : generalValidator(),
              isNumberField: isNumberField,
              isDateField: isDateField,
              initialValue: subtitle == "Blank" ? null : subtitle,
              updateTextFieldInAllInputsMap: onChangeTextValueHandler,
              updateDateInAllInputsMap: onChangeDateValueHandler,
            ),
          if (isDropDownField)
            DropdownTextField(
              listOfValues: listOfValues,
              labelText: title,
              hintText: "",
              initialValue: subtitle == "Blank" ? null : subtitle,
              updateDropDownValuesInAllInputsMap: onChangeTextValueHandler,
            ),
          if (isTrait)
            GenericTextField(
              labelText: 'General Comments',
              validator:
                  isDateField ? dateOfBirthValidator() : generalValidator(),
              isNumberField: isNumberField,
              isDateField: isDateField,
              initialValue: subtitle == "Blank" ? null : subtitle,
              updateTextFieldInAllInputsMap: onChangeTextValueHandler,
              updateDateInAllInputsMap: onChangeDateValueHandler,
              maxLines: 4,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 10,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 240),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onSubmitHandler();
                    }
                  },
                  child: const Text('Update Value'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
