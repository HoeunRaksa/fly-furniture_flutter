import 'package:flutter/material.dart';
import 'package:fly/core/widgets/app_header.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/features/checkout/widget/checkout_body.dart';
import 'package:fly/model/order_request.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/qr_item.dart';
import '../../../model/order_item.dart';
import '../../../providers/order_provider.dart';

class CheckoutScreen extends StatelessWidget {
  final List<OrderItem> items;
  final double total;
  const CheckoutScreen({super.key, required this.items, required this.total});
  Future<void> _onContinue(BuildContext context, OrderRequest request) async {
    final token = context.read<AuthProvider>().token;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please login again your token was expired!"),
        ),
      );
      return;
    }
    try {
      await context.read<OrderProvider>().createOrder(request, token);
      if (!context.mounted) return;
      final orderData = context.read<OrderProvider>().createdOrder;
      if (orderData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No order data returned")),
        );
        return;
      }
      final qrImage = orderData["qr_image"]?.toString();
      final invoiceNo = orderData["invoice_no"]?.toString();

      if (qrImage == null || qrImage.isEmpty) {
        String availableKeys = orderData.keys.join(', ');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment QR not generated. Available keys: $availableKeys")),
        );
        return;
      }

      if (invoiceNo == null || invoiceNo.isEmpty) {
        String availableKeys = orderData.keys.join(', ');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invoice number missing. Available keys: $availableKeys")),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QrImageScreen(qrImage: qrImage, invoiceNo: invoiceNo,),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Create order failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(nameScreen: "Checkout", suffixIcon: true),
      body: CheckoutBody(
        total: total,
        items: items,
        onContinue: (request) => _onContinue(context, request),
      ),
    );
  }
}
