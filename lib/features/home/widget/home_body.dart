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

  const HomeBody({
    super.key,
    required this.selectedIndex,
    this.searchQuery,
    required this.onCategorySelected,
    required this.products
  });

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.all(5),
      children: [
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Special Offers",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 10),
        const HomeSectionScroller(),
        const SizedBox(height: 30),

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
            separatorBuilder: (context, index) => const SizedBox(width: 7),
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.orangeAccent, fontSize: 15),
              ),
            ),
          ],
        ),

        // Horizontal Products list
        SizedBox(
          height: 250, // fixed height for horizontal ListView
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final imageProvider = product.images.isNotEmpty
                  ? NetworkImage(AppConfig.getImageUrl(product.images[0].imageUrl)) as ImageProvider
                  : AssetImage('assets/images/placeholder.png') as ImageProvider;

              return InkWell(
                onTap: () {
                  // Navigate to ProductScreen with the product ID
                  context.go('/detail/${product.id}');
                },
                child: ProductCard(
                  image: imageProvider,
                  name: product.name,
                  description: product.description,
                  price: product.price,
                  setIcon: true,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.orangeAccent, fontSize: 15),
              ),
            ),
          ],
        ),

        // Horizontal Small Cards list
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: () {
                  // Navigate to ProductScreen with the product ID
                  context.go('/detail/${product.id}');
                },
                child: SmallCard(product: product),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
