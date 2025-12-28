import 'package:flutter/material.dart';
import 'package:fly/features/product_detail/widget/detail_footer.dart';
import '../widget/detail_body.dart';
import '../widget/detail_header.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  int count = 1;
  double price = 800;
  double amount = 800;

  @override
  Widget build(BuildContext context) {
    final double footerHeight = 150;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: DetailHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: footerHeight),
          child: DetailBody(price: price),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: footerHeight,
        child: DetailFooter(
          count: count,
          amount: amount,
          onAdded: () => setState(() {
            count++;
            amount = price * count;
          }),
          onRemoved: () => setState(() {
            if (count > 0) count--;
            amount = price * count;
          }),
        ),
      ),
    );
  }
}
