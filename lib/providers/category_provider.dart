import 'package:flutter/cupertino.dart';

import '../features/service/product_service.dart';
import '../model/product_category.dart';

class CategoryProvider extends ChangeNotifier {
  final List<ProductCategory> _categories = [];
  List<ProductCategory> get categories => List.unmodifiable(_categories);

  final ProductService service = ProductService();

  Future<void> getCategory({String? token}) async {
    final products = await service.fetchProducts(token: token);

    _categories.clear();

    final map = <int, ProductCategory>{};

    for (final p in products) {
      if (p.category != null) {
        final cat = ProductCategory(
          id: p.category!.id,
          name: p.category!.name,
        );
        map[cat.id] = cat;
      }
    }

    _categories.addAll(map.values);
    notifyListeners();
  }
}
