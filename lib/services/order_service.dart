import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:srhcraftshop/services/auth_service.dart';

class OrderService {
  static const String baseUrl = 'https://mad-shop.onrender.com/api'; // api url

  // get auth token and attach to headers
  static Future<Map<String, String>> _getHeaders() async {
    String? token = await AuthStorage.getToken(); // get stored token
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // attach token
    };
  }

  // create a new order with cart items
  static Future<String?> createOrder(List<Map<String, dynamic>> cartItems) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: await _getHeaders(),
      body: jsonEncode({
        "data": {
          "orderStatus": "PAID",
          "issue": true,
          "items": cartItems
        }
      }),
    );



    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data.containsKey('data') && data['data'].containsKey('documentId')) {
        return data['data']['documentId'].toString(); // return order id
      } else {
        print("🚨 Unexpected Order API Response: ${response.body}"); //debuggggg
        return null;
      }
    } else {
      print("🚨 Failed to create order: ${response.body}");//debugggggggg
      return null;
    }
  }
}
