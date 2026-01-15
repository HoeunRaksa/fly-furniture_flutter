import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';

import '../../../config/app_color.dart';

class FavoriteHeader extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteHeader({super.key});
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            backgroundColor: AppColors.glassFillDark,
            iconSize: 25,
            sizedY: 44,
            sizeX: 44,
            onTap: () {
              debugPrint("Tap back!");
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                "My Favourite",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
