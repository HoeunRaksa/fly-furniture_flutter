import 'package:flutter/cupertino.dart';
import 'package:fly/features/service/product_service.dart';
import '../model/product_category.dart';
class CategoryProvider extends ChangeNotifier {
    final List <ProductCategory> _categories =[];
     List<ProductCategory> get categories => List.unmodifiable(_categories);
     ProductService service = ProductService();
     Future<void> getCategory() async{
       final product = await service.fetchProducts();
              _categories.clear();
              final  map = <int, ProductCategory>{};
              for(final p in product){
                if(p != null){
                  map[p.category!.id] = p.category!;
                }
              }
       _categories.addAll(map.values);
     }
}