import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  final List<String> listOfValues;
  final String labelText;
  final String? initialValue;
  final String hintText;
  final bool isRequired;
  final bool isReadOnlyMode;
  final Function? updateDropDownValuesInAllInputsMap;

  DropdownTextField({
    required this.listOfValues,
    required this.labelText,
    this.initialValue,
    required this.hintText,
    this.isRequired = true,
    this.isReadOnlyMode = false,
    this.updateDropDownValuesInAllInputsMap,
  });

  @override
  _DropdownTextFieldState createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  var _currentSelectedValue;

  @override
  void initState() {
    if (widget.initialValue != null) {
      setState(() {
        _currentSelectedValue = widget.initialValue;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),
        ),
        value: _currentSelectedValue,
        isDense: true,
        onChanged: widget.isReadOnlyMode ? null : (String? newValue) {
          setState(
            () {
              _currentSelectedValue = newValue!;
            },
          );
          widget.updateDropDownValuesInAllInputsMap!(_currentSelectedValue);
        },
        items: widget.listOfValues
            .map(
              (String value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ),
            )
            .toList(),
        validator: (value) {
          if (widget.isRequired) {
            if (value == null || value.isEmpty) {
              return "Please select a '${widget.labelText}' value";
            }
          }

          return null;
        },
      ),
    );
  }
}
