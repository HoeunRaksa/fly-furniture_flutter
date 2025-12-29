import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
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
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: AppColors.gray700.withAlpha(200))],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(
              height: 135,
              child: Image(
                image: image,
                width: imageX,
                fit: BoxFit.contain,
              ),
            ),
              Expanded(child:
              Column(
                children: [
                  if (name != null)
                    Text(
                      name!.length > 13
                          ? '${name!.substring(0, 13)}...'
                          : name!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  SizedBox(height: 10,),
                  if (description != null)
                    Text(
                      description!.length > 20
                          ? '${description!.substring(0, 20)}...'
                          : description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  SizedBox(height: 10,),
                  if (price != null)
                    Text(
                      "\$${price!.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ) ),
            ],
          ),
        ),
        if (setIcon == true)
          Positioned(
            top: 1,
            right: 1,
            child: IconButton(
              onPressed: () => onAdded?.call(name ?? ''),
              icon: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.shopping_bag, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
