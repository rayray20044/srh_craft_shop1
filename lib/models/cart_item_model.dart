import 'package:srhcraftshop/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
