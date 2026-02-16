import 'package:flutter/material.dart';
import '../model/product.dart';

class CardProvider extends ChangeNotifier {

  final Map<Product, int> productCard = {};

  void add(Product pro, int qty) {
    if (qty <= 0) return;

    if (productCard.containsKey(pro)) {
      productCard[pro] = productCard[pro]! + qty;
    } else {
      productCard[pro] = qty;
    }

    notifyListeners();
  }

   int countCate() {return productCard.length;}

  void remove(Product pro) {
    productCard.remove(pro);
    notifyListeners();
  }

  int getQty(Product pro) {
    return productCard[pro] ?? 0;
  }

  void clear() {
    productCard.clear();
    notifyListeners();
  }
}
