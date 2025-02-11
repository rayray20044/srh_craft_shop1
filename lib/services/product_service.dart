import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  // Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch a product by ID
  static Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data); // Assuming Product has a `fromJson` method
    } else {
      throw Exception('Failed to load product with id $id');
    }
  }
}




