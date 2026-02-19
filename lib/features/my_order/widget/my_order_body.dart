import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:fly/model/order_response.dard.dart';

import '../../../config/app_config.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/horizontal_card.dart';

class MyOrderBody extends StatelessWidget {
  final OrderResponse response;
  const MyOrderBody({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final orders = response.orders;
    return SafeArea(
      child: Container(
        child: Column(
          children: [AppHeader(nameScreen: "My Orders", suffixIcon: true),
            Expanded(child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  if (order.items.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final product = order.items.first.product;

                  if (product == null) {
                    return const SizedBox.shrink();
                  }

                  final ImageProvider imageProvider = product.images.isNotEmpty
                      ? CachedNetworkImageProvider(
                    AppConfig.getImageUrl(product.images[0].imageUrl),
                  )
                      : const AssetImage('assets/images/placeholder.png');

                  return ProductHorizontalCard(
                    product: product,
                    image: imageProvider,
                    onToggle: () async {},
                    onTap: () async {},
                  );
                }
            ))
          ],
        ),
      ),
    );
  }
}
