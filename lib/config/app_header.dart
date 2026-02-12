import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';

import 'app_color.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String nameScreen;
  const AppHeader({super.key, required this.nameScreen});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 20), child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nameScreen,  style: TextStyle(
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
      ),)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
