import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srhcraftshop/models/product_model.dart';

class ProductService {
  // get saved auth token
  static Future<String> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authToken") ?? "";
  }

  // fetch products from the api
  static Future<List<Product>> fetchProducts() async {
    const url = 'https://mad-shop.onrender.com/api/products?populate=*';

    try {
      String authToken = await _getAuthToken();
      print("🔹 Using Auth Token: $authToken");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData == null || !jsonData.containsKey('data')) {
          throw Exception("Invalid response: Missing 'data' key");
        }

        // convert api response to a list of products
        List<Product> products = (jsonData['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();

        print("✅ Successfully fetched ${products.length} products");
        return products;
      } else {
        print("❌ Error fetching products: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Exception fetching products: $e");
      return [];
    }
  }
}





