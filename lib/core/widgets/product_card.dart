import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';
import '../helperFunction/string_util.dart';

class ProductCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? imageX;
  final Product product;
  final ImageProvider image;
  final bool setIcon;
  final VoidCallback onAdded;

  const ProductCard({
    super.key,
    this.height,
    this.width,
    this.imageX,
    required this.product,
    required this.image,
    required this.onAdded,
    this.setIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions with max width of 600
    final cardWidth = width ?? (screenWidth * 0.65).clamp(0, 600);
    final cardHeight = height ?? screenHeight * 0.5;
    final imageWidth = imageX ?? cardWidth;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
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
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: image, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.012,
                    right: screenWidth * 0.04,
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.010),
                      decoration: BoxDecoration(
                          color: AppColors.saleRed,
                          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.026))
                      ),
                      child: Text(
                        "- ${product.discount.toInt()} %",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.012),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.026),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (product.name.isNotEmpty)
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w800,
                        color: AppColors.headerLine,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
  
                  SizedBox(height: screenHeight * 0.005),
  
                  // Description
                  if (product.description.isNotEmpty)
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  const Spacer(),
                  if (product.price > 0)
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.012),
                      child: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.bold,
                          color: AppColors.furnitureBlue,
                        ),
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