import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/model/product_category.dart';
import 'package:fly/providers/category_provider.dart';
import 'package:fly/providers/favorite_provider.dart';
import 'package:fly/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../model/product.dart';
import '../widget/favorite_body.dart';
import '../widget/favorite_header.dart';
import '../../auth/provider/auth_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthProvider>().token;
      context.read<ProductProvider>().fetchProducts(token: token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final categoriesProvider = context.watch<CategoryProvider>();
    final List<Product> favoriteProduct = productProvider.products
        .where((p) => p.isFavorite == true)
        .toList();
    final List<ProductCategory>  categories = categoriesProvider.categories;
    return Scaffold(
      appBar: const FavoriteHeader(),
      body: FavoriteBody(
        favorites: favoriteProduct,
        categories: categories,
        onToggle: (p) async {
          final token = context.read<AuthProvider>().token;
          if (token == null) return;
          await context.read<FavoriteProvider>().toggleFavorite(
            productProvider: context.read<ProductProvider>(),
            token: token,
            productId: p.id,
          );
        },
      ),
    );
  }
}
