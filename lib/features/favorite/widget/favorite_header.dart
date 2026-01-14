import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';

import '../../../config/app_color.dart';

class FavoriteHeader extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            backgroundColor: AppColors.glassDark,
            iconSize: 25,
            sizedY: 44,
            sizeX: 44,
            onTap: () {
              debugPrint("Tap back!");
            },
          ),
          CircleIconButton(
            icon: Icons.favorite_border,
            backgroundColor: AppColors.glassDark,
            iconSize: 25,
            sizedY: 44,
            sizeX: 44,
            onTap: () {
              debugPrint("Tap back!");
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
