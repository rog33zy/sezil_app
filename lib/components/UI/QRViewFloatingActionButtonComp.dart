import 'package:flutter/material.dart';

class QRViewFloatingActionButtonComp extends StatelessWidget {
  const QRViewFloatingActionButtonComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: 'QRView',
        tooltip: "Scan QR Code",
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(
          Icons.house,
        ),
      ),
    );
  }
}
