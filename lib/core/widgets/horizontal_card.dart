import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductHorizontalCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Product product;
  final ImageProvider image;
  final Future<void> Function() onToggle;
  final Future<void> Function()? onAdd;
  final VoidCallback onTap;
  final bool isFavorite;
  final bool isInCard;
  const ProductHorizontalCard({
    super.key,
    this.width,
    this.height,
    required this.product,
    required this.image,
    required this.onToggle,
    this.onAdd,
    this.isFavorite = false,
    required this.onTap,
    this.isInCard = false,
  });
  @override
  Widget build(BuildContext context) {
    const double cardHeight = 130.0;
    const double imageSize = 130.0;

    return Stack(
      children: [
        Container(
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              InkWell(
                onTap: onTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: image,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (product.name.isNotEmpty)
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    if (product.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],

                    if (product.price > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.furnitureBlue,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!isInCard)
                            TextButton(
                              onPressed: onAdd,
                              child: Text(
                                'AddToCard',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          if (isInCard)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "Already in Card",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isFavorite == true)
          Positioned(
            right: 10,
            top: 3,
            child: InkWell(
              onTap: onToggle,
              child: Icon(Icons.favorite, color: Colors.red, size: 30),
            ),
          ),
      ],
    );
  }
}
