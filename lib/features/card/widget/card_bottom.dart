import 'package:flutter/material.dart';

import '../../../config/app_color.dart';

class CardBottom extends StatelessWidget {
  final double bottomGap;
  final double total;
  final Future<void> Function() onCheckout;
  const CardBottom({super.key, required this.bottomGap, this.total =0, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return
    Stack(
      children: [
        Positioned(
          bottom: bottomGap,
          left: 16,
          right: 16,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total: \$${total.toStringAsFixed(2)}", style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: onCheckout,
                  child: Text(
                    'CheckOut',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith( color: AppColors.primary),
                  ),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}
