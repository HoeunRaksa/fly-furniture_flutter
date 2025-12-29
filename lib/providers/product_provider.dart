import 'package:flutter/foundation.dart';
import 'package:fly/features/auth/service/product_service.dart';
import '../model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;
  String? _error;

  final ProductService _service = ProductService();

  // Getters
  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;

  // Fetch products from backend
  Future<void> fetchProducts() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _service.fetchProduct();
    } catch (e) {
      _error = "Failed to load products";
      if (kDebugMode) print("Error fetching products: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Optionally: refresh products
  Future<void> refreshProducts() async => await fetchProducts();
}
