import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pickup_model.dart';
import 'auth_service.dart';

class PickupService {
  static const String baseUrl = "https://mad-shop.onrender.com/api"; // base api url

  // fetch auth token and attach to headers
  static Future<Map<String, String>> _getHeaders() async {
    String? token = await AuthStorage.getToken(); // get stored token
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // attach token if exists
    };
  }

  // start pickup process with document id
  Future<Pickup?> startPickup(String documentId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders/$documentId/start-pickup'),
      headers: await _getHeaders(),
    );

    print("📦 Pickup API Response: ${response.body}"); // debug output

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data.containsKey('data')) {
        return Pickup.fromJson(data['data']); // return pickup object
      } else {
        print("🚨 Unexpected Pickup API Response: ${response.body}");
        return null;
      }
    } else {
      print("🚨 Failed to start pickup: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  // get pickup status by document id
  Future<Pickup?> getPickupStatus(String pickupDocumentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pickups/$pickupDocumentId'),
      headers: await _getHeaders(),
    );

    print("📦 Pickup Status Response: ${response.body}"); // debug output

    if (response.statusCode == 200) {
      return Pickup.fromJson(json.decode(response.body)); // return pickup status
    } else {
      print("🚨 Error fetching pickup: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  // mark pickup as completed
  Future<bool> completePickup(String pickupDocumentId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/pickups/$pickupDocumentId'),
      headers: await _getHeaders(),
      body: jsonEncode({'status': 'Completed'}),
    );

    if (response.statusCode == 200) {
      return true; // pickup completed successfully
    } else {
      print("🚨 Failed to complete pickup: ${response.statusCode} - ${response.body}");
      return false;
    }
  }
}


