import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fly/config/app_config.dart';
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
  final Map<dynamic, int> _qty = {};
  int _getCount(Product p) => _qty[p.id] ?? 1;
  Future<void> increment(Product p) async {
    setState(() {
      _qty[p.id] = _getCount(p) + 1;
    });
  }

  Future<void> decrement(Product p) async {
    setState(() {
      final rule = _getCount(p) - 1;
      final getRule = rule > 0 ? rule : 0;
      _qty[p.id] = getRule;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final cardProducts = context.read<CardProvider>().productCard;
      debugPrint("Cart items: ${cardProducts.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardProducts = context.watch<CardProvider>().productCard;
    return Scaffold(
      appBar: AppHeader(nameScreen: "Card"),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (isUserScroll) {
              setState(() => isUserScroll = true);
            }
          }
          if (notification.direction == ScrollDirection.forward) {
            if (!isUserScroll) {
              setState(() {
                isUserScroll = false;
              });
            }
          }
          return false;
        },
        child: CardBody(
          onCheckout: (items, total) async =>  {
            context.push(AppRoutes.checkout, extra: {
              "items": items,
              "total": total,
            },)
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
