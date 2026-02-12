import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:fly/config/app_config.dart';


import '../../../core/widgets/product_incard.dart';
import '../../../model/product.dart';

class CardBody extends StatelessWidget {
  final List<Product> cardProduct;
  final Future<void> Function(Product product) onIncrement;
  final Future<void> Function(Product product) onDecrement;
  final int Function(Product product) getCount;
  const CardBody({super.key, required this.cardProduct, required this.onDecrement, required this.onIncrement, required this.getCount,});

  @override
  Widget build(BuildContext context) {
         return Container(
           child: ListView.builder(
              itemCount: cardProduct.length,
               itemBuilder: (_, index) {
                final card = cardProduct[index];
                final imageProvider = card.images.isNotEmpty ? CachedNetworkImageProvider(AppConfig.getImageUrl(card.images[0].imageUrl))
                    : const AssetImage('assets/images/placeholder.png')
                as ImageProvider;
                final count = getCount(card);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ProductInCard(product: card, image: imageProvider, onDecrement: () async => await onDecrement(card), onIncrement: () async => await onIncrement(card), count: count,),
                );
               }
           ),
         );
  }
}
