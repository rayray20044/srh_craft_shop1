import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';
import 'package:srhcraftshop/provider/favorite_provider.dart';


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
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    bool isFavorited = favoriteProvider.isFavorite(widget.product);

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

                  // Product Title & Favorite Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Details (Title, Brand, Price) in a Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
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

                              // Product Price (Now aligned to the left)
                              Text(
                                '€${widget.product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0069A6),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Favorite Button (Heart)
                        IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isFavorited ? Colors.red : Colors.black, // Red when favorited
                            size: 28,
                          ),
                          onPressed: () {
                            favoriteProvider.toggleFavorite(widget.product);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Product Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quantity Selector
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF999999),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
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
                          decoration: BoxDecoration(
                            color: Color(0xFFACACAC),
                            borderRadius: BorderRadius.circular(8),
                          ),
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
              ],
            ),
          ),

          // Add to Cart Button (Full Width with Rounded Edges)
          Container(
            width: double.infinity, // Full-width background behind button
            color: Color(0xFF999999), // Background color behind button
            padding: const EdgeInsets.only(top: 1), // Spacing inside background
            child: SizedBox(
              width: double.infinity, // Button stretches across entire screen
              height: 80, // Adjust height as needed
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBC5D5D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28), // Shopping cart icon
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
          ),
        ],
      ),
    );
  }
}



