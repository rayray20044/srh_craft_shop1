import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;
  final String? thumbnail;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    this.thumbnail,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  int? _selectedLocker;

  // Payment method state
  String _selectedPaymentMethod = '';
  String get selectedPaymentMethod => _selectedPaymentMethod;

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Map<String, CartItem> get items => _items;
  int? get selectedLocker => _selectedLocker;

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(String productId, String title, double price, {int quantity = 1, String? thumbnail}) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + quantity,
          thumbnail: existingCartItem.thumbnail,
        ),
      );
    } else {
      _items[productId] = CartItem(
        id: productId,
        title: title,
        price: price,
        quantity: quantity,
        thumbnail: thumbnail,
      );
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (item) => CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          quantity: item.quantity + 1,
          thumbnail: item.thumbnail,
        ),
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
              (item) => CartItem(
            id: item.id,
            title: item.title,
            price: item.price,
            quantity: item.quantity - 1,
            thumbnail: item.thumbnail,
          ),
        );
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // clear cart after order is placed
  void clearCart() {
    _items.clear();
    notifyListeners();
  }


}
