
import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAdded;
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.isAdded = false
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isAdded? AppColors.secondaryGreen : Colors.grey.shade400,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 30,
          width: 30,
          child: Icon(
            icon,
            size: 20,
            color: isAdded? Colors.white : AppColors.gray500,
          ),
        ),
      ),
    );
  }
}
