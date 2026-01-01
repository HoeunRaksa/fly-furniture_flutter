import 'package:flutter/material.dart';
import 'package:fly/features/product_detail/widget/viewer.dart';
import '../../../config/app_config.dart';
import '../../../model/product.dart';
class DetailBody extends StatelessWidget {
  final Product product;
  const DetailBody({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("${AppConfig.imageUrl}/banner.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right:10, left: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 200,
                  child: Text(
                    "Ox Mathis Furniture Modern Style",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 130,
                  child: Text(
                   "\$${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.orange.shade700
                    ),
                  ),
                ),
              ],
            ),
          ),
          Viewer(view: 20000,like: 3000, rating: 4,),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description", style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: 15,),
                Text(product.description, style: Theme.of(context).textTheme.bodyMedium,)
              ],
            )
          ),
        ],
      ),
    );
  }
}
