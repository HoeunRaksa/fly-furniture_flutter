import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:fly/config/app_config.dart';
import '../../../core/widgets/product_incard.dart';
import '../../../model/order_item.dart';
import '../../../model/product.dart';
import 'card_bottom.dart';

class CardBody extends StatelessWidget {
  final List<Product> cardProduct;
  final Future<void> Function(Product product) onIncrement;
  final Future<void> Function(Product product) onDecrement;
  final Future<void> Function(List<OrderItem> items, double total) onCheckout;
  final int Function(Product product) getCount;
  final double bottomGap;
  const CardBody({
    super.key,
    required this.cardProduct,
    required this.onDecrement,
    required this.onIncrement,
    required this.getCount,
    required this.bottomGap,
    required this.onCheckout
  });

  @override
  Widget build(BuildContext context) {
    final total = cardProduct.fold<double>(0, (sum, p) => sum + (p.price * getCount(p)));
    final items = cardProduct.map((p) => OrderItem(productId: int.parse(p.id), quantity: getCount(p))).toList();
    return Column(
      children: [
        Expanded(child: ListView.builder(
          itemCount: cardProduct.length,
          itemBuilder: (_, index) {
            final card = cardProduct[index];
            final imageProvider = card.images.isNotEmpty
                ? CachedNetworkImageProvider(
              AppConfig.getImageUrl(card.images[0].imageUrl),
            )
                : const AssetImage('assets/images/placeholder.png')
            as ImageProvider;
            final count = getCount(card);

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ProductInCard(
                product: card,
                image: imageProvider,
                onDecrement: () async => await onDecrement(card),
                onIncrement: () async => await onIncrement(card),
                count: count,
              ),
            );
          },
        ),),
        if(total > 0)
        Expanded(
            child: CardBottom(
              onCheckout:() async => await onCheckout(items, total),
              bottomGap: bottomGap,
              total: total,
            )
        )
      ],
    );
  }
}
