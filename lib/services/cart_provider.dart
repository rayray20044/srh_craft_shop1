import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  get product => null;
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // If item already exists in the cart, update the quantity
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // If item is new to the cart, add to the cart with a quantity of 1
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(), // A unique ID for this cart item
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}

