import 'package:flutter/cupertino.dart';
import 'package:fly/core/widgets/elevated_button.dart';

import '../../../config/app_color.dart';

class CheckoutBottom extends StatelessWidget {
  final Future<void> Function() onContinue;
  const CheckoutBottom({super.key, required this.onContinue});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: EleButton(
            onPressed: onContinue,
            name: "Continue",
            backgroundColor: AppColors.furnitureBlue,
          ),
        ),
      ],
    );
  }
}
