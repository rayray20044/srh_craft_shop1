import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/services/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE3E2DF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBC5D5D),
        elevation: 0,
        toolbarHeight: 90,
        title: const Text(
          'MY CART',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE8E5E8),
          ),
        ),
      ),
      body: cart.items.isEmpty
          ? const Center(
        child: Text("Your cart is empty"),
      )
          : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          var itemId = cart.items.keys.elementAt(index);
          var item = cart.items[itemId]!;
          return ListTile(
            title: Text(item.product.title),
            subtitle: Text('Quantity: ${item.quantity}'),
            trailing: Text('\$${item.product.price * item.quantity}'),
            onTap: () => null, // Or navigate to product detail page
          );
        },
      ),
    );
  }
}

