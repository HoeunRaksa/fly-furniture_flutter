import 'dart:convert';
import 'package:fly/model/product.dart';
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';

class ProductService {
  static const Duration _timeout = Duration(seconds: 30);

  // Cache for products (optional - improves performance)
  static List<Product>? _cachedProducts;
  static DateTime? _lastFetchTime;
  static const Duration _cacheExpiry = Duration(minutes: 5);

  Future<List<Product>> fetchProducts({bool forceRefresh = false}) async {
    // Return cached data if valid and not forcing refresh
    if (!forceRefresh &&
        _cachedProducts != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < _cacheExpiry) {
      return _cachedProducts!;
    }

    try {
      final response = await http
          .get(Uri.parse("${AppConfig.baseUrl}/products"))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // Handle both wrapped and direct array responses
        List<dynamic> data;
        if (responseData is Map<String, dynamic>) {
          // Wrapped response: {"success": true, "data": [...]}
          if (responseData.containsKey('data')) {
            data = responseData['data'] as List<dynamic>;
          } else if (responseData.containsKey('products')) {
            data = responseData['products'] as List<dynamic>;
          } else {
            throw Exception("Invalid response format: no 'data' or 'products' field");
          }
        } else if (responseData is List) {
          // Direct array response: [...]
          data = responseData;
        } else {
          throw Exception("Invalid response format: expected Map or List");
        }
        
        final products = data.map((json) => Product.fromJson(json)).toList();

        // Cache the results
        _cachedProducts = products;
        _lastFetchTime = DateTime.now();

        return products;
      } else {
        throw Exception("Failed to fetch products: ${response.statusCode}");
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException catch (e) {
      throw Exception("Invalid response format: ${e.message}");
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<Product> fetchProductById(String id) async {
    try {
      final response = await http
          .get(Uri.parse("${AppConfig.baseUrl}/products/$id"))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // Handle wrapped response
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            return Product.fromJson(responseData['data']);
          } else if (responseData.containsKey('product')) {
            return Product.fromJson(responseData['product']);
          }
          // If no wrapper, assume the whole response is the product
          return Product.fromJson(responseData);
        }
        
        return Product.fromJson(responseData);
      } else if (response.statusCode == 404) {
        throw Exception("Product not found");
      } else {
        throw Exception("Failed to fetch product: ${response.statusCode}");
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException catch (e) {
      throw Exception("Invalid response format: ${e.message}");
    } catch (e) {
      throw Exception("Failed to fetch product: $e");
    }
  }

  Future<Product> createProduct(
    Map<String, dynamic> data,
    String token,
  ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseUrl}/products"),
      );

      // Add fields
      data.forEach((key, value) {
        if (key != 'images') {
          request.fields[key] = value.toString();
        }
      });

      // Add images
      if (data['images'] != null && data['images'] is List<String>) {
        for (final path in data['images']) {
          try {
            request.files.add(
              await http.MultipartFile.fromPath('images[]', path),
            );
          } catch (e) {
            throw Exception("Failed to attach image: $path");
          }
        }
      }

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Clear cache when new product is created
        _cachedProducts = null;
        
        final responseData = json.decode(response.body);
        
        // Handle wrapped response
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            return Product.fromJson(responseData['data']);
          } else if (responseData.containsKey('product')) {
            return Product.fromJson(responseData['product']);
          }
          return Product.fromJson(responseData);
        }
        
        return Product.fromJson(responseData);
      } else {
        throw Exception(
          "Failed to create product (${response.statusCode}): ${response.body}",
        );
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException catch (e) {
      throw Exception("Invalid response format: ${e.message}");
    } catch (e) {
      throw Exception("Failed to create product: $e");
    }
  }

  Future<Product> updateProduct(
    String id,
    Map<String, dynamic> data,
    String token,
  ) async {
    try {
      final response = await http
          .put(
        Uri.parse("${AppConfig.baseUrl}/products/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: json.encode(data),
      )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        // Clear cache when product is updated
        _cachedProducts = null;
        
        final responseData = json.decode(response.body);
        
        // Handle wrapped response
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            return Product.fromJson(responseData['data']);
          } else if (responseData.containsKey('product')) {
            return Product.fromJson(responseData['product']);
          }
          return Product.fromJson(responseData);
        }
        
        return Product.fromJson(responseData);
      } else if (response.statusCode == 404) {
        throw Exception("Product not found");
      } else {
        throw Exception(
          "Failed to update product (${response.statusCode}): ${response.body}",
        );
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException catch (e) {
      throw Exception("Invalid response format: ${e.message}");
    } catch (e) {
      throw Exception("Failed to update product: $e");
    }
  }

  Future<void> deleteProduct(String id, String token) async {
    try {
      final response = await http
          .delete(
        Uri.parse("${AppConfig.baseUrl}/products/$id"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Clear cache when product is deleted
        _cachedProducts = null;
      } else if (response.statusCode == 404) {
        throw Exception("Product not found");
      } else {
        throw Exception(
          "Failed to delete product (${response.statusCode}): ${response.body}",
        );
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Failed to delete product: $e");
    }
  }

  // Upload additional images to existing product
  Future<Product> uploadProductImages(
    String id,
    List<String> imagePaths,
    String token,
  ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseUrl}/products/$id/images"),
      );

      for (final path in imagePaths) {
        try {
          request.files.add(
            await http.MultipartFile.fromPath('images[]', path),
          );
        } catch (e) {
          throw Exception("Failed to attach image: $path");
        }
      }

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Clear cache when images are uploaded
        _cachedProducts = null;
        
        final responseData = json.decode(response.body);
        
        // Handle wrapped response
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data')) {
            return Product.fromJson(responseData['data']);
          } else if (responseData.containsKey('product')) {
            return Product.fromJson(responseData['product']);
          }
          return Product.fromJson(responseData);
        }
        
        return Product.fromJson(responseData);
      } else {
        throw Exception(
          "Failed to upload images (${response.statusCode}): ${response.body}",
        );
      }
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Failed to upload images: $e");
    }
  }

  // Clear cache manually if needed
  void clearCache() {
    _cachedProducts = null;
    _lastFetchTime = null;
  }
}