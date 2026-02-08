import 'package:flutter/material.dart';
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
    final provider = context.watch<ProductProvider>();
    final List<Product> favoriteProduct = provider.products.where((p)=> p.isFavorite == true).toList();
    return Scaffold(
      appBar: const FavoriteHeader(),
      body: FavoriteBody(favorites: favoriteProduct),
    );
  }
}
