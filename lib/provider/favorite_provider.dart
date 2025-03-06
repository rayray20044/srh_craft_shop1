import 'package:flutter/material.dart';
import 'package:srhcraftshop/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favorites = []; // list to store favorite products

  List<Product> get favorites => _favorites; // getter for favorite products

  // add or remove product from favorites
  void toggleFavorite(Product product) {
    final existingIndex = _favorites.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      _favorites.removeAt(existingIndex); // remove if already in favorites
    } else {
      _favorites.add(product); // add if not in favorites
    }

    notifyListeners(); // update ui
  }

  // check if product is in favorites so not put there twice (one of thr issues)
  bool isFavorite(Product product) {
    return _favorites.any((item) => item.id == product.id);
  }
}
