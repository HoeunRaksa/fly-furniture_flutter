import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/providers/product_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/product_card.dart';
import '../../../model/product.dart';
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
          const SizedBox(height: 30),
           const HomeSectionScroller(),
          _buildSectionHeader(context, "Featured Collection", isDark: isDark),
          _buildProductGrid(context, isDark),


        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, bool isDark) {
    if (products.isEmpty) {
      return _buildEmptyState(context);
    }

    // Filter products if searchQuery is present
    final filteredProducts = searchQuery == null || searchQuery!.isEmpty
        ? products
        : products.where((p) => 
            p.name.toLowerCase().contains(searchQuery!.toLowerCase()) ||
            p.description.toLowerCase().contains(searchQuery!.toLowerCase())
          ).toList();

    if (filteredProducts.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7, // Adjust this based on ProductCard design
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        final imageProvider = product.images.isNotEmpty
            ? CachedNetworkImageProvider(
                AppConfig.getImageUrl(product.images[0].imageUrl),
              )
            : const AssetImage('assets/images/placeholder.png') as ImageProvider;

        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.push('/detail/${product.id}'),
          child: ProductCard(
            width: double.infinity,
            height: double.infinity,
            image: imageProvider,
            product: product,
            setIcon: true,
            onAdded: () {},
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.cube_box, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No pieces found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Try adjusting your search or filters'),
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
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Sort & Filter",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
