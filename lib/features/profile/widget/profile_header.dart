import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_color.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isSet;
  const ProfileHeader({super.key, this.isSet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => context.pop(),
            sizedY: 40,
            sizeX: 40,
          ),
          if (isSet == true)
            CircleIconButton(
              icon: Icons.settings,
              onTap: () {
                // Navigate to settings or show settings dialog
                debugPrint('Settings tapped');
              },
              sizedY: 40,
              sizeX: 40,
              iconColor: AppColors.woodOak,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}