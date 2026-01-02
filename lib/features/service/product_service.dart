import 'dart:convert';
import 'package:fly/model/product.dart';
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';
class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse("${AppConfig.baseUrl}/products"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch products!");
    }
  }
  Future<Product> fetchProductById(String id) async {
    final response = await http.get(Uri.parse("${AppConfig.baseUrl}/products/$id"));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch product with id $id");
    }
  }
  Future<Product> createProduct(Map<String, dynamic> data, String token) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${AppConfig.baseUrl}/products"),
    );
    data.forEach((key, value) {
      if (key != 'images') request.fields[key] = value.toString();
    });
    if (data['images'] != null && data['images'] is List<String>) {
      for (final path in data['images']) {
        request.files.add(await http.MultipartFile.fromPath('images[]', path));
      }
    }
    request.headers['Authorization'] = 'Bearer $token';
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create product: ${response.body}");
    }
  }
  Future<Product> updateProduct(String id, Map<String, dynamic> data, String token) async {
    final response = await http.put(
      Uri.parse("${AppConfig.baseUrl}/products/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update product: ${response.body}");
    }
  }
  Future<void> deleteProduct(String id, String token) async {
    final response = await http.delete(
      Uri.parse("${AppConfig.baseUrl}/products/$id"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete product: ${response.body}");
    }
  }
}
