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
          Text("Favorite",  style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: AppColors.furnitureBlue,
            height: 1.0,
          ),),
          CircleIconButton(
            icon: Icons.search,
            backgroundColor: AppColors.primary,
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
