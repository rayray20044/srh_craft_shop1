import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';
import 'package:srhcraftshop/nav-pages/order_review_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context); // access to the cart provider

    return Scaffold(
      backgroundColor: const Color(0xFFE3E2DF),
      body: Column(
        children: [

          // custom rounded app bar
          Container(
            padding: const EdgeInsets.only(top: 80, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFBC5D5D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Text(
                'MY CART',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE8E5E8),
                ),
              ),
            ),
          ),

          //display cart items
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text("Your cart is empty"))
                : ListView.builder(
              itemCount: cart.items.length, // n of items
              itemBuilder: (context, index) {
                var itemId = cart.items.keys.elementAt(index); //item id
                var item = cart.items[itemId]!; //item detail

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // adds spacing around each item
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // rounded corners
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            item.thumbnail ?? 'https://via.placeholder.com/150', // placeholder if no image
                          ),
                          fit: BoxFit.cover, // ensures the image fills the container
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('€${item.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // button to decrease quantity
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cart.decreaseQuantity(itemId);
                          },
                        ),
                        Text(item.quantity.toString()),

                        // button to increase
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cart.increaseQuantity(itemId);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //button section
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFBC5D5D),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      // row for total pricee
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            "€${cart.totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // order reviw button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cart.items.isEmpty
                              ? Colors.grey[400]
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: cart.items.isEmpty
                            ? null // disables button if cart is empty
                            : () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderReviewPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Text(
                            "ORDER OVERVIEW →",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: cart.items.isEmpty
                                  ? Colors.black54
                                  : const Color(0xFFBC5D5D),
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
    );
  }
}
