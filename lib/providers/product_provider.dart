import 'package:flutter/foundation.dart';
import '../features/service/product_service.dart';
import '../model/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _products = [];
  bool _loading = false;
  bool _isInitialized = false;
  String? _error;

  List<Product> get products => _products;
  bool get loading => _loading;
  bool get isInitialized => _isInitialized;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get hasProducts => _products.isNotEmpty;

  // Fetch products (uses cache from service)
  Future<void> fetchProducts({bool forceRefresh = false}) async {
    // Skip if already loading
    if (_loading) return;

    // Skip if already initialized and not forcing refresh
    if (_isInitialized && !forceRefresh) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _service.fetchProducts(forceRefresh: forceRefresh);
      _isInitialized = true;
      _error = null;

      if (kDebugMode) {
        debugPrint('✅ Fetched ${_products.length} products');
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to fetch products: $e');
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Fetch single product by ID
  Future<Product?> fetchProductById(String id) async {
    // First check if product exists in cache
    try {
      final cachedProduct = _products.firstWhere((p) => p.id == id);
      return cachedProduct;
    } catch (_) {
      // Not in cache, fetch from service
    }

    try {
      final product = await _service.fetchProductById(id);

      // Update cache if product exists
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = product;
      } else {
        _products.add(product);
      }
      notifyListeners();

      return product;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to fetch product $id: $e');
      }
      return null;
    }
  }

  // Refresh products (forces cache refresh)
  Future<void> refreshProducts() async {
    await fetchProducts(forceRefresh: true);
  }

  // Create new product
  Future<bool> createProduct(Map<String, dynamic> data, String token) async {
    try {
      _error = null;
      final newProduct = await _service.createProduct(data, token);

      // Add to beginning of list
      _products.insert(0, newProduct);
      notifyListeners();

      if (kDebugMode) {
        debugPrint('✅ Product created: ${newProduct.name}');
      }

      return true;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to create product: $e');
      }
      return false;
    }
  }

  // Update existing product
  Future<bool> updateProduct(
      String id,
      Map<String, dynamic> data,
      String token,
      ) async {
    try {
      _error = null;
      final updated = await _service.updateProduct(id, data, token);

      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updated;
        notifyListeners();

        if (kDebugMode) {
          debugPrint('✅ Product updated: ${updated.name}');
        }
      }

      return true;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to update product $id: $e');
      }
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(String id, String token) async {
    try {
      _error = null;
      await _service.deleteProduct(id, token);

      _products.removeWhere((p) => p.id == id);
      notifyListeners();

      if (kDebugMode) {
        debugPrint('✅ Product deleted: $id');
      }

      return true;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to delete product $id: $e');
      }
      return false;
    }
  }

  // Upload images to existing product
  Future<bool> uploadProductImages(
      String id,
      List<String> imagePaths,
      String token,
      ) async {
    try {
      _error = null;
      final updated = await _service.uploadProductImages(id, imagePaths, token);

      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updated;
        notifyListeners();

        if (kDebugMode) {
          debugPrint('✅ Images uploaded for product: ${updated.name}');
        }
      }

      return true;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Failed to upload images for product $id: $e');
      }
      return false;
    }
  }

  // Search products by name or description
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;

    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Filter products by category
  List<Product> getProductsByCategory(String category) {
    if (category.isEmpty || category.toLowerCase() == 'all') {
      return _products;
    }

    return _products.where((product) {
      return product.category?.toLowerCase() == category.toLowerCase();
    }).toList();
  }

  // Get products within price range
  List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
    return _products.where((product) {
      return product.price >= minPrice && product.price <= maxPrice;
    }).toList();
  }

  // Sort products
  void sortProducts(ProductSortOption sortOption) {
    switch (sortOption) {
      case ProductSortOption.nameAsc:
        _products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductSortOption.nameDesc:
        _products.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ProductSortOption.priceAsc:
        _products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceDesc:
        _products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.newest:
        _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ProductSortOption.oldest:
        _products.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear all data (for logout)
  void clearData() {
    _products = [];
    _loading = false;
    _isInitialized = false;
    _error = null;
    _service.clearCache();
    notifyListeners();

    if (kDebugMode) {
      debugPrint('🧹 ProductProvider data cleared');
    }
  }

  // Get product count
  int get productCount => _products.length;

  // Check if product exists
  bool hasProduct(String id) {
    return _products.any((p) => p.id == id);
  }
}

// Sort options enum
enum ProductSortOption {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
  newest,
  oldest,
}