import 'package:flutter/foundation.dart';
import '../features/service/product_service.dart';
import '../model/product.dart';


class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _products = [];
  bool _loading = false;
  String? _error;
  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    if (_products.isNotEmpty || _loading) return;
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
    } catch (e) {
      _error = "Failed to load products: $e";
      if (kDebugMode) print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Product?> fetchProductById(String id) async {
    try {
      final product = await _service.fetchProductById(id);
      return product;
    } catch (e) {
      _error = "Failed to load product: $e";
      if (kDebugMode) print(e);
      return null;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  Future<void> createProduct(Map<String, dynamic> data, String token) async {
    try {
      final newProduct = await _service.createProduct(data, token);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      _error = "Failed to create product: $e";
      if (kDebugMode) print(e);
    }
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data, String token) async {
    try {
      final updated = await _service.updateProduct(id, data, token);
      final index = _products.indexWhere((p) => p.id == updated.id);
      if (index != -1) _products[index] = updated;
      notifyListeners();
    } catch (e) {
      _error = "Failed to update product: $e";
      if (kDebugMode) print(e);
    }
  }

  Future<void> deleteProduct(String id, String token) async {
    try {
      await _service.deleteProduct(id, token);
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _error = "Failed to delete product: $e";
      if (kDebugMode) print(e);
    }
  }
}
