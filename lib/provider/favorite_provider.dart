import 'package:flutter/material.dart';
import 'package:srhcraftshop/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    // If the product is already in favorites, remove it; otherwise, add it
    final existingIndex = _favorites.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      _favorites.removeAt(existingIndex); // Remove only one instance
    } else {
      _favorites.add(product);
    }

    notifyListeners(); // Notify UI to update
  }

  bool isFavorite(Product product) {
    return _favorites.any((item) => item.id == product.id);
  }
}