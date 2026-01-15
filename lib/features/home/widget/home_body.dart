import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';
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
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: () async => await provider.refreshProducts(),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 4),
          _buildSectionHeader(context, "Special Offers", isDark: isDark),
          const SizedBox(height: 10),

          // Banner Section with Auto Scroller
          const HomeSectionScroller(), // Use the scroller here instead of _buildBanner
          const SizedBox(height: 12),

          // Categories
          _buildGlassCategories(context, isDark),
          const SizedBox(height: 14),

          // Most Interested Section
          _buildSectionHeader(context, "Featured Products", isDark: isDark),
          const SizedBox(height: 8),
          _buildFeaturedSection(context, isDark),
          const SizedBox(height: 16),

          // Popular Section
          _buildSectionHeader(context, "All Products", isDark: isDark),
          const SizedBox(height: 8),
          _buildAllProductsSection(context, isDark),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildGlassCategories(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.all(0),
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            itemCount: 10,
            itemBuilder: (context, index) => Category(
              index: index,
              selectedIndex: selectedIndex,
              onTap: () => onCategorySelected(index),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context, bool isDark) {
    if (products.isEmpty) {
      return _buildEmptyState(context);
    }

    return SizedBox(
      height: 400,
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
              : const AssetImage('assets/images/placeholder.png')
                    as ImageProvider;

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.push('/detail/${product.id}'),
            child: ProductCard(
              image: imageProvider,
              product: product,
              setIcon: true,
              onAdded: () {},
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _buildAllProductsSection(BuildContext context, bool isDark) {
    if (products.isEmpty) {
      return _buildEmptyState(context);
    }

    return SizedBox(
      height: 120,
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
              : const AssetImage('assets/images/placeholder.png')
                    as ImageProvider;

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.push('/detail/${product.id}'),
            child: SmallCard(product: product, image: imageProvider),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.cube_box, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('No products available'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
