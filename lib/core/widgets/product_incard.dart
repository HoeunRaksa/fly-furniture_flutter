import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductInCard extends StatelessWidget {
  final Product product;
  final ImageProvider image;
  final Future<void> Function() onIncrement;
  final Future<void> Function() onDecrement;
  final int count;
  const ProductInCard({super.key, required this.product, required this.image, required this.onIncrement, required this.onDecrement, this.count =0,});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 130.0;
    const double imageSize = 130.0;
    final double total = (product.price ?? 0) * count;
    return Stack(
      children: [
        Container(
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(5),
                 child:  Image(
                   image: image,
                   width: imageSize,
                   height: imageSize,
                   fit: BoxFit.cover,
                 ),
             ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                      ),
                      Spacer(),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [

                       Text(
                         "\$${total.toStringAsFixed(2)}",
                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                           fontWeight: FontWeight.w600,
                           color: AppColors.furnitureBlue,
                         ),
                       ),
                      Container(
                        padding: EdgeInsets.only(right: 30),
                        child:  Row(
                          children: [
                            IconButton(onPressed: onDecrement, icon: Icon(Icons.remove)),
                            Container(
                              padding: EdgeInsets.zero,
                              child: Text(count.toString(), style: Theme.of(context).textTheme.bodyLarge,),),
                            IconButton(onPressed: onIncrement, icon: Icon(Icons.add)),
                          ],
                        ),
                      )
                     ],)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
