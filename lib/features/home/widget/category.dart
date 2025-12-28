import 'package:flutter/material.dart';
import '../../../config/app_color.dart';

class Category extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;
  const Category({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });
  bool get isSelected => index == selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.secondaryGreen : Colors.white,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chair,
              color: isSelected
                  ? Colors.white
                  : AppColors.gray700.withAlpha(100),
            ),
            const SizedBox(width: 10),
            Text(
              "Chair",
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColors.gray700.withAlpha(100),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
