import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://mad-shop.onrender.com/api/auth/local"; // base api url

  // login user with email and password
  static Future<String?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "identifier": email,
          "password": password
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("jwt")) {
        return data["jwt"]; // return auth token
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // register a new user
  static Future<String?> registerUser(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("jwt")) {
        return data["jwt"]; // return auth token
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class AuthStorage {
  // save auth token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // get saved auth token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
//can add log out option to delete (feature maybe)

}








