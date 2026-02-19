import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';

import '../../../config/app_color.dart';

class CardBottom extends StatelessWidget {
  final double bottomGap;
  final double total;
  final Future<void> Function() onCheckout;
  const CardBottom({super.key, required this.bottomGap, this.total =0, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: bottomGap + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          EleButton(
            backgroundColor: AppColors.furnitureBlue,
            onPressed: onCheckout,
            child: Text(
              'CheckOut',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
