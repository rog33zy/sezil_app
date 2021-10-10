import 'package:flutter/material.dart';

class LabeledCheckbox extends StatefulWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.onChangedTwo,
  }) : super(key: key);

  final String label;
  final Function onChangedTwo;

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  bool? _isSelected = false;
  void onChanged(bool? newValue) {
    setState(() {
      _isSelected = newValue;
    });
    widget.onChangedTwo(
      _isSelected,
      widget.label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!_isSelected!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(widget.label)),
            Checkbox(
              value: _isSelected,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// /// This is the private State class that goes with MyStatefulWidget.
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return LabeledCheckbox(
//       label: 'This is the label text',
//       value: _isSelected,
//       onChanged: (bool newValue) {
//         setState(() {
//           _isSelected = newValue;
//         });
//       },
//     );
//   }
// }
