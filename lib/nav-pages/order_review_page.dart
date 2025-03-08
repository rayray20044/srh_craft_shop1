import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';
import 'package:srhcraftshop/models/pickup_model.dart';
import 'package:srhcraftshop/services/pickup_service.dart';
import 'package:srhcraftshop/services/order_service.dart';
import 'package:srhcraftshop/nav-pages/successful_purchase.dart';
import 'package:srhcraftshop/nav-pages/payment_method_page.dart';

class OrderReviewPage extends StatefulWidget {
  final List<String>? productImages;
  final String? totalPrice;

  const OrderReviewPage({
    Key? key,
    this.productImages,
    this.totalPrice,
  }) : super(key: key);

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  String? selectedLocker;
  String? selectedPaymentMethod;
  final PickupService pickupService = PickupService();
  bool isLoading = false;

  // List of available lockers with their details
  final List<Map<String, dynamic>> lockers = [
    {
      'id': 'Locker #1',
      'name': 'Locker #1',
      'lastPickup': '23 hours ago',
      'status': 'Available'
    },
    {
      'id': 'Locker #2',
      'name': 'Locker #2',
      'lastPickup': '12 hours ago',
      'status': 'Available'
    },
    {
      'id': 'Locker #3',
      'name': 'Locker #3',
      'lastPickup': '1 hour ago',
      'status': 'Available'
    },
  ];

  // select payment method and update ui
  void _selectPaymentMethod() async {
    final selectedMethod = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodPage(
          orderId: "ORDER_1234",
          price: double.tryParse(widget.totalPrice ?? "0") ?? 0,
          cabinetNumber: selectedLocker ?? "Locker #1",
        ),
      ),
    );

    if (selectedMethod != null) {
      setState(() {
        selectedPaymentMethod = selectedMethod;
      });
    }
  }

  // order before pickup
  void _confirmOrder() async {
    if (selectedLocker == null || selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Please select a locker and payment method first!")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      // cart items from provider
      var cart = Provider.of<CartProvider>(context, listen: false);

      //convert cart items to order format
      List<Map<String, dynamic>> cartItems = cart.items.values.map((item) => {
        "product": item.id,
        "quantity": item.quantity,
        "price": {
          "netPrice": item.price,
          "currency": "EUR",
          "vatRate": 0.19
        }
      }).toList();

      String? orderDocumentId = await OrderService.createOrder(cartItems);
      if (orderDocumentId == null) {
        throw Exception("Failed to create order.");
      }

      print("✅ Order Created: $orderDocumentId");

      //pickup process
      Pickup? pickup = await pickupService.startPickup(orderDocumentId);

      if (pickup != null) {
        print("✅ Pickup Created: ${pickup.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessfulPurchasePage(
              pickup: pickup,
              totalPrice: cart.totalPrice,
              productImages: cart.items.values
                  .map((item) => item.thumbnail ?? 'https://via.placeholder.com/150')
                  .toList(),
            ),
          ),
        );
      } else {
        throw Exception("Error starting pickup.");
      }
    } catch (e) {
      print("Error in _confirmOrder: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    //access cart provider
    var cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [

            //top bar container with back button
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFBC5D5D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [

                  //back button and title row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFFE8E5E8)),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'ORDER OVERVIEW',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE8E5E8),
                              ),
                            ),
                          ),
                        ),

                        //empty sizedbox to center the title by balancing back button
                        SizedBox(width: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // products section with horizontal scrolling
                  _buildSectionCard(
                    title: 'Products',
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: cart.items.values.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: _buildProductItem(
                                item.title,
                                item.thumbnail ?? 'https://via.placeholder.com/150'
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // locker selection
                  _buildSectionCard(
                    title: 'Select Locker',
                    icon: Icons.shopping_cart_outlined,
                    child: DropdownButtonFormField<String>(
                      value: selectedLocker,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      hint: Text('Select a Locker'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLocker = newValue;
                        });
                      },
                      items: lockers.map((locker) {
                        return DropdownMenuItem<String>(
                          value: locker['id'],
                          child: Text(locker['name']),
                        );
                      }).toList(),
                    ),
                  ),

                  //payment Section
                  _buildSectionCard(
                    title: 'Payment',
                    icon: Icons.credit_card_outlined,
                    child: ListTile(
                      title: Text(selectedPaymentMethod ?? "Select a payment method"),
                      trailing: TextButton(
                        onPressed: _selectPaymentMethod,
                        child: Text("Change", style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ),

                  //total and place order button
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFBC5D5D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      children: [

                        //total amount row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '€ ${cart.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Place Order Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: isLoading ? null : _confirmOrder,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator(color: Color(0xFFBC5D5D))
                                      : Text(
                                    'PLACE ORDER',
                                    style: TextStyle(
                                      color: Color(0xFFBC5D5D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  if (!isLoading)
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String name, String imagePath) {
    return Column(
      children: [
        Image.network(imagePath, width: 80, height: 80, fit: BoxFit.cover),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionCard({required String title, IconData? icon, required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    if (icon != null) Icon(icon, size: 18, color: Colors.grey),
                    if (icon != null) SizedBox(width: 8),
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            child
          ],
        ),
      ),
    );
  }
}