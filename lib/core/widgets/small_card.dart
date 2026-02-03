import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class SmallCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Product product;
  final ImageProvider image;

  const SmallCard({
    super.key,
    this.width,
    this.height,
    required this.product,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions with max width of 600
    final cardWidth = width ?? (screenWidth * 0.9).clamp(0, 600);
    final cardHeight = height ?? screenHeight * 0.14;
    final imageSize = cardHeight * 0.82;
    final horizontalPadding = screenWidth * 0.02;
    final spacing = screenWidth * 0.025;

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: EdgeInsets.all(horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image - Responsive size
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            child: Image(
              image: image,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: spacing),

          // Product info - Flexible to prevent overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product name
                if (product.name.isNotEmpty)
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                // Description
                if (product.description.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.004),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.029,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Price and discount
                if (product.price > 0) ...[
                  SizedBox(height: screenHeight * 0.008),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.bodyLine,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.discount > 0) ...[
                        SizedBox(width: screenWidth * 0.015),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.002,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.priceLine,
                            borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          ),
                          child: Text(
                            '-${product.discount.toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.024,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}