// import 'dart:developer';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'PlotScreen.dart';
import 'TraitsScreen.dart';

class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  static const routeName = '/qr-view';

  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         if (result != null)
          //           Text(
          //               'Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}')
          //         else
          //           Text('Scan a code'),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                 onPressed: () async {
          //                   await controller?.toggleFlash();
          //                   setState(() {});
          //                 },
          //                 child: FutureBuilder(
          //                   future: controller?.getFlashStatus(),
          //                   builder: (context, snapshot) {
          //                     return Text('Flash: ${snapshot.data}');
          //                   },
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                 onPressed: () async {
          //                   await controller?.flipCamera();
          //                   setState(() {});
          //                 },
          //                 child: FutureBuilder(
          //                   future: controller?.getCameraInfo(),
          //                   builder: (context, snapshot) {
          //                     if (snapshot.data != null) {
          //                       return Text(
          //                           'Camera facing ${describeEnum(snapshot.data!)}');
          //                     } else {
          //                       return Text('loading');
          //                     }
          //                   },
          //                 ),
          //               ),
          //             )
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result!.code == 'Bubebe-01') {
        Navigator.of(context).pushReplacementNamed(PlotScreen.routeName,
            arguments: {'argument': result!.code});
      } else {
        Navigator.of(context).pushReplacementNamed(TraitsScreen.routeName);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()} _onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No permission'),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
