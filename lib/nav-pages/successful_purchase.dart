import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:srhcraftshop/models/pickup_model.dart';
import 'package:srhcraftshop/services/pickup_service.dart';

class SuccessfulPurchasePage extends StatefulWidget {
  final Pickup pickup; // pickup details
  final double totalPrice; // total price of purchase
  final List<String> productImages; // list of product images

  const SuccessfulPurchasePage({
    Key? key,
    required this.pickup,
    required this.totalPrice,
    required this.productImages,
  }) : super(key: key);

  @override
  _SuccessfulPurchasePageState createState() => _SuccessfulPurchasePageState();
}

class _SuccessfulPurchasePageState extends State<SuccessfulPurchasePage> {
  final PickupService pickupService = PickupService(); // pickup service instance
  String pickupStatus = "pending";  // track pickup status
  Timer? _statusTimer; // timer for checking pickup status

  @override
  void initState() {
    super.initState();
    _startMonitoringPickup(); // start checking pickup status
  }

  // check pickup status every second
  void _startMonitoringPickup() {
    _statusTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      Pickup? updatedPickup = await pickupService.getPickupStatus(widget.pickup.documentId);

      if (updatedPickup != null) {
        setState(() => pickupStatus = updatedPickup.progress);

        if (pickupStatus == "finished") {
          _statusTimer?.cancel();
          print("Pickup Completed!");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(" Pickup Completed!")),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _statusTimer?.cancel(); // stop timer when page is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // success message box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [

                  // checkmark icon
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // payment success message
                  Text(
                    'Payment Successful!',
                    style: TextStyle(
                      color: Color(0xFFBC5D5D),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // total price
                  Text(
                    'Amount paid: €${widget.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(height: 20, thickness: 1),

                  // purchased items label
                  Text(
                    'Purchased Items:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFBC5D5D)),
                  ),
                  const SizedBox(height: 5),

                  // show product images in a row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.productImages.map((imageUrl) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network('https://via.placeholder.com/150', width: 60, height: 60);
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Divider(height: 20, thickness: 1),

                  // qr code instructions
                  Text(
                    'Scan the QR code below at the cabinet scanner.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFBC5D5D),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // qr code display
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: widget.pickup.documentId.trim(),
                      version: QrVersions.auto,
                      size: 200,
                      gapless: false,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Column(
              children: [
                // warning banner
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFBC5D5D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: const Text(
                    '*Please make sure the door is shut otherwise there will be a penalty',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),

                // back home button
                Container(
                  width: double.infinity,
                  color: const Color(0xFF999999),
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        // navigate back to home screen
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BACK HOME',
                            style: TextStyle(
                              color: Color(0xFFBC5D5D),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFFBC5D5D),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
