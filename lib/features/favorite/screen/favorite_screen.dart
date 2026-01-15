import 'package:flutter/material.dart';

import '../../../core/widgets/circleIcon_button.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading:  CircleIconButton(
          icon: Icons.arrow_back,
          // backgroundColor: AppColors.glassFillDark,
          backgroundColor: Colors.transparent,
          iconColor: Colors.white,
          iconSize: 25,
          sizedY: 44,
          sizeX: 44,
          onTap: () {
            debugPrint("Tap back!");
          },
        ),
        title: Text(
          "My Favourite",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: favorites.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return FavoriteItemCard(
            name: item['name'],
            price: item['price'],
            imageUrl: item['imageUrl'],
            onRemove: () {
              // handle remove
            },
            onAddToCart: () {
              // handle add to cart
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "No favorites yet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text("Browse furniture and add items you love."),
        ],
      ),
    );
  }
}

class FavoriteItemCard extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const FavoriteItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onRemove,
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.green),
                      onPressed: onAddToCart,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}