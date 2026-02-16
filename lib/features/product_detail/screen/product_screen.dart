import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/product_detail/widget/detail_footer.dart';
import '../../../providers/cardProvider.dart';
import '../widget/detail_body.dart';
import '../widget/detail_header.dart';
import '../../../model/product.dart';
import 'package:provider/provider.dart';
import '../../auth/provider/auth_provider.dart';
import '../../../providers/favorite_provider.dart';
import '../../../providers/product_provider.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  int count = 1;
  late double amount;

  @override
  void initState() {
    super.initState();
    amount = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    const double footerHeight = 150;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    final productProvider = context.watch<ProductProvider>();
    final product = productProvider.products.firstWhere(
      (p) => p.id == widget.product.id,
      orElse: () => widget.product,
    );

    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    CupertinoColors.black.withOpacity(0.95),
                    CupertinoColors.black.withOpacity(0.98),
                    CupertinoColors.black,
                  ]
                : [
                    CupertinoColors.systemBackground.withOpacity(0.95),
                    CupertinoColors.systemGrey6.withOpacity(0.3),
                    CupertinoColors.systemBackground,
                  ],
          ),
        ),
        child: Stack(
          children: [
            DetailBody(product: product),
            Positioned(
              top: 5,
              left: 10,
              right: 10,
              child: DetailHeader(
                product: product,
                onFavoriteTap: () async {
                  final token = context.read<AuthProvider>().token;
                  if (token == null) return;
                  await context.read<FavoriteProvider>().toggleFavorite(
                    productProvider: context.read<ProductProvider>(),
                    token: token,
                    productId: product.id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: footerHeight,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemBlue.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
            BoxShadow(
              color: CupertinoColors.black.withOpacity(isDark ? 0.4 : 0.06),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child:DetailFooter(
          product: product,
          count: count,
          amount: product.price * count,

          onIncrease: () => setState(() {
            count++;
          }),

          onDecrease: () => setState(() {
            if (count > 0) count--;
          }),

          onAddToCart: (Product p, int qty) async {
            context.read<CardProvider>().add(p, qty);
          },
        ),

      ),
    );
  }
}
