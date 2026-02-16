import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../core/widgets/circleIcon_button.dart';
import '../../../core/widgets/elevated_button.dart';
import '../../../model/product.dart';

class DetailFooter extends StatelessWidget {
  final int count;
  final Product product;

  final VoidCallback onIncrease; // + button
  final VoidCallback onDecrease; // - button

  final Future<void> Function(Product product, int qty) onAddToCart; // Add button
  final double amount;

  const DetailFooter({
    super.key,
    required this.count,
    required this.product,
    required this.onIncrease,
    required this.onDecrease,
    required this.onAddToCart,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleIconButton(icon: Icons.remove, onTap: onDecrease),
                  const SizedBox(width: 10),
                  Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 10),
                  CircleIconButton(
                    icon: Icons.add,
                    onTap: onIncrease,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.bodyLine,
                  ),
                ],
              ),
              Text(
                "Price: \$${amount.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 20),
          EleButton(
            name: "AddToCard",
            onPressed: () async {
              final qtyToAdd = count == 0 ? 1 : count; // ✅ rule
              await onAddToCart(product, qtyToAdd);
            },
          ),
        ],
      ),
    );
  }
}
