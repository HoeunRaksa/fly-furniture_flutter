import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../core/widgets/circleIcon_button.dart';
import '../../../core/widgets/elevated_button.dart';

class DetailFooter extends StatelessWidget {
  final int count;
  final VoidCallback? onAdded;
  final VoidCallback? onRemoved;
  final double amount;
  const DetailFooter({
    super.key,
    this.count = 0,
    this.onAdded,
    this.onRemoved,
    this.amount = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:20, right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Colors.white, width: 1)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleIconButton(icon: Icons.remove, onTap: onRemoved!),
                  SizedBox(width: 10),
                  Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 10),
                  CircleIconButton(
                    icon: Icons.add,
                    onTap: onAdded!,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.secondaryGreen,
                  ),
                ],
              ),
              Text(
                "Price: \$${amount.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.zero,
            child: EleButton(name: "AddToCard", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
