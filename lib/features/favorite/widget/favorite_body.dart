import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/small_card.dart';
import '../../../config/app_color.dart';
import '../../../config/app_config.dart';
import '../../../model/product.dart';
import '../../../model/product_category.dart';

class FavoriteBody extends StatelessWidget {
  final List<Product> favorites;
  final List<ProductCategory> categories;
  final Future<void> Function(Product) onToggle;
  final bool isSelect;
  const FavoriteBody({
    super.key,
    required this.favorites,
    required this.onToggle,
    required this.categories,
    this.isSelect = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final p = categories[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isSelect
                          ? AppColors.furnitureBlue
                          : Colors.white,
                      foregroundColor: isSelect
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyMedium?.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: isSelect
                              ? AppColors.furnitureBlue
                              : Colors.grey.shade300,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {
                      debugPrint('Click');
                    },
                    child: Text(p.name),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1,height: 1,color:  AppColors.divider),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (_, index) {
                final p = favorites[index];
                final imageProvider = p.images.isNotEmpty
                    ? CachedNetworkImageProvider(
                        AppConfig.getImageUrl(p.images[0].imageUrl),
                      )
                    : const AssetImage('assets/images/placeholder.png')
                          as ImageProvider;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SizedBox(
                    child: SmallCard(
                      product: p,
                      image: imageProvider,
                      isFavorite: true,
                      onToggle: () => onToggle(p),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
