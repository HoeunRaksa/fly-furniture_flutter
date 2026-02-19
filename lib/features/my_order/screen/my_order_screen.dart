import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/features/my_order/widget/my_order_body.dart';
import 'package:provider/provider.dart';
import '../../../providers/order_provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthProvider>().token;
      if (token != null) {
        context.read<OrderProvider>().myOrder(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final response = orderProvider.orderResponse;
    if (orderProvider.loading) {
      return const Scaffold(
        body: Center(child: CupertinoActivityIndicator()),
      );
    }

    if (response == null) {
      return const Scaffold(
        body: Center(child: Text("No orders")),
      );
    }
    return Scaffold(
           body: MyOrderBody(response: response),
    );
  }
}
