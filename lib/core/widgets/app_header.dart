import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_color.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String nameScreen;
  late bool suffixIcon;
  AppHeader({super.key, required this.nameScreen, this.suffixIcon = false});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (suffixIcon) ...[
              CircleIconButton(
                icon: Icons.arrow_back_ios,
                backgroundColor: AppColors.primary,
                iconSize: 25,
                sizedY: 44,
                sizeX: 44,
                onTap: () {
                  context.pop();
                },
              ),
            ],
            Text(
              nameScreen,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: AppColors.furnitureBlue,
              ),
            ),
            if (!suffixIcon)
              CircleIconButton(
                icon: Icons.search,
                backgroundColor: AppColors.primary,
                iconSize: 25,
                sizedY: 44,
                sizeX: 44,
                onTap: () {
                  debugPrint("Tap search!");
                },
              ),
            if (suffixIcon)
              Container(padding: EdgeInsets.zero, height: 44, width: 44),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
