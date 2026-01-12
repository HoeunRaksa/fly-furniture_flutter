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
import 'home_section_scroller.dart'; // Import the scroller

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
      onRefresh: () async => await provider.refreshProducts(),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 4),

          // Special Offers Header
          _buildGlassHeader(context, "Special Offers", isDark),
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

  Widget _buildGlassHeader(BuildContext context, String title, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? const [
                Color.fromRGBO(255, 255, 255, 0.08),
                Color.fromRGBO(255, 255, 255, 0.03),
              ]
                  : const [
                Color.fromRGBO(255, 255, 255, 0.7),
                Color.fromRGBO(255, 255, 255, 0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? const Color.fromRGBO(255, 255, 255, 0.1)
                  : const Color.fromRGBO(255, 255, 255, 0.4),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondaryGreen.withValues(alpha: 0.2),
                      AppColors.greenLight.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(CupertinoIcons.tag_fill, color: AppColors.secondaryGreen, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCategories(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [
                Color.fromRGBO(255, 255, 255, 0.1),
                Color.fromRGBO(255, 255, 255, 0.05),
              ]
                  : const [
                Color.fromRGBO(255, 255, 255, 0.8),
                Color.fromRGBO(255, 255, 255, 0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? const Color.fromRGBO(255, 255, 255, 0.15)
                  : const Color.fromRGBO(255, 255, 255, 0.5),
              width: 1.5,
            ),
          ),
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
              ? CachedNetworkImageProvider(AppConfig.getImageUrl(product.images[0].imageUrl))
              : const AssetImage('assets/images/placeholder.png') as ImageProvider;

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
              ? CachedNetworkImageProvider(AppConfig.getImageUrl(product.images[0].imageUrl))
              : const AssetImage('assets/images/placeholder.png') as ImageProvider;

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

  Widget _buildSectionHeader(BuildContext context, String title, {required bool isDark}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? const [
                      Color.fromRGBO(255, 255, 255, 0.08),
                      Color.fromRGBO(255, 255, 255, 0.03),
                    ]
                        : const [
                      Color.fromRGBO(255, 255, 255, 0.7),
                      Color.fromRGBO(255, 255, 255, 0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? const Color.fromRGBO(255, 255, 255, 0.1)
                        : const Color.fromRGBO(255, 255, 255, 0.4),
                    width: 1.5,
                  ),
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