import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/services/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200], // Light grey background
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Product Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey[100], // Light grey background for placeholder
                    child: widget.product.thumbnail != null
                        ? Image.network(widget.product.thumbnail!, fit: BoxFit.contain)
                        : Icon(Icons.image, size: 100, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title
                        Text(
                          widget.product.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Brand Name
                        Text(
                          'Brand: ${widget.product.brand ?? 'Unknown'}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Price
                        Text(
                          '€${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Product Description
                        Text(
                          widget.product.description,
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section: Quantity & Add to Cart Button
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.grey, // Grey background for quantity selector
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Quantity Selector
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[600], // Darker grey for contrast
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Container(


                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

                            child: Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          SizedBox(
            width: MediaQuery.of(context).size.width * 1, // 90% of screen width
            height: 100, // Adjust height as needed
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400], // Red button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Round corners
                ),
              ),
              icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
              label: const Text(
                'Add to cart',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem(
                  widget.product.id.toString(),
                  widget.product.title,
                  widget.product.price,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.title} added to cart!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}



