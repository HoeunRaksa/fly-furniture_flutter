import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../config/app_config.dart';
import '../../model/product.dart';

class SmallCard extends StatelessWidget {
  final double width;
  final double height;
  final double imageY;
  final Product product;

  const SmallCard({
    super.key,
    this.width = 370,
    this.height = 230,
    this.imageY = 150,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image section
          Container(
            width: imageY * 0.6,
            height: imageY,
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.gray700.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: product.images.isNotEmpty
                ? Image.network(
              AppConfig.getImageUrl(product.images[0].imageUrl),
              fit: BoxFit.contain,
            )
                : Image.asset("${AppConfig.imageUrl}/character.png"),
          ),

          // Text section
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.name.isNotEmpty)
                  Text(
                    product.name.length > 25
                        ? '${product.name.substring(0, 25)}...'
                        : product.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (product.description.isNotEmpty) const SizedBox(height: 5),
                if (product.description.isNotEmpty)
                  Text(
                    product.description.length > 30
                        ? '${product.description.substring(0, 30)}...'
                        : product.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (product.price != 0) const SizedBox(height: 5),
                if (product.price != 0)
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
