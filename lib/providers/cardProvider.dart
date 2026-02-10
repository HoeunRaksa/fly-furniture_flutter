import 'package:flutter/material.dart';
import '../model/product.dart';
class CardProvider extends ChangeNotifier{
  List<Product> productCard = [];
  Future<void> cardToggle(Product pro) async {
    try {
      if(productCard.contains(pro)){
        productCard.remove(pro);
      }else{
        productCard.add(pro);
      }
      notifyListeners();
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
