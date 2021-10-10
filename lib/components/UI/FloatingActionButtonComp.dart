import 'package:flutter/material.dart';

import '../../screens/QRViewScreen.dart';

class FloatingActionButtonComp extends StatelessWidget {
  const FloatingActionButtonComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Scan QR Code",
      onPressed: () {
        Navigator.of(context).pushNamed(QRViewScreen.routeName);
      },
      backgroundColor: Colors.deepOrangeAccent,
      child: Icon(
        Icons.camera_alt_outlined,
      ),
    );
  }
}
