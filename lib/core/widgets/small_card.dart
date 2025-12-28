import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../config/app_config.dart';

class SmallCard extends StatelessWidget {
  final double width;
  final double height;
  final double imageY;
  final String? name;
  final String? description;
  final double? price;
  const SmallCard({
    super.key,
    this.width = 300,
    this.height = 200,
    this.imageY = 100,
    this.name,
    this.description,
    this.price = 100,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(right: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColors.gray700.withAlpha(20),
              borderRadius: BorderRadius.all(Radius.circular(10))

            ),
            child: Image.asset(
              "${AppConfig.imageUrl}/character.png",
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name != null)
                Text(name!, style: Theme.of(context).textTheme.headlineSmall),
              if (description != null) SizedBox(height: 5),
              Text(description!, style: Theme.of(context).textTheme.bodySmall),
              if (price != null) SizedBox(height: 5),
              Text(
                price!.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
