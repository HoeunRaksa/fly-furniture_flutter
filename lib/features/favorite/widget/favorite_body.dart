import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/horizontal_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_color.dart';
import '../../../config/app_config.dart';
import '../../../core/routing/app_routes.dart';
import '../../../model/product.dart';
import '../../../model/product_category.dart';
import '../../../providers/cardProvider.dart';

class FavoriteBody extends StatelessWidget {
  final List<Product> favorites;
  final List<ProductCategory> categories;
  final Future<void> Function(Product) onToggle;
  final int? selectCategoryId;
  final Future<void> Function(Product, int qty) onAdd;
  final void Function(int? categoryId) onCategorySelect;
  const FavoriteBody({
    super.key,
    required this.favorites,
    required this.onToggle,
    required this.categories,
    this.selectCategoryId,
    required this.onCategorySelect,
    required this.onAdd
  });
  @override
  Widget build(BuildContext context) {

    final display = <ProductCategory>[
      ProductCategory(id: -1, name: 'All'),
      ...categories,
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: display.length,
              itemBuilder: (_, index) {

                final p = display[index];

                final isSelect = selectCategoryId == p.id;
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
                    onPressed: () => onCategorySelect(p.id),
                    child: Text(p.name),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1, height: 1, color: AppColors.divider),
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
                final cart = context.watch<CardProvider>();   // or read(), see note below
                final qty = cart.getQty(p);                   // must exist in provider
                final qtyToAdd = qty == 0 ? 1 : qty;
                return Dismissible(
                  key: ValueKey(p.id),
                  onDismissed: (_) async {
                    await onToggle(p);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('Removed: ${p.name}'),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () async {
                              await onToggle(p);
                            },
                          ),
                        ),
                      );
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 30),
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      child: ProductHorizontalCard(
                        onTap:() => context.push('${AppRoutes.detail}/${p.id}'),
                        product: p,
                        image: imageProvider,
                        isFavorite: true,
                        onToggle: () => onToggle(p),
                        onAdd: () => onAdd(p,qtyToAdd) ,
                      ),
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
