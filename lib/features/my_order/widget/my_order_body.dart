import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fly/model/order_response.dard.dart';
import '../../../config/app_color.dart';
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
      child: Column(
        children: [
          AppHeader(nameScreen: "My Orders", suffixIcon: true),
          SizedBox(height: 10),
          Divider(height: 1, thickness: 1, color: AppColors.divider),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (order.items.isEmpty) {
                  return const SizedBox.shrink();
                }
                final product = order.items.first.product;
                final qty = order.items.first.quantity;
                if (product == null) {
                  return const SizedBox.shrink();
                }
                final ImageProvider imageProvider = product.images.isNotEmpty
                    ? CachedNetworkImageProvider(
                        AppConfig.getImageUrl(product.images[0].imageUrl),
                      )
                    : const AssetImage('assets/images/placeholder.png');
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ProductHorizontalCard(
                        product: product,
                        image: imageProvider,
                        onToggle: () async {},
                        onTap: () async {},
                        isPaid: true,
                        unPrice: true,
                        counts: qty,
                      ),
                    ),
                    Positioned(
                      top:10,
                      right: 30,
                      child: Text("$qty", style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
