import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';

class PaymentMethodPage extends StatefulWidget {
  final String orderId;
  final double price;
  final String cabinetNumber;

  const PaymentMethodPage({
    Key? key,
    required this.orderId,
    required this.price,
    required this.cabinetNumber,
  }) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String _selectedMethod = 'Credit Card';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBC5D5D),
        title: const Text(
          'PAYMENT METHOD',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //credit card
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: const Text('Credit Card'),
                            trailing: _selectedMethod == 'Credit Card'
                                ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Icon(Icons.check, color: Colors.black),
                            )
                                : Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedMethod = 'Credit Card';
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // card display
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFF98D68C),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [

                              // card shadow
                              Positioned(
                                right: 0,
                                top: 20,
                                bottom: 20,
                                child: Container(
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(16),
                                    ),
                                  ),
                                ),
                              ),

                              // card content
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '**** 9000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Travel Card',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '&3,580.04',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // expiry date
                              Positioned(
                                top: 24,
                                right: 24,
                                child: Text(
                                  '01/22',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //card button
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, thickness: 1),

                  // Paypal
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/paypal_logo.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance_wallet, color: Colors.blue),
                      ),
                      title: const Text('PayPal'),
                      subtitle: const Text('xxxxxxxxxxxxxxxxxx'),
                      trailing: _selectedMethod == 'PayPal'
                          ? Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: const Icon(Icons.check, color: Colors.green, size: 20),
                      )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedMethod = 'PayPal';
                        });
                      },
                    ),
                  ),

                  const Divider(height: 1, thickness: 1),

                  // apple pay
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(Icons.apple),
                      title: const Text('Apple Pay'),
                      subtitle: const Text('**** 9000'),
                      trailing: _selectedMethod == 'Apple Pay'
                          ? Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.check, color: Colors.grey, size: 20),
                      )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedMethod = 'Apple Pay';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFBC5D5D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: _isProcessing
                ? null
                : () => _savePaymentMethodAndReturn(context, cartProvider),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ORDER REVIEW",
                  style: TextStyle(
                    color: const Color(0xFFBC5D5D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  color: const Color(0xFFBC5D5D),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _savePaymentMethodAndReturn(BuildContext context, CartProvider cartProvider) {
    setState(() {
      _isProcessing = true;
    });

    //return  payment method to orderrevpage
    Navigator.pop(context, _selectedMethod);
  }
}

