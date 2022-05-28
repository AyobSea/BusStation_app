import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:busproject/style/style.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class Barcode extends StatefulWidget {
  const Barcode({Key? key}) : super(key: key);

  @override
  _BarcodeState createState() => _BarcodeState();
}

  String _scanBarcode = 'Unknown';
  final Uri _url = Uri.parse(_scanBarcode);
class _BarcodeState extends State<Barcode> {

  

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: busbottom,
            body: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image(image: AssetImage('images/scanMe.png')),
                  ),
                  SizedBox(height: 20),
                  Container( // Container for button 
                    width: 180, 
                    child: ElevatedButton(
                      onPressed: () => scanQR(),
                      child: Text('Start barcode scan'),
                      style: secondButton,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    // textScaleFactor: 4,
                    text: 'Scan result : $_scanBarcode\n',
                  ),
                ])
            
            )
            );
  }

  Future<void> _onOpen(LinkableElement link) async {
    final url = 'please copy this link in your browser : $_scanBarcode\n';

  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) throw 'Could not launch $_url';
    }
}
