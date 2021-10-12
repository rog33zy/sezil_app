import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenericTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final String? Function(String?) validator;
  final bool isReadOnlyMode;
  final bool isNumberField;
  final bool isDateField;
  final Function? updateDateInAllInputsMap;
  final Function? updateTextFieldInAllInputsMap;
  final int? maxLines;

  const GenericTextField({
    required this.labelText,
    required this.validator,
    this.initialValue,
    this.isReadOnlyMode = false,
    this.isNumberField = false,
    this.isDateField = false,
    this.updateDateInAllInputsMap,
    this.updateTextFieldInAllInputsMap,
    this.maxLines,
  });

  @override
  _GenericTextFieldState createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  DateTime? _selectedDate;
  String? _currentValue;

  var dateController = TextEditingController();

  @override
  void initState() {
    if (widget.isDateField && widget.initialValue != null) {
      setState(() {
        dateController = TextEditingController(
          text: DateFormat.yMMMd().format(
            DateTime.parse(widget.initialValue!),
          ),
        );
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  _onSelectDate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
    });
    dateController.text = DateFormat.yMMMd().format(pickedDate);
    widget.updateDateInAllInputsMap!(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: TextFormField(
        maxLines: widget.maxLines,
        enabled: widget.isReadOnlyMode == false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 8,
          ),
        ),
        initialValue: widget.isDateField ? null : widget.initialValue,
        textInputAction: TextInputAction.next,
        keyboardType: widget.isNumberField ? TextInputType.number : null,
        validator: widget.validator,
        onTap: widget.isDateField ? _onSelectDate : null,
        controller: widget.isDateField ? dateController : null,
        onChanged: (value) {
          try {
            setState(() {
              _currentValue = value;
            });
            widget.updateTextFieldInAllInputsMap!(_currentValue);
          } catch (error) {
            return;
          }
          
        },
      ),
    );
  }
}
