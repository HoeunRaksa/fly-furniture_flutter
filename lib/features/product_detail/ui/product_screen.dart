import 'package:flutter/material.dart';
import 'package:fly/features/product_detail/widget/detail_footer.dart';
import '../widget/detail_body.dart';
import '../widget/detail_header.dart';
import '../../../model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product; // pass the product

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  int count = 1;
  late double amount;

  @override
  void initState() {
    super.initState();
    amount = widget.product.price; // initialize amount
  }

  @override
  Widget build(BuildContext context) {
    final double footerHeight = 150;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: DetailHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: footerHeight),
          child: DetailBody(product: widget.product),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: footerHeight,
        child: DetailFooter(
          count: count,
          amount: amount,
          onAdded: () => setState(() {
            count++;
            amount = widget.product.price * count;
          }),
          onRemoved: () => setState(() {
            if (count > 0) count--;
            amount = widget.product.price * count;
          }),
        ),
      ),
    );
  }
}
