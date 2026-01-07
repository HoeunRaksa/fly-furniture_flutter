import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class SmallCard extends StatelessWidget {
  final double width;
  final double height;
  final Product product;
  final ImageProvider image;

  const SmallCard({
    super.key,
    this.width = 370,
    this.height = 230,
    required this.product,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              alignment: Alignment.centerLeft,
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image(image: image,),
                    ),
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
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (product.description.isNotEmpty)
                          const SizedBox(height: 5),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              color: AppColors.secondaryGreen,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (product.discount > 0)
          Positioned(
            top: 14,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen.withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "-${product.discount}%",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
