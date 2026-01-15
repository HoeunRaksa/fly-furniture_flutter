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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
                 children: [
                   Image(image: image, width: imageX, fit: BoxFit.contain),
                   Positioned(
                     top:20,right: 20,
                       child: Container(
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(color: AppColors.woodLight, borderRadius: BorderRadius.all(Radius.circular(10))),
                         child: Text(
                           "- \$${product.discount}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                       ),) ),
                 ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.name.isNotEmpty)
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.woodDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 10),

                // Description
                if (product.description.isNotEmpty)
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                const SizedBox(height: 10),
                if (product.price > 0)
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.woodWalnut,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
