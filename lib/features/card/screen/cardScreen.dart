import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fly/core/routing/app_routes.dart';
import 'package:fly/core/widgets/app_header.dart';
import 'package:fly/features/card/widget/card_body.dart';
import 'package:fly/model/product.dart';
import 'package:fly/providers/cardProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool isUserScroll = false;
  String searchText = ""; // ✅

  int _getCount(Product p) => context.read<CardProvider>().getQty(p);

  Future<void> increment(Product p) async {
    context.read<CardProvider>().add(p, 1);
  }

  Future<void> decrement(Product p) async {
    final provider = context.read<CardProvider>();
    final currentQty = provider.getQty(p);

    if (currentQty > 1) {
      provider.remove(p);
      provider.add(p, currentQty - 1);
    } else if (currentQty == 1) {
      provider.remove(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CardProvider>();
    final allCardProducts = provider.productCard.keys.toList();
    final filteredCardProducts = searchText.trim().isEmpty
        ? allCardProducts
        : allCardProducts
        .where((p) => p.name
        .toLowerCase()
        .contains(searchText.trim().toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppHeader(
        nameScreen: "Card",
        onChanged: (text) => setState(() => searchText = text),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (!isUserScroll) setState(() => isUserScroll = true);
          } else if (notification.direction == ScrollDirection.forward) {
            if (isUserScroll) setState(() => isUserScroll = false);
          }
          return false;
        },
        child: CardBody(
          cardProduct: filteredCardProducts,
          onDecrement: decrement,
          onIncrement: increment,
          getCount: _getCount,
          bottomGap: isUserScroll ? 0 : 20,
          onCheckout: (items, total) async {
            context.push(
              AppRoutes.checkout,
              extra: {
                "items": items,
                "total": total,
              },
            );
          },
        ),
      ),
    );
  }
}

