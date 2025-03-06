import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/pickup_service.dart';

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // qr scanner key
  QRViewController? controller; // controller for qr scanner
  final PickupService pickupService = PickupService(); // pickup service instance
  String scanResult = ""; // store scanned qr code result

  // handle qr code scanning
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        scanResult = scanData.code ?? "Invalid QR Code"; // update scan result
      });

      if (scanResult.isNotEmpty) {
        bool success = await pickupService.completePickup(scanResult); // complete pickup

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Locker Unlocked! Pickup Complete.")),
          );
          controller.dispose(); // stop scanning
          Navigator.pop(context); // go back to previous screen
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code for Pickup")), // screen title
      body: QRView(key: qrKey, onQRViewCreated: onQRViewCreated), // qr scanner view
    );
  }
}

