
import 'dart:convert';

import 'package:fly/config/app_config.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  Future<void> addFavorite({
    required String token,
    required String productID,
  }) async {
    final res = await http.post(
      Uri.parse('${AppConfig.baseUrl}/favorites'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"product_id": productID}),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Add favorite failed: ${res.statusCode} ${res.body}');
    }
  }

  Future<void> removeFavorite({
    required String token,
    required String productID,
  }) async {
    final res = await http.delete(
      Uri.parse('${AppConfig.baseUrl}/favorites/$productID'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200 && res.statusCode != 204) {
      // Some APIs might use POST /favorites/remove or similar if DELETE /favorites/{id} fails
      // Let's try to handle other common patterns if this fails, but for now let's assume standard REST
      throw Exception('Remove favorite failed: ${res.statusCode} ${res.body}');
    }
  }
}
