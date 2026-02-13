import 'package:flutter/material.dart';
import 'package:fly/core/widgets/app_header.dart';
import 'package:fly/features/checkout/widget/checkout_body.dart';

import '../../../model/order_item.dart';

class CheckoutScreen extends StatefulWidget {
  final List<OrderItem> items;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.items,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(nameScreen: "Checkout", suffixIcon: true),
      body: CheckoutBody(),
    );
  }
}
