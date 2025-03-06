import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';
import 'package:srhcraftshop/provider/favorite_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product; // store product details

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // default quantity

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context); // get favorite provider
    final cartProvider = Provider.of<CartProvider>(context, listen: false); // get cart provider
    bool isFavorited = favoriteProvider.isFavorite(widget.product); // check if product is favorited

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200], // light gray background
        elevation: 0, // remove shadow
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // product image
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey[100], // background color if no image
                    child: widget.product.thumbnail != null
                        ? Image.network(
                      widget.product.thumbnail!,
                      fit: BoxFit.cover, // fill space
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, color: Colors.grey, size: 100); // show icon if error
                      },
                    )
                        : const Icon(Icons.image, size: 100, color: Colors.grey), // show default icon if no image
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // product details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Category: ${widget.product.category}', // show category
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '€${widget.product.price.toStringAsFixed(2)}', // format price
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0069A6)),
                              ),
                            ],
                          ),
                        ),

                        // favorite button
                        IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border, // filled or empty heart
                            color: isFavorited ? Colors.red : Colors.black,
                            size: 28,
                          ),
                          onPressed: () {
                            favoriteProvider.toggleFavorite(widget.product); // add or remove favorite
                          },
                        ),
                      ],
                    ),
                  ),

                  // product description
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

          // plus minus part for the qauntity
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF999999), // gray background
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                        // decrease quantity button
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--; // - quantity
                              });
                            }
                          },
                        ),
                        // display selected quantity
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFACACAC), // gray box for number
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        // increase quantity button
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++; // + quantity
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

          // add to cart button
          Container(
            width: double.infinity,
            color: const Color(0xFF999999),
            padding: const EdgeInsets.only(top: 1),
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC5D5D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                label: const Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  cartProvider.addItem(
                    widget.product.id.toString(), // product id
                    widget.product.name, // product name
                    widget.product.price, // product price
                    quantity: quantity, // selected quantity
                    thumbnail: widget.product.thumbnail, // product image
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



