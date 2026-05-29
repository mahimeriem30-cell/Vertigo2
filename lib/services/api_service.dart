import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/basket.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../models/store.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5096/api';

  //auth

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setInt('userId', data['id']);
        return true;
      }
      return false;
    } catch (e) {
      print('Erreur login: $e');
      return false;
    }
  }

  static Future<bool> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Erreur register: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
  }

  //headers et userId

  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  //paniers

  static Future<List<Basket>> getPaniers() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/paniers'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) {
          final store = Store.fromJson(json['boutique'] ?? {});
          return Basket.fromJson(json, store);
        }).toList();
      }
      return [];
    } catch (e) {
      print('Erreur getPaniers: $e');
      return [];
    }
  }
  //commandes

  static Future<List<Order>> getMyOrders() async {
    try {
      final headers = await _getHeaders();
      final userId = await _getUserId();

      final response = await http.get(
        Uri.parse('$baseUrl/commandes/client/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) {
          // Récupérer le panier associé à la commande
          final basketJson = json['panier'] ?? {};
          final store = Store.fromJson(basketJson['boutique'] ?? {});
          final basket = Basket.fromJson(basketJson, store);
          return Order.fromJson(json, basket, store);
        }).toList();
      }
      return [];
    } catch (e) {
      print('Erreur getMyOrders: $e');
      return [];
    }
  }

  static Future<bool> createOrder(int panierId, double prix) async {
    try {
      final headers = await _getHeaders();
      final userId = await _getUserId();

      final response = await http.post(
        Uri.parse('$baseUrl/commandes'),
        headers: headers,
        body: jsonEncode({
          'clientId': userId,
          'panierId': panierId,
          'prix': prix,
          'dateDeCommande': DateTime.now().toIso8601String(),
          'statut': false,
          'reduction': false,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Erreur createOrder: $e');
      return false;
    }
  }

  //profil

  static Future<Utilisateur?> getProfile() async {
    try {
      final headers = await _getHeaders();
      final userId = await _getUserId();

      final response = await http.get(
        Uri.parse('$baseUrl/utilisateurs/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Utilisateur.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Erreur getProfile: $e');
      return null;
    }
  }

  static Future<bool> updateProfile(Map<String, dynamic> userData) async {
    try {
      final headers = await _getHeaders();
      final userId = await _getUserId();

      final response = await http.put(
        Uri.parse('$baseUrl/utilisateurs/$userId'),
        headers: headers,
        body: jsonEncode(userData),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Erreur updateProfile: $e');
      return false;
    }
  }

  //favoris

  static Future<List<int>> getFavoris() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/favoris'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((id) => id as int).toList();
      }
      return [];
    } catch (e) {
      print('Erreur getFavoris: $e');
      return [];
    }
  }

  static Future<bool> addFavoris(int panierId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/favoris'),
        headers: headers,
        body: jsonEncode({'panierId': panierId}),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Erreur addFavoris: $e');
      return false;
    }
  }

  static Future<bool> removeFavoris(int panierId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/favoris/$panierId'),
        headers: headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Erreur removeFavoris: $e');
      return false;
    }
  }
}
