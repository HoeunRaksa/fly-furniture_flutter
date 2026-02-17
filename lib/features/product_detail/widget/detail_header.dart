import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/button_header.dart';
import '../../../model/product.dart';

class DetailHeader extends StatelessWidget {
  final Product product;
  final VoidCallback? onFavoriteTap;

  const DetailHeader({
    super.key,
    required this.product,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
      ),
      child: Stack(
        children: [
          Positioned(
            child: ButtonHeader(
              onClickedBack: () => context.pop(),
              isFavorite: product.isFavorite,
              onClickedFavorite: onFavoriteTap,
            ),
          )
        ],
      ),
    );
  }
}