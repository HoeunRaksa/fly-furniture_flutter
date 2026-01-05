import 'package:flutter/material.dart';
import '../../config/app_color.dart';

class ProductCard extends StatelessWidget {
  final double width;
  final double height;
  final double? imageX;
  final String? name;
  final String? description;
  final double? price;
  final ImageProvider image;
  final bool setIcon;
  final Function(String)? onAdded;

  const ProductCard({
    super.key,
    this.height = 300,
    this.width = 200,
    this.imageX = 200,
    required this.image,
    this.name,
    this.description,
    this.price,
    this.onAdded,
    this.setIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image section
              SizedBox(
                height: 135,
                child: Image(
                  image: image,
                  width: imageX,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 8),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (name != null)
                      Text(
                        name!.length > 16
                            ? '${name!.substring(0, 16)}...'
                            : name!,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        description!.length > 20
                            ? '${description!.substring(0, 20)}...'
                            : description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (price != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        "\$${price!.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        // Icon button
        if (setIcon)
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              onPressed: () => onAdded?.call(name ?? ''),
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.shopping_bag, color: Colors.white, size: 18),
              ),
            ),
          ),
      ],
    );
  }
}
