import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductCard extends StatelessWidget {
  final double width;
  final double height;
  final double? imageX;
  final Product product;
  final ImageProvider image;
  final bool setIcon;
  final VoidCallback onAdded;

  const ProductCard({
    super.key,
    this.height = 390,
    this.width = 250,
    this.imageX = 250,
    required this.product,
    required this.image,
    required this.onAdded,
    this.setIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: image,
              width: imageX,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 12),

          // Product name
          if (product.name.isNotEmpty)
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.woodDark
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),

          const SizedBox(height: 10),

          // Description
          if (product.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          const Spacer(),
          if (product.price > 0)
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.woodWalnut,
              ),
            ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}