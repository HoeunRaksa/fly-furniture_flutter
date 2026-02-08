import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? imageX;
  final Product product;
  final ImageProvider image;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;



  const ProductCard({
    super.key,
    this.height,
    this.width,
    this.imageX,
    required this.product,
    required this.image,
     this.onFavoriteTap,
    this.isFavorite = false

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4, // Increased flex for image
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(image: image, fit: BoxFit.cover),
                  ),
                  if (product.discount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.saleRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "- ${product.discount.toInt()} %",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onFavoriteTap,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 25,
                          color: isFavorite ? Colors.pink : Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.name.isNotEmpty)
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.headerLine,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 7),
                  if (product.description.isNotEmpty)
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const Spacer(),
                  if (product.price > 0)
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.furnitureBlue,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
