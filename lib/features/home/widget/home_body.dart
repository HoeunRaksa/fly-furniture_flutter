import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/small_card.dart';
import '../../../model/product.dart';
import 'category.dart';
import 'home_section_scroller.dart';

class HomeBody extends StatelessWidget {
  final int selectedIndex;
  final String? searchQuery;
  final Function(int) onCategorySelected;
  final List<Product> products;
  final ScrollController? scrollController;

  const HomeBody({
    super.key,
    required this.selectedIndex,
    this.searchQuery,
    required this.onCategorySelected,
    required this.products,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200), // ⭐ world-class max width
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 10),

            // Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Special Offers",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 10),

            const HomeSectionScroller(),
            const SizedBox(height: 10),

            // Categories horizontal list
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Category(
                    index: index,
                    selectedIndex: selectedIndex,
                    onTap: () => onCategorySelected(index),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 7),
              ),
            ),
            const SizedBox(height: 10),

            // Most Interested section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Interested",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.orangeAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            // Horizontal Products list
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final imageProvider = product.images.isNotEmpty
                      ? NetworkImage(
                    AppConfig.getImageUrl(product.images[0].imageUrl),
                  )
                      : const AssetImage('assets/images/placeholder.png');

                  return InkWell(
                    onTap: () {
                      context.go('/detail/${product.id}');
                    },
                    child: ProductCard(
                      image: imageProvider as ImageProvider,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      setIcon: true,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 10),
              ),
            ),
            const SizedBox(height: 20),

            // Popular section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular", style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.orangeAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      context.go('/detail/${product.id}');
                    },
                    child: SmallCard(product: product),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
