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
  
  int _getCount(Product p) {
    return context.read<CardProvider>().getQty(p);
  }
  
  Future<void> increment(Product p) async {
    final currentQty = context.read<CardProvider>().getQty(p);
    context.read<CardProvider>().add(p, 1);
  }

  Future<void> decrement(Product p) async {
    final provider = context.read<CardProvider>();
    final currentQty = provider.getQty(p);
    if (currentQty > 1) {
      // Remove the product and re-add with decreased quantity
      provider.remove(p);
      provider.add(p, currentQty - 1);
    } else if (currentQty == 1) {
      // Remove the product entirely if quantity becomes 0
      provider.remove(p);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final cardProducts = context.read<CardProvider>().productCard.keys.toList();
      debugPrint("Cart items: ${cardProducts.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardProducts = context.watch<CardProvider>().productCard.keys.toList();
    return Scaffold(
      appBar: AppHeader(nameScreen: "Card"),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (!isUserScroll) {
              setState(() => isUserScroll = true);
            }
          }
          if (notification.direction == ScrollDirection.forward) {
            if (isUserScroll) {
              setState(() {
                isUserScroll = false;
              });
            }
          }
          return false;
        },
        child: CardBody(
          onCheckout: (items, total) async {
            await context.push(AppRoutes.checkout, extra: {
              "items": items,
              "total": total,
            });
          },
          cardProduct: cardProducts,
          onDecrement: decrement,
          onIncrement: increment,
          getCount: _getCount,
          bottomGap: isUserScroll ? 0 : 20,
        ),
      ),
    );
  }
}
