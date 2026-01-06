import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/providers/product_provider.dart';
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
  final ProductProvider provider;

  const HomeBody({
    super.key,
    required this.selectedIndex,
    this.searchQuery,
    required this.onCategorySelected,
    required this.products,
    this.scrollController,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await provider.refreshProducts(),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
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

              // Categories Horizontal List
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => Category(
                    index: index,
                    selectedIndex: selectedIndex,
                    onTap: () => onCategorySelected(index),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 7),
                ),
              ),
              const SizedBox(height: 10),

              // Most Interested Section
              _sectionHeader(context, "Most Interested", onView: () {}),

              SizedBox(
                height: 400,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageProvider = product.images.isNotEmpty
                        ? CachedNetworkImageProvider(
                      AppConfig.getImageUrl(product.images[0].imageUrl),
                    )
                        : const AssetImage('assets/images/placeholder.png');

                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.push('/detail/${product.id}'),
                      child: ProductCard(
                        image: imageProvider as ImageProvider,
                        product: product,
                        setIcon: true,
                        onAdded: () {},
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                ),
              ),
              const SizedBox(height: 20),

              // Popular Section
              _sectionHeader(context, "Popular", onView: () {}),

              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageProvider = product.images.isNotEmpty
                        ? CachedNetworkImageProvider(
                      AppConfig.getImageUrl(product.images[0].imageUrl),
                    )
                        : const AssetImage('assets/images/placeholder.png');

                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.push('/detail/${product.id}'),
                      child: SmallCard(
                        product: product,
                        image: imageProvider as ImageProvider,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title, {required VoidCallback onView}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onView,
          child: Text(
            "View",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: CupertinoColors.activeOrange,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
