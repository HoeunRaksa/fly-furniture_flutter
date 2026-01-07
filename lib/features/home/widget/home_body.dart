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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 8),

              // Header with gradient text effect
              Align(
                alignment: Alignment.centerLeft,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      CupertinoColors.label.resolveFrom(context),
                      CupertinoColors.label.resolveFrom(context).withOpacity(0.8),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    "Special Offers",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1.2,
                      color: CupertinoColors.label.resolveFrom(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const HomeSectionScroller(),
              const SizedBox(height: 20),

              // Categories Horizontal List with glass effect
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemFill.resolveFrom(context).withOpacity(0.3),
                      CupertinoColors.secondarySystemFill.resolveFrom(context).withOpacity(0.2),
                    ],
                  ),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemCount: 10,
                  itemBuilder: (context, index) => Category(
                    index: index,
                    selectedIndex: selectedIndex,
                    onTap: () => onCategorySelected(index),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                ),
              ),
              const SizedBox(height: 24),

              // Most Interested Section
              _sectionHeader(context, "Most Interested", onView: () {}),
              const SizedBox(height: 12),

              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageProvider = product.images.isNotEmpty
                        ? CachedNetworkImageProvider(
                      AppConfig.getImageUrl(product.images[0].imageUrl),
                    )
                        : const AssetImage('assets/images/placeholder.png');

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemBlue.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.push('/detail/${product.id}'),
                        child: ProductCard(
                          image: imageProvider as ImageProvider,
                          product: product,
                          setIcon: true,
                          onAdded: () {},
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                ),
              ),
              const SizedBox(height: 28),

              // Popular Section
              _sectionHeader(context, "Popular", onView: () {}),
              const SizedBox(height: 12),

              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageProvider = product.images.isNotEmpty
                        ? CachedNetworkImageProvider(
                      AppConfig.getImageUrl(product.images[0].imageUrl),
                    )
                        : const AssetImage('assets/images/placeholder.png');

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemPurple.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.push('/detail/${product.id}'),
                        child: SmallCard(
                          product: product,
                          image: imageProvider as ImageProvider,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                ),
              ),
              const SizedBox(height: 20),
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
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              CupertinoColors.label.resolveFrom(context),
              CupertinoColors.label.resolveFrom(context).withOpacity(0.85),
            ],
          ).createShader(bounds),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.2,
              color: CupertinoColors.label.resolveFrom(context),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CupertinoColors.systemFill.resolveFrom(context).withOpacity(0.5),
                CupertinoColors.secondarySystemFill.resolveFrom(context).withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
              width: 0.5,
            ),
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minSize: 0,
            borderRadius: BorderRadius.circular(12),
            onPressed: onView,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                    color: CupertinoColors.activeBlue.resolveFrom(context),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 14,
                  color: CupertinoColors.activeBlue.resolveFrom(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}