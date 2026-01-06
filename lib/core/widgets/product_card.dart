import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              alignment: Alignment.topCenter,
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: widget.image,
                      width: widget.imageX,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Column(
                      children: [
                        if (widget.product.name.isNotEmpty) ...[
                          Text(
                            widget.product.name.length > 16
                                ? '${widget.product.name.substring(0, 16)}...'
                                : widget.product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (widget.product.description.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.product.description.length > 60
                                  ? '${widget.product.description.substring(0, 60)}...'
                                  : widget.product.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 13),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        if (widget.product.price > 0) ...[
                          const SizedBox(height: 10),
                          Text(
                            "\$${widget.product.price.toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              color: AppColors.secondaryGreen,
                              fontSize: 20,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (widget.setIcon)
          Positioned(
            top: 10,
            width: widget.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "-${widget.product.discount}%",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        child: CircleIconButton(
                          sizeX: 40,
                          sizedY: 40,
                          backgroundColor: Colors.transparent,
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          iconColor:
                          isFavorite ? Colors.pink : Colors.grey.shade500,
                          iconSize: 30,
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            widget.onAdded;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
